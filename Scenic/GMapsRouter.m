//
//  GMapsRouter.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsRouter.h"
#import "GMapsRoute.h"
#import "ScenicRoute.h"

static NSString* base = @"http://maps.googleapis.com/maps/api/directions/json";
static NSString* START_KEY = @"origin";
static NSString* END_KEY = @"destination";
static NSString* SENSOR_KEY = @"sensor";
static NSString* SENSOR_VALUE = @"false";
static NSString* ROUTES_KEY = @"routes";
static NSString* ALT_KEY = @"alternatives";
static NSString* ALT_VALUE = @"true";
static NSString* WP_KEY = @"waypoints";





@implementation GMapsRouter
@synthesize sRoute;

-(id) getResponseFromResult:(id)result {
    NSArray* routeArray = (NSArray*) [((NSDictionary*) result) objectForKey:ROUTES_KEY];
    NSMutableArray* routesTemp = [[NSMutableArray alloc] initWithCapacity:[routeArray count]];
    for (NSDictionary* routeDic in routeArray) {
        [routesTemp addObject:[GMapsRoute routeFromJSONDictionary: routeDic]];
    }
    NSArray* response = [NSArray arrayWithArray:routesTemp];
    [routesTemp release];
    self.sRoute.routes = response;
    return sRoute;
}

+(id) routeWithScenicRoute: (ScenicRoute*) route andDelegate: (id<DataFetcherDelegate>) _delegate {
    return [GMapsRouter routeWithStart:route.startRequest end:route.endRequest waypoints:route.waypointRequests withDelegate:_delegate];
}

+(id) routeWithStart: (NSString*) start end: (NSString*) end waypoints:(NSMutableArray*) waypoints withDelegate: (id<DataFetcherDelegate>) _delegate {
    ScenicRoute* temp = [[ScenicRoute alloc] init];
    temp.startRequest = start;
    temp.endRequest = end;
    NSDictionary* queries;
    if (waypoints == nil) {
        queries = [NSDictionary dictionaryWithObjectsAndKeys:start,START_KEY,end,END_KEY,SENSOR_VALUE,SENSOR_KEY,ALT_VALUE,ALT_KEY, nil];
    }
    else {
        temp.waypointRequests = waypoints;
        NSString* waypointValue = [NSString stringWithFormat:@"%@",
                                   [waypoints componentsJoinedByString:@"|"]];
        queries = [NSDictionary dictionaryWithObjectsAndKeys:start,START_KEY,end,END_KEY,SENSOR_VALUE,SENSOR_KEY,waypointValue,WP_KEY,ALT_VALUE,ALT_KEY, nil];
    }
    
    GMapsRouter* router =  [[[super alloc] initWithBase:base andQueries:queries andDelegate:_delegate] autorelease];
    router.sRoute = temp;
    [temp release];
    return router;
}

-(void) dealloc {
    [super dealloc];
    [sRoute release];
}

@end
