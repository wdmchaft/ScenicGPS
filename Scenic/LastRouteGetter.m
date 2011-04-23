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

-(id) initWithCommand:(NSString *)_command andQueries:(NSDictionary *)_queries andDelegate:(id<DataFetcherDelegate>)_delegate {
    if ((self = [super initWithCommand:_command andQueries:_queries andDelegate:_delegate])) {
        
    }
    return self;
}

-(id) getResponseFromResult:(id)result {
    id firstResponse = [super getResponseFromResult:result];
    if (firstResponse) {
        firstResponse = (NSDictionary*) firstResponse;
        return (NSString*) [firstResponse objectForKey:ROUTE_KEY];
    }
    return firstResponse;
}

+(LastRouteGetter*) lastRouteFetcherWithDelegate: (id<DataFetcherDelegate>) delegate {
    LastRouteGetter* getter = [[[LastRouteGetter alloc] initWithCommand:command andQueries:[NSDictionary dictionary] andDelegate:delegate] autorelease];
    return getter;
}

@end
