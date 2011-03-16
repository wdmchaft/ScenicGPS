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
#import "ScenicLocationCLController.h"
#import "ScenicWaypointViewController.h"
#import "GMapsRouter.h"

@class ScenicRoute, ScenicContent, GMapsRoute;
@interface ScenicMapViewController : UIViewController <MKReverseGeocoderDelegate,MKMapViewDelegate, ScenicLocationCLControllerDelegate, ScenciContentDelegate, DataFetcherDelegate> {
    MKMapView* mapView;
	MKPlacemark *mPlacemark;
	UISegmentedControl *mapType;
    
    ScenicLocationCLController * locationController;
    CLLocation * currentLocation;
    
    // for anotations
    //ScenicViewController *scenicViewController;
    NSMutableArray *mapAnnotations;
    ScenicRoute* scenicRoute;
    GMapsRoute* currentRoute;
    NSArray* secondaryRoutes;
    
}

+ (CGFloat)annotationPadding;
+ (CGFloat)calloutHeight;

-(void) putScenicRoute: (ScenicRoute*) route;
-(void) putCurrentRoute: (GMapsRoute*) route;
-(void) putScenicRoutes: (NSArray*) sRoutes;

- (void)changeType;

- (void)locationUpdate:(CLLocation *)location; 
- (void)locationError:(NSError *)error;

- (void)gotoLocation:(CLLocation *) location;

-(void) addWaypointWithContent:(ScenicContent*)content;

-(void) dataFetcher:(DataFetcher *)fetcher hasResponse:(id)response;



-(void) drawRoute: (GMapsRoute*) route asPrimary: (BOOL) isPrimary;
-(void) putSecondaryRoutes: (NSArray*) secRoutes;
@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) MKPlacemark* mPlacemark;
@property (nonatomic, retain) UISegmentedControl* mapType;
@property (nonatomic, retain) CLLocation * currentLocation;
@property (nonatomic, retain) ScenicLocationCLController * locationController;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) GMapsRoute* currentRoute;
@property (nonatomic, retain) ScenicRoute* scenicRoute;
@property (nonatomic, retain) NSArray* secondaryRoutes;


@end
