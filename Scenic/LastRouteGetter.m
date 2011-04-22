//
//  LastRouteGetter.m
//  Scenic
//
//  Created by Jack Reilly on 4/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "LastRouteGetter.h"
#import "GMapsPolyline.h"
static NSString* command = @"lastroute";
static NSString* ROUTE_KEY = @"plstring";



@implementation LastRouteGetter

-(id) getResponseFromResult:(id)result {
    id firstResponse = [super getResponseFromResult:result];
    if (firstResponse) {
        firstResponse = (NSDictionary*) firstResponse;
        return (NSString*) [firstResponse objectForKey:ROUTE_KEY];
    }
    return firstResponse;
}

+(LastRouteGetter*) lastRouteFetcherWithDelegate: (id<DataFetcherDelegate>) delegate {
    LastRouteGetter* getter = [LastRouteGetter serverGetterWithCommand:command queries:[NSDictionary dictionary] delegate:delegate];
    return getter;
}

@end
