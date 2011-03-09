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

<<<<<<< HEAD
@class MKMapView, GMapsRoute;
@interface ScenicMapViewController : UIViewController {
    MKMapView* map;
}

@property (nonatomic, retain) MKMapView* map;
-(void) setRoute: (GMapsRoute*) route;
=======

@interface ScenicMapViewController : UIViewController <MKReverseGeocoderDelegate,MKMapViewDelegate> {
    MKMapView* _mapView;
    MKReverseGeocoder *geoCoder;
	MKPlacemark *mPlacemark;
	UISegmentedControl *mapType;
    
}

- (void)changeType;

@property (nonatomic, retain) MKMapView* mapView;

>>>>>>> 76febd0910fc43c67359abce750daf4635f78323
@end
