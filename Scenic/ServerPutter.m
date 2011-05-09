//
//  ServerPutter.m
//  Scenic
//
//  Created by Jack Reilly on 4/13/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ServerPutter.h"


static NSString* preBase = @"http://www.scenicgps.com/scenic";
static NSString* debugBase = @"127.0.0.1:9880/scenic";
static NSString* STATUS_KEY = @"status";
static NSString* ERROR_KEY = @"error";
static NSString* ROUTE_COMMAND = @"route";
static NSString* ROUTE_LOC = @"putroute";
static NSString* PLACE_COMMAND = @"place";
static NSString* PLACE_LOC = @"rateplace";
static NSString* PAN_COMMAND = @"panrate";
static NSString* PAN_LOC = @"panrate";
static NSString* CONTENT_COMMAND = @"content";
static NSString* CONTENT_LOC = @"photorate"; ///CHANGE BACK TO panrate later!
static NSString* UCONTENT_COMMAND = @"photorate";
static NSString* UCONTENT_LOC = @"photorate";
static NSString* UPDATE_COMMAND = @"update";
static NSString* UPDATE_LOC = @"photoupdate";




static NSDictionary* commandLookup;


@implementation ServerPutter
@synthesize pDelegate;


+(NSDictionary*) commandLookup {
    if (!commandLookup)
        commandLookup = [[NSDictionary dictionaryWithObjectsAndKeys:ROUTE_LOC,ROUTE_COMMAND, PLACE_LOC, PLACE_COMMAND, PAN_LOC, PAN_COMMAND, CONTENT_LOC, CONTENT_COMMAND,UCONTENT_LOC, UCONTENT_COMMAND,UPDATE_LOC, UPDATE_COMMAND, nil] retain];
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
    NSString* server;
    BOOL debug = NO;
    if (debug)
        server = debugBase;
    else
        server = preBase;
    return [NSString stringWithFormat:@"%@/%@",server,[[ServerPutter commandLookup] objectForKey:command]];
}


+(id) serverPutterWithCommand: (NSString*) _command queries: (NSDictionary*) _queries delegate: (id<ServerPutterDelegate>) _pDelegate {
    NSString* base = [ServerPutter getBaseFromCommand:_command];
    ServerPutter* putter = [[[ServerPutter alloc] initWithBase:base andQueries:_queries andDelegate:nil] autorelease];
    putter.delegate = putter;
    putter.pDelegate = _pDelegate;
    return putter;
}

@end
