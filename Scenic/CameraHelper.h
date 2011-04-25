//
//  CameraHelper.h
//  Scenic
//
//  Created by Dan Lynch on 4/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScenicMapView;

@protocol CameraHelperDelegate;

@interface CameraHelper : NSObject  <UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    UIImagePickerController* imgPicker;
    UIViewController * vc;
    id<CameraHelperDelegate> cDelegate;
}

- (id) initWithViewController:(UIViewController*)_vc camDelegate: (id<CameraHelperDelegate>) _cDelegate;
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker ;
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info ;
-(void) takePicture;

@property (nonatomic, retain) UIImagePickerController* imgPicker;
@property (nonatomic, retain) UIViewController* vc;
@property (nonatomic, retain) id<CameraHelperDelegate> cDelegate;

@end


@protocol CameraHelperDelegate <NSObject>
@required
-(void) handleImage: (UIImage*) image; 
-(void) handleVideo: (NSURL*) video withIcon: (UIImage*) icon;
@end
