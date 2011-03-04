//
//  GMapsRouter.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsRouter.h"
#import "GMapsRoute.h"

static NSString* base = @"http://maps.googleapis.com/maps/api/directions/json";
static NSString* START_KEY = @"origin";
static NSString* END_KEY = @"destination";
static NSString* SENSOR_KEY = @"sensor";
static NSString* SENSOR_VALUE = @"false";
static NSString* ROUTES_KEY = @"routes";
static NSString* ALT_KEY = @"alternatives";
static NSString* ALT_VALUE = @"true";




@implementation GMapsRouter

-(id) getResponseFromResult:(id)result {
    NSArray* routeArray = (NSArray*) [((NSDictionary*) result) objectForKey:ROUTES_KEY];
    NSMutableArray* routesTemp = [[NSMutableArray alloc] initWithCapacity:[routeArray count]];
    for (NSDictionary* routeDic in routeArray) {
        [routesTemp addObject:[GMapsRoute routeFromJSONDictionary: routeDic]];
    }
    NSArray* response = [NSArray arrayWithArray:routesTemp];
    [routesTemp release];
    return response;
}

+(id) routeWithStart: (NSString*) start andEnd: (NSString*) end withDelegate: (id<DataFetcherDelegate>) _delegate {
    
    NSDictionary* queries = [NSDictionary dictionaryWithObjectsAndKeys:start,START_KEY,end,END_KEY,SENSOR_VALUE,SENSOR_KEY,ALT_VALUE,ALT_KEY, nil];
    return [[[super alloc] initWithBase:base andQueries:queries andDelegate:_delegate] autorelease];
}

@end
