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

@implementation CameraHelper
@synthesize imgPicker, vc, cDelegate;


- (id) initWithViewController:(UIViewController*)_vc camDelegate: (id<CameraHelperDelegate>) _cDelegate {
    
    if ((self = [super init])) {
        UIImagePickerController* tmp = [[UIImagePickerController alloc] init];
        tmp.delegate = self;
        tmp.allowsEditing = YES;
        tmp.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            tmp.sourceType = UIImagePickerControllerSourceTypeCamera;
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
    
    if (picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureModeVideo) {
        NSURL * loc = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"a video: %@", [loc description]);
        
        CGSize sixzevid=CGSizeMake(picker.view.bounds.size.width,picker.view.bounds.size.height-100);
        UIGraphicsBeginImageContext(sixzevid);
        [picker.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [cDelegate handleImage: viewImage];
        
    
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
