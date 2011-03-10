//
//  PanoramioPicFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PanoramioPicFetcher.h"
#import "GMapsCoordinate.h"

static NSString* TYPE = @"panoramio";
static NSString* LAT_KEY = @"lat";
static NSString* LNG_KEY = @"lng";


@implementation PanoramioPicFetcher


+(id) panDicFromCoord:(GMapsCoordinate*) coord withDelegate: (id<DataFetcherDelegate>) _delegate {
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[coord.lat description],LAT_KEY,[coord.lng description],LNG_KEY, nil];
    return [[[super alloc] initWithType:TYPE withQueries:dic andDelegate:_delegate] autorelease];
}

@end
