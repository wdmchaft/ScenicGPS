//
//  GMapsRoute.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsRoute.h"

static NSString* SUMMARY_KEY = @"summary";


@implementation GMapsRoute
@synthesize summary;




+(id) routeFromJSONDictionary: (NSDictionary*) dic {
    NSString* dicSummary = [dic objectForKey:SUMMARY_KEY];
    GMapsRoute* newRoute = [[[super alloc] init] autorelease];
    newRoute.summary = dicSummary;
    return newRoute;
}

-(void) dealloc {
    [super dealloc];
    [summary release];
}
                              

@end
