//
//  ServerPutter.m
//  Scenic
//
//  Created by Jack Reilly on 4/13/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ServerPutter.h"


static NSString* preBase = @"http://www.scenicgps.com/scenic";
static NSString* STATUS_KEY = @"status";
static NSString* ERROR_KEY = @"error";
static NSString* ROUTE_COMMAND = @"route";
static NSString* ROUTE_LOC = @"putroute";
static NSString* PLACE_COMMAND = @"place";
static NSString* PLACE_LOC = @"rateplace";

static NSDictionary* commandLookup;


@implementation ServerPutter
@synthesize pDelegate;


+(NSDictionary*) commandLookup {
    if (!commandLookup)
        commandLookup = [[NSDictionary dictionaryWithObjectsAndKeys:ROUTE_LOC,ROUTE_COMMAND, PLACE_LOC, PLACE_COMMAND, nil] retain];
    return commandLookup;
}



-(id) getResponseFromResult:(id)result {
    NSDictionary* dict = (NSDictionary*) result;
    return (NSString*) [dict objectForKey:STATUS_KEY];
}

-(void) dataFetcher:(DataFetcher *)fetcher hasResponse:(id)response {
    NSString* status = (NSString*) response;
    if ([status isEqualToString:ERROR_KEY]) {
        [self.pDelegate putterHasError:self];
    }
}


+(NSString*) getBaseFromCommand: (NSString*) command {
    return [NSString stringWithFormat:@"%@/%@",preBase,[[ServerPutter commandLookup] objectForKey:command]];
}

+(id) serverPutterWithCommand: (NSString*) _command queries: (NSDictionary*) _queries delegate: (id<ServerPutterDelegate>) _pDelegate {
    NSString* base = [ServerPutter getBaseFromCommand:_command];
    ServerPutter* putter = [[[ServerPutter alloc] initWithBase:base andQueries:_queries andDelegate:nil] autorelease];
    putter.delegate = putter;
    putter.pDelegate = _pDelegate;
    return putter;
}

@end
