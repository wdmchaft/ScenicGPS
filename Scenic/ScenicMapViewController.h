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

@class ScenicRoute, ScenicContent, GMapsRoute;
@interface ScenicMapViewController : UIViewController <ScenicMapViewDelegate> {
    IBOutlet ScenicMapView* mMapView;
	IBOutlet UISegmentedControl *mapType;
    IBOutlet UISegmentedControl *routePicker;
    IBOutlet UIToolbar* mapTypeToolbar;
    NSArray* _routes;
}


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil routes:(NSArray*) routes;
-(void)gotoLocation:(CLLocation *) location;

-(IBAction) changeMapType: (id) sender;
-(IBAction) changeRoute: (id) sender;
-(void) updateRoutePicker;

-(void) setInitialRoutes: (NSArray*) routes;
-(void) updateTitle;
-(void) addTripButton;

@property (nonatomic, retain) IBOutlet ScenicMapView* mMapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl* mapType;
@property (nonatomic, retain) IBOutlet UIToolbar* mapTypeToolbar;
@property (nonatomic, retain) IBOutlet UISegmentedControl* routePicker;
@property (nonatomic, retain)     NSArray* _routes;
@end