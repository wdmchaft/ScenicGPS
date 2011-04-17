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
#import "CDHelper.h"

@implementation ScenicMapViewController
@synthesize mMapView, mapType, mapTypeToolbar, routeNum, _routes;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil routes:(NSArray*) routes {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.hidesBottomBarWhenPushed = YES;
        self._routes = routes;
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



//-(void) updateRoutePicker {
//    int nRoutes = [self.mMapView.model.routes count];
//    if (nRoutes < 2) {
//        self.routePicker.hidden = YES;
//        return;
//    }
//    self.routePicker.hidden = NO;
//    int oldNRoutes = self.routePicker.numberOfSegments;
//    int difference = oldNRoutes - nRoutes;
//    if (difference == 0) return;
//    if (difference > 0) {
//        for (int i = 0; i < difference; i++) {
//            [self.routePicker removeSegmentAtIndex:self.routePicker.numberOfSegments - 1 animated:YES];
//        }
//        return;
//    }
//    for (int i = 0; i > difference; i--) {
//        [self.routePicker insertSegmentWithTitle:[NSString stringWithFormat:@"%i",self.routePicker.numberOfSegments+1] atIndex:self.routePicker.numberOfSegments animated:YES];
//    }
//    self.routePicker.selectedSegmentIndex = 0;
//    return;
//    
//}

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
}

@end
