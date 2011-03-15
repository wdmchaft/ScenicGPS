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
    NSArray* routes;
    NSString* startRequest;
    NSString* endRequest;
    NSMutableArray* waypointRequests;
}

@property (nonatomic, retain) NSArray* routes;
@property (nonatomic, retain) NSString* startRequest;
@property (nonatomic, retain) NSString* endRequest;
@property (nonatomic, retain) NSMutableArray* waypointRequests;


@end
