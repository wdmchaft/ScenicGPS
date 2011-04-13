//
//  PanoramioViewController.h
//  Scenic
//
//  Created by Jack Reilly on 4/5/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PanoramioContent;
@interface PanoramioViewController : UIViewController {
    UIImageView* photo;
    PanoramioContent* content;
}

@property (nonatomic, retain) IBOutlet UIImageView* photo;
@property (nonatomic, retain) IBOutlet PanoramioContent* content;
@end
