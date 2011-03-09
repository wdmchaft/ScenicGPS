//
//  PanoramioFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/8/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PanoramioFetcher.h"
#import "GMapsCoordinate.h"


static NSString* base = @"http://localhost:8080/WebApplication1/ScenicServlet";
static NSString* LAT_KEY = @"lat";
static NSString* LNG_KEY = @"lng";


@implementation PanoramioFetcher




+(id) panDicFromCoord:(GMapsCoordinate*) coord withDelegate: (id<DataFetcherDelegate>) _delegate{
    NSDictionary* queries = [NSDictionary dictionaryWithObjectsAndKeys:[coord.lat description], LAT_KEY,
                             [coord.lng description], LNG_KEY,nil];
    return [[[super alloc] initWithBase:base andQueries:queries andDelegate:_delegate] autorelease];
}

@end
