//
//  ScenicMapViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//


// thanks for the tips on this site for using geo coder and MKMap
// http://blog.objectgraph.com/index.php/2009/04/03/iphone-sdk-30-playing-with-map-kit-part-2/

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import "ScenicWaypointViewController.h"
#import "GMapsRouter.h"
#import "ScenicMapSelectorModel.h"
#import "ScenicMapView.h"
#import "CameraHelper.h"

@class ScenicRoute, ScenicContent, GMapsRoute;
@interface ScenicMapViewController : UIViewController <ScenicMapViewDelegate, CameraHelperDelegate> {
    IBOutlet ScenicMapView* mMapView;
	IBOutlet UISegmentedControl *mapType;
    IBOutlet UIToolbar* mapTypeToolbar;
    int routeNum;
    NSArray* _routes;
    CameraHelper * camera;
}


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil routes:(NSArray*) routes;
-(void)gotoLocation:(CLLocation *) location;

-(IBAction) changeMapType: (id) sender;
-(IBAction) nextRoute: (id) sender;
-(IBAction) prevRoute: (id) sender;
//-(void) updateRoutePicker;

- (IBAction) queryRoutesAlongRoute: (id) sender;
- (IBAction) queryRoutes: (id) sender;
-(IBAction) takePicture: (id) sender;

-(void) updateTitle;
-(void) addTripButton;

@property (nonatomic, retain) IBOutlet ScenicMapView* mMapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl* mapType;
@property (nonatomic, retain) IBOutlet UIToolbar* mapTypeToolbar;
@property (nonatomic, retain)     NSArray* _routes;
@property (nonatomic, assign) int routeNum;

@property (nonatomic, retain) CameraHelper* camera;

@end