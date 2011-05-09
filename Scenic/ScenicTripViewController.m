//
//  ScenicTripViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/28/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicTripViewController.h"
#import "ScenicTripModel.h"
#import "UserPhotoContent.h"
#import "CDHelper.h"
#import "PicView.h"

@implementation ScenicTripViewController
@synthesize mMapView, trip, camera, uploader;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model: (ScenicMapSelectorModel*) model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.trip = [ScenicTripModel modelFromModel:model];
        camera = [[CameraHelper alloc] initWithViewController:self camDelegate:self];
        uploader = [[DataUploader alloc] init];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil route: (ScenicRoute*) route
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.trip = [ScenicTripModel modelFromRoute:route];
        camera = [[CameraHelper alloc] initWithViewController:self camDelegate:self];
        uploader = [[DataUploader alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [camera release];
    [trip release];
    [mMapView release];
    [uploader release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mMapView.navigationController = self.navigationController;
    self.mMapView.model = self.trip;
    self.mMapView.scenicDelegate = self;
    [self.mMapView updateRoutesOnMap];
    
}

#pragma mark -
#pragma mark CameraHelper Delgate

-(void) handleVideo: (NSURL * ) video withIcon:(UIImage *)icon {
    UserPhotoContent* content = [UserPhotoContent contentWithPhoto:icon andCoordinate:[GMapsCoordinate coordFromCLCoord:mMapView.model.locationManager.location.coordinate] andCLHeading:mMapView.model.locationManager.heading];
    [mMapView addUserContent:content];
    [uploader uploadUserContent:content withVideo:video];
} 


-(void) handleImage: (UIImage*) image {
    UserPhotoContent* content = [UserPhotoContent contentWithPhoto:image andCoordinate:[GMapsCoordinate coordFromCLCoord:self.mMapView.model.locationManager.location.coordinate] andCLHeading:mMapView.model.locationManager.heading];
    [self.mMapView addUserContent:content];
    [uploader uploadUserContent:content];
    //[[CDHelper sharedHelper] storePhoto: image];
}


#pragma mark - 

-(void) scenicMapViewUpdatedRoutes {
    return;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 
#pragma mark IBActions

-(IBAction) takePicture: (id) sender {
    [camera takePicture];    
}

-(IBAction) rateRouteUp: (id) sender {
    int rating = 1;
    RoutePutter* putter = [RoutePutter putterWithPL:[self.mMapView.model primaryRoute].gRoute.polyline rating:rating andDelegate:self];
    [putter fetch];
}

-(IBAction) rateRouteDown: (id) sender {
    int rating = -1;
    RoutePutter* putter = [RoutePutter putterWithPL:[self.mMapView.model primaryRoute].gRoute.polyline rating:rating andDelegate:self];
    [putter fetch];
}

- (IBAction) slideShow:(id)sender  {
    
    PicView * picviewer = [[[PicView alloc] initWithFrame:[[UIScreen mainScreen] bounds] withScenicContents: mMapView.model.scenicContents] autorelease];
    UIViewController * vc = [[[UIViewController alloc] init] autorelease];
    vc.view = picviewer;
    [self.navigationController pushViewController: vc animated:YES];
    
}

#pragma mark - 
#pragma mark ServerPutter Delegate

-(void) putterHasError:(ServerPutter *)putter {
    NSLog(@"%@",[putter description]);
}

@end
