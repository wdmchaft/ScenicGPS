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

@class ScenicTripModel, ScenicMapView;
@interface ScenicTripViewController : UIViewController <ScenicMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ServerPutterDelegate> {
    ScenicMapView* mMapView;
    ScenicTripModel* trip;
    UIImagePickerController* imgPicker;
    
}

-(IBAction) takePicture: (id) sender;
-(IBAction) rateRoute: (id) sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model: (ScenicMapSelectorModel*) model;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil route: (ScenicRoute*) route;

-(void) handleImage: (UIImage*) image;
-(void) initImagePicker;

@property (nonatomic, retain) IBOutlet ScenicMapView* mMapView;
@property (nonatomic, retain) ScenicTripModel* trip;
@property (nonatomic, retain) UIImagePickerController* imgPicker;

@end
