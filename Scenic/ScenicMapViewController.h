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


@class GMapsRoute;
@interface ScenicMapViewController : UIViewController <MKReverseGeocoderDelegate,MKMapViewDelegate> {
    MKMapView* mapView;
	MKPlacemark *mPlacemark;
	UISegmentedControl *mapType;
    
}

-(void) setRoute: (GMapsRoute*) route;
- (void)changeType;

@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) MKPlacemark* mPlacemark;
@property (nonatomic, retain) UISegmentedControl* mapType;
@end
