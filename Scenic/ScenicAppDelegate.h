//
//  ScenicAppDelegate.h
//  Scenic
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScenicAppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate> {
    UITabBarController* tabVC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController* tabVC;

@end
