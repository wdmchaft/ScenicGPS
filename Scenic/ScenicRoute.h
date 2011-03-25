//
//  ScenicRoute.h
//  Scenic
//
//  Created by Jack Reilly on 3/14/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GMapsRoute, ScenicContent;
@interface ScenicRoute : NSObject {
    GMapsRoute* gRoute;
    NSString* startRequest;
    NSString* endRequest;
    NSMutableArray* waypointRequests;
    NSMutableArray* scenicContents;
}

@property (nonatomic, retain) GMapsRoute* gRoute;
@property (nonatomic, retain) NSString* startRequest;
@property (nonatomic, retain) NSString* endRequest;
@property (nonatomic, retain) NSMutableArray* waypointRequests;
@property (nonatomic, retain) NSMutableArray* scenicContents;


+(id) routeWithScenicRoute: (ScenicRoute*) route andGMapsRoute: (GMapsRoute*) _gRoute;

-(void) addContent: (ScenicContent*) content;
-(void) removeContent: (ScenicContent*) content;

@end
