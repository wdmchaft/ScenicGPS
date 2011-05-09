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
#import "RoutePutter.h"
#import "CameraHelper.h"
#import "DataUploader.h"

@class ScenicTripModel, ScenicMapView;
@interface ScenicTripViewController : UIViewController <ScenicMapViewDelegate, ServerPutterDelegate, CameraHelperDelegate> {
    IBOutlet ScenicMapView* mMapView;
    ScenicTripModel* trip;
    CameraHelper* camera;
    DataUploader* uploader;
}

-(IBAction) takePicture: (id) sender;

-(IBAction) rateRouteDown: (id) sender;
-(IBAction) rateRouteUp: (id) sender;
- (IBAction) slideShow: (id) sender;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model: (ScenicMapSelectorModel*) model;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil route: (ScenicRoute*) route;

@property (nonatomic, retain) IBOutlet ScenicMapView* mMapView;
@property (nonatomic, retain) ScenicTripModel* trip;
@property (nonatomic, retain) CameraHelper* camera;
@property (nonatomic, retain) DataUploader* uploader;

@end
