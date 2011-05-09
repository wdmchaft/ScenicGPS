//
//  ScenicContentViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScenicContent, ScenicContentDisplayViewController;
@interface ScenicContentViewController : UIViewController  {
    IBOutlet ScenicContentDisplayViewController* displayVC;
    IBOutlet UILabel* titleLabel;
    ScenicContent* content;
}

@property (nonatomic, retain) ScenicContent* content;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet ScenicContentDisplayViewController* displayVC;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContent: (ScenicContent*) _content;

@end
