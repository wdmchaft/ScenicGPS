//
//  CameraHelper.m
//  Scenic
//
//  Created by Dan Lynch on 4/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "CameraHelper.h"
#import "UserPhotoContent.h"
#import "ScenicMapView.h"
#import <QuartzCore/QuartzCore.h>
#import "DataUploader.h"

@implementation CameraHelper
@synthesize imgPicker, vc, cDelegate;


- (id) initWithViewController:(UIViewController*)_vc camDelegate: (id<CameraHelperDelegate>) _cDelegate {
    
    if ((self = [super init])) {
        UIImagePickerController* tmp = [[UIImagePickerController alloc] init];
        tmp.delegate = self;
        tmp.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            tmp.sourceType = UIImagePickerControllerSourceTypeCamera;
            tmp.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        } else {
            tmp.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        self.imgPicker = tmp;        
        [tmp release];
        self.cDelegate = _cDelegate;
        self.vc = _vc;
        
    }
    return self;
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureModeVideo) {

        CGSize size=CGSizeMake(picker.view.bounds.size.width,picker.view.bounds.size.height-100);
        UIGraphicsBeginImageContext(size);
        [picker.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        NSURL * loc = [info objectForKey:UIImagePickerControllerMediaURL];
        [cDelegate handleVideo:loc withIcon:viewImage];
    
    } else {
        [cDelegate handleImage: (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage]];
    }    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

-(void) takePicture {
    [vc presentModalViewController:self.imgPicker animated:YES];
}

- (void) dealloc {
    [super dealloc];
    [imgPicker release];
    [vc release];
    [cDelegate release];
}


@end
