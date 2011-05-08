//
//  ServerGetter.m
//  Scenic
//
//  Created by Jack Reilly on 4/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ServerGetter.h"
#define debug NO


@implementation ServerGetter

static NSDictionary* commandLookup;
static NSString* preBase = @"http://www.scenicgps.com/scenic";
static NSString* debugBase = @"127.0.0.1:9880/scenic";

static NSString* STATUS_KEY = @"status";
static NSString* ERROR_KEY = @"error";
static NSString* RESPONSE_KEY = @"response";
static NSString* LAST_ROUTE_COMMAND = @"lastroute";
static NSString* LAST_ROUTE_LOC = @"lastroute";
static NSString* USER_PHOTO_COMMAND = @"getuserphotos";
static NSString* USER_PHOTO_LOC = @"nearby";


-(id) initWithCommand:(NSString *)_command andQueries:(NSDictionary *)_queries andDelegate:(id<DataFetcherDelegate>)_delegate {
    if ((self = [super initWithBase:[ServerGetter getBaseFromCommand:_command] andQueries:_queries andDelegate:_delegate])) {
        
    }
    return self;
}


+(NSDictionary*) commandLookup {
    if (!commandLookup)
        commandLookup = [[NSDictionary dictionaryWithObjectsAndKeys:LAST_ROUTE_LOC, LAST_ROUTE_COMMAND, USER_PHOTO_LOC,USER_PHOTO_COMMAND, nil] retain];
    return commandLookup;
}



-(id) getResponseFromResult:(id)result {
    NSDictionary* dict = (NSDictionary*) result;
    NSString* status =  (NSString*) [dict objectForKey:STATUS_KEY];
    if ([status isEqualToString:@"error"])
        return NO;
    return (NSDictionary*) [dict objectForKey:RESPONSE_KEY];
}

+(NSString*) getBaseFromCommand: (NSString*) command {
    NSString* server;
    if (debug)
        server = debugBase;
    else
        server = preBase;
    return [NSString stringWithFormat:@"%@/%@",server,[[ServerGetter commandLookup] objectForKey:command]];
}

+(id) serverGetterWithCommand: (NSString*) _command queries: (NSDictionary*) _queries delegate: (id<DataFetcherDelegate>) _delegate {
    NSString* base = [ServerGetter getBaseFromCommand:_command];
    ServerGetter* getter = [[[ServerGetter alloc] initWithCommand:base andQueries:_queries andDelegate:_delegate] autorelease];
    getter.delegate = _delegate;
    return getter;
}


@end
