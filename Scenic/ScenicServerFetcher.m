//
//  ScenicServerFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicServerFetcher.h"

static NSString* server_base = @"http://localhost:8080/WebApplication1/ScenicServlet";
static NSString* TYPE_KEY = @"req_type";

@implementation ScenicServerFetcher
@synthesize type;

-(id) initWithType: (NSString*) _type withQueries: (NSDictionary*) _queries andDelegate: (id<DataFetcherDelegate>) _delegate {
    if ((self = [super initWithBase:server_base andQueries:[ScenicServerFetcher newQueries: _type withOldQueries: _queries] andDelegate:_delegate])) {
        self.type = _type;
    }
    return self;
    
}

+(NSDictionary*) newQueries: (NSString*) _type withOldQueries: (NSDictionary*) old {
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_type,TYPE_KEY, nil];
    [dic addEntriesFromDictionary:old];
    NSDictionary* returnDic =  [NSDictionary dictionaryWithDictionary:dic];
    [dic release];
    return returnDic;
}

+(id) fetcherWithType: (NSString*) type withQueries: (NSDictionary*) queries andDelegate: (id<DataFetcherDelegate>) _delegate {
    NSMutableDictionary* newQueries = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:type, TYPE_KEY,nil] autorelease];
    [newQueries addEntriesFromDictionary:queries];
    return [[[super alloc] initWithBase:server_base andQueries:newQueries andDelegate:_delegate] autorelease];
}

@end
