//
//  ScenicContentTextVC.h
//  Scenic
//
//  Created by Jack Reilly on 3/12/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenicContentProvider.h"

@interface ScenicContentTextVC : UIViewController <ScenicContentProvider> {
    UILabel* descriptionLabel;
    NSString* description;
    
}

@property (nonatomic, retain) IBOutlet UILabel* descriptionLabel;
@property (nonatomic, retain) NSString* description;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andDescription: (NSString*) _description;

@end
