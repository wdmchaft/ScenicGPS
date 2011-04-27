//
//  ScenicMapViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapViewController.h"
#import <MapKit/MapKit.h>
#import "GMapsRoute.h"
#import "GMapsRouter.h"
#import "ScenicMapView.h"
#import "ScenicRoute.h"
#import "ScenicTripViewController.h"
#import "GMapsPolyline.h"
#import "CDHelper.h"
#import "UserPhotoContent.h"
#import "DataUploader.h"

#define COORD(x) [[mMapView.model primaryRoute].gRoute.polyline.points objectAtIndex:x]
#define COORDS [mMapView.model primaryRoute].gRoute.polyline.points

@implementation ScenicMapViewController
@synthesize mMapView, mapType, mapTypeToolbar, routeNum, _routes, camera, uploader;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil routes:(NSArray*) routes {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.hidesBottomBarWhenPushed = YES;
        self._routes = routes;
        camera = [[CameraHelper alloc] initWithViewController:self camDelegate:self];
        uploader = [[DataUploader alloc] init];
    }
    return self;
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    [self addTripButton];
    self.mMapView.navigationController = self.navigationController;
    self.mMapView.scenicDelegate = self;
    [self.mMapView setInitialRoutes:self._routes];
    [self._routes release];
}

-(void) handleVideo: (NSURL * ) video withIcon:(UIImage *)icon {
    [uploader uploadFile:video];
    UserPhotoContent* content = [UserPhotoContent contentWithPhoto:icon andCoordinate:[GMapsCoordinate coordFromCLCoord:mMapView.model.locationManager.location.coordinate]];
    [mMapView addUserContent:content];

} 

-(void) handleImage: (UIImage*) image {
    
    UserPhotoContent* content = [UserPhotoContent contentWithPhoto:image andCoordinate:[GMapsCoordinate coordFromCLCoord:mMapView.model.locationManager.location.coordinate]];
    [mMapView addUserContent:content];
    [uploader uploadUserContent:content];
    
    //[[CDHelper sharedHelper] storePhoto: image];
    
}

-(void) addTripButton {
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Start Trip" style:UIBarButtonItemStyleBordered target:self action:@selector(startTrip:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
}


-(void) scenicMapViewUpdatedRoutes {
    [self updateTitle];
}

-(IBAction) changeMapType: (id) sender {
    switch (self.mapType.selectedSegmentIndex) {
        case 0:
            self.mMapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mMapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mMapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

-(void) startTrip: (id) sender {
    ScenicTripViewController* tripVC = [[ScenicTripViewController alloc] initWithNibName:@"ScenicTripViewController" bundle:nil model:self.mMapView.model];
    [self.navigationController pushViewController:tripVC animated:YES];
    [tripVC release];
    [[CDHelper sharedHelper] saveRoute:[self.mMapView.model primaryRoute]];
}

-(IBAction) nextRoute: (id) sender {
    int nRoutes = [self.mMapView.model.routes count];
    routeNum = (routeNum+1) % nRoutes;
    [self.mMapView changeToRouteNumber:routeNum];
}

-(IBAction) prevRoute: (id) sender {
    int nRoutes = [self.mMapView.model.routes count];
    if (nRoutes==0) return;
    routeNum = (routeNum-1) % nRoutes;
    if (routeNum < 0) {
        routeNum = nRoutes - 1;
    }
    [self.mMapView changeToRouteNumber:routeNum];
}

- (IBAction) takePicture: (id) sender {
    [camera takePicture];
}

- (IBAction) queryRoutes: (id) sender {
    [mMapView.model fetchNewContentWithBounds:[GMapsBounds boundsFromMapView:mMapView]];
}

- (IBAction) queryRoutesAlongRoute: (id) sender {
         

    for (int i=0; i<[COORDS count]; i+=50) {
        GMapsCoordinate * coord = COORD(i);
        NSLog(@"query along route: (%@, %@)", coord.lat, coord.lng) ;
                
        [mMapView.model fetchNewContentWithCoord:COORD(i)];        
        
    }
    
    
}


- (void)changeType {
	if(mapType.selectedSegmentIndex==0){
		mMapView.mapType=MKMapTypeStandard;
	}
	else if (mapType.selectedSegmentIndex==1){
		mMapView.mapType=MKMapTypeSatellite;
	}
	else if (mapType.selectedSegmentIndex==2){
		mMapView.mapType=MKMapTypeHybrid;
	}
}

-(void) updateTitle {
    self.title = [self.mMapView.model primaryRoute].gRoute.summary;
}


- (void)gotoLocation:(CLLocation *) location{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = location.coordinate.latitude;
    newRegion.center.longitude = location.coordinate.longitude;
    newRegion.span.latitudeDelta = 0.1;
    newRegion.span.longitudeDelta = 0.1;
    [self.mMapView setRegion:newRegion animated:YES];
}

- (void)dealloc
{
    [super dealloc];
    [mMapView release];
    [camera release];
    [uploader release];
    [_routes release];
    [mapType release];
    [mapTypeToolbar release];
}

@end
