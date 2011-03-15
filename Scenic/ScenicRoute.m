//
//  ScenicRoute.m
//  Scenic
//
//  Created by Jack Reilly on 3/14/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicRoute.h"


@implementation ScenicRoute

@synthesize routes, endRequest, startRequest, waypointRequests;

-(id) init {
    if ((self = [super init])) {
        NSMutableArray* temp = [[NSMutableArray alloc] init];
        self.waypointRequests = temp;
        [temp release];
    }
    return self;
}

@end
