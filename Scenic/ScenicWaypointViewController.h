//
//  ScenicWaypointViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/14/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerPutter.h"

@protocol ScenicContentDelegate;

@class ScenicContentViewController, ScenicContent;
@interface ScenicWaypointViewController : UIViewController <ServerPutterDelegate> {
    ScenicContentViewController* mainVC;
    id<ScenicContentDelegate> delegate;
    NSString* toolTitle;
    
    UINavigationController * navigationController;
    
}

-(void) addWaypoint;
-(NSString*) getBackTitle;
-(void) voteWithRating: (int) rating;

- (void) editContent;
- (void) voteUp;
- (void) voteDown;

@property (nonatomic, retain) ScenicContentViewController* mainVC;
@property (nonatomic, assign)     id<ScenicContentDelegate> delegate;
@property (nonatomic, retain) NSString* toolTitle;
@property (nonatomic, retain) UINavigationController * navigationController;

@end

@protocol ScenicContentDelegate <NSObject>

-(void) addWaypointWithContent: (ScenicContent*) content;


@end