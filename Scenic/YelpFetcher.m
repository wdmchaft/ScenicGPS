//
//  YelpFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "YelpFetcher.h"
#import "GMapsCoordinate.h"

static NSString* TYPE = @"yelp";
static NSString* LAT_KEY = @"lat";
static NSString* LNG_KEY = @"long";


@implementation YelpFetcher

+(id) fetcherForCoord: (GMapsCoordinate*) coord andDelegate: (id<DataFetcherDelegate>) _delegate {
    return [[[super alloc] initWithType:TYPE withQueries:[NSDictionary dictionaryWithObjectsAndKeys:[coord.lat description],LAT_KEY,[coord.lng description],LNG_KEY, nil] andDelegate:_delegate] autorelease];
}

@end
