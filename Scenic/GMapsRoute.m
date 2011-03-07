//
//  GMapsRoute.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsRoute.h"
#import "GMapsLeg.h"
#import "GMapsPolyline.h"
#import "GMapsBounds.h"

static NSString* SUMMARY_KEY = @"summary";
static NSString* LEGS_KEY = @"legs";
static NSString* CR_KEY = @"copyrights";
static NSString* PL_KEY = @"overview_polyline";
static NSString* BOUNDS_KEY = @"bounds";



@implementation GMapsRoute
@synthesize summary, copyrights, bounds, polyline, legs;




+(id) routeFromJSONDictionary: (NSDictionary*) dic {
    NSString* dicSummary = [dic objectForKey:SUMMARY_KEY];
    GMapsRoute* newRoute = [[[super alloc] init] autorelease];
    newRoute.summary = dicSummary;
    
    NSArray* jsonLegs = (NSArray*) [dic objectForKey:LEGS_KEY];
    NSMutableArray* temp = [[NSMutableArray alloc] initWithCapacity:[jsonLegs count]];
    for (NSDictionary* legsDic in jsonLegs) {
        [temp addObject:[GMapsLeg legFromJSONDic: legsDic]];
    }
    newRoute.legs = [NSArray arrayWithArray:temp];
    [temp release];
    
    newRoute.polyline = [GMapsPolyline polylineFromJSONDic:(NSDictionary*) [dic objectForKey:PL_KEY ]];
    newRoute.copyrights = (NSString*) [dic objectForKey:CR_KEY];
    newRoute.bounds = [GMapsBounds boundsFromJSONDic:(NSDictionary*)  [dic objectForKey: BOUNDS_KEY]];
    
    return newRoute;
}

-(void) dealloc {
    [super dealloc];
    [summary release];
}
                              

@end