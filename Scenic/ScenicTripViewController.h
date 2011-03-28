//
//  ScenicTripViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/28/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class ScenicTripModel;
@interface ScenicTripViewController : UIViewController {
    MKMapView* mMapView;
    ScenicTripModel* trip;
    
}

@property (nonatomic, retain) IBOutlet MKMapView* mMapView;
@property (nonatomic, retain) ScenicTripModel* trip;

@end
