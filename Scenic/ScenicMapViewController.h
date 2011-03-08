//
//  ScenicMapViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface ScenicMapViewController : UIViewController <MKMapViewDelegate> {
	MKMapView* _mapView;
    
}

@property (nonatomic, retain) MKMapView* mapView;

@end
