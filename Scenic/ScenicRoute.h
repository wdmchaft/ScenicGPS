//
//  ScenicRoute.h
//  Scenic
//
//  Created by Jack Reilly on 3/14/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMapsRoute;
@interface ScenicRoute : NSObject {
    GMapsRoute* gRoute;
    NSString* startRequest;
    NSString* endRequest;
    NSArray* waypointRequests;
}

@property (nonatomic, retain) GMapsRoute* gRoute;
@property (nonatomic, retain) NSString* startRequest;
@property (nonatomic, retain) NSString* endRequest;
@property (nonatomic, retain) NSArray* waypointRequests;


@end
