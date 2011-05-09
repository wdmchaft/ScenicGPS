//
//  UserContentMetadataViewController.h
//  Scenic
//
//  Created by Dan Lynch on 4/27/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerPutter.h"

@class ScenicContent;
@interface UserContentMetadataViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, ServerPutterDelegate> {

    ScenicContent * content;
    IBOutlet UITextField * name;
    
}

- (IBAction) editUserContent;
- (IBAction) deleteUserContent;

@property (nonatomic, retain) IBOutlet UITextField * name;
@property (nonatomic, retain) ScenicContent * content;

@end
