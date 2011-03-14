//
//  ScenicWaypointViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/14/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScenciContentDelegate;
@class ScenicContentViewController, ScenicContent;
@interface ScenicWaypointViewController : UIViewController {
    ScenicContentViewController* mainVC;
    id<ScenciContentDelegate> delegate;
}

-(void) addWaypoint;

@property (nonatomic, retain) ScenicContentViewController* mainVC;
@property (nonatomic, assign)     id<ScenciContentDelegate> delegate;


@end

@protocol ScenciContentDelegate <NSObject>

-(void) addWaypointWithContent: (ScenicContent*) content;

@end