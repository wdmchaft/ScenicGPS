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

@class ScenicRoute, ScenicContent, GMapsRoute, ScenicMapView;
@interface ScenicMapViewController : UIViewController <MKReverseGeocoderDelegate,MKMapViewDelegate, ScenicMapSelectorModelDelegate> {
    IBOutlet ScenicMapView* mapView;
	IBOutlet UISegmentedControl *mapType;
    ScenicMapSelectorModel* model;
    IBOutlet UIButton* toggleMapType;
    IBOutlet UIToolbar* mapTypeToolbar;
}



-(void)gotoLocation:(CLLocation *) location;
-(void) dataFetcher:(DataFetcher *)fetcher hasResponse:(id)response;
-(void) putNewRoutes: (NSArray*) routes;
-(void) drawRoutes;
-(void) addAnnotationsToMap;
-(void) refreshRouteDrawings;
-(void) createModel;
-(IBAction) hideToolbar: (id) sender;
-(IBAction) showToolbar: (id) sender;
-(IBAction) changeMapType: (id) sender;

@property (nonatomic, retain) IBOutlet ScenicMapView* mapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl* mapType;
@property (nonatomic, retain) ScenicMapSelectorModel* model;
@property (nonatomic, retain) IBOutlet UIButton* toggleMapType;
@property (nonatomic, retain) IBOutlet UIToolbar* mapTypeToolbar;
@end
