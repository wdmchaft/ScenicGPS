//
//  PanoramioFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/8/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicParkFetcher.h"
#import "GMapsCoordinate.h"



static NSString* RES_KEY = @"results";
static NSString* TYPE = @"park";


@implementation ScenicParkFetcher

-(id) getResponseFromResult:(id)result {
    NSDictionary* dic = (NSDictionary*) result;
    NSArray* res = (NSArray*) [dic objectForKey:RES_KEY];
    NSMutableArray* pts = [[NSMutableArray alloc] initWithCapacity:[res count]];
    for (NSDictionary* pt in res) {
        [pts addObject:[GMapsCoordinate coordFromJSONDic:pt]];
    }
    NSArray* ptArray = [NSArray arrayWithArray:pts];
    [pts release];
    return ptArray;
}




+(id) parkFetcherWithDelegate: (id<DataFetcherDelegate>) _delegate {
    NSDictionary* queries = [NSDictionary dictionaryWithObjectsAndKeys:nil];
    return [[[super alloc] initWithType:TYPE withQueries:queries andDelegate:_delegate] autorelease];
}

@end
