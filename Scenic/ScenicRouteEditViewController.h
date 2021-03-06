//
//  ScenicRouteEditViewController.h
//  Scenic
//
//  Created by Dan Lynch on 4/5/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDRoute;

@interface ScenicRouteEditViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>  {
    CDRoute * route;
    UITextField * rTitle;
    UITextField * desc;
    UIButton * delButton;
}

@property (nonatomic, retain) CDRoute * route;
@property (nonatomic, retain) IBOutlet UITextField * desc;
@property (nonatomic, retain) IBOutlet UIButton * delButton;
@property (nonatomic, retain) IBOutlet UITextField * rTitle;



- (id)initWithRoute:(CDRoute*)r;



- (IBAction) deleteCDRoute;
- (IBAction) updateFields; 

@end
