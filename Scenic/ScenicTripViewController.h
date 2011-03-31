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
@interface ScenicTripViewController : UIViewController <ScenicMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    ScenicMapView* mMapView;
    ScenicTripModel* trip;
    UIImagePickerController* imgPicker;
    
}

-(IBAction) takePicture: (id) sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model: (ScenicMapSelectorModel*) model;

-(void) handleImage: (UIImage*) image;
-(void) initImagePicker;

@property (nonatomic, retain) IBOutlet ScenicMapView* mMapView;
@property (nonatomic, retain) ScenicTripModel* trip;
@property (nonatomic, retain) UIImagePickerController* imgPicker;

@end
