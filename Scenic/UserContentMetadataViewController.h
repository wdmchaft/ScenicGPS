//
//  UserContentMetadataViewController.h
//  Scenic
//
//  Created by Dan Lynch on 4/27/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScenicContent;
@interface UserContentMetadataViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate> {

    ScenicContent * content;
    
}

- (IBAction) editUserContent;
- (IBAction) deleteUserContent;


@end
