//
//  ScenicTripViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/28/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ScenicMapView.h"

@class ScenicTripModel, ScenicMapView;
@interface ScenicTripViewController : UIViewController <ScenicMapViewDelegate> {
    ScenicMapView* mMapView;
    ScenicTripModel* trip;
    
}

-(IBAction) takePicture: (id) sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model: (ScenicMapSelectorModel*) model;

@property (nonatomic, retain) IBOutlet ScenicMapView* mMapView;
@property (nonatomic, retain) ScenicTripModel* trip;

@end
