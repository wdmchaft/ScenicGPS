//
//  GMapsPolyline.m
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsPolyline.h"

static NSString* LEVELS_KEY = @"levels";
static NSString* POINTS_KEY = @"points";



@implementation GMapsPolyline
@synthesize levels, points;

+(id) polylineFromJSONDic: (NSDictionary*) dic {
    GMapsPolyline* pl =  [[[GMapsPolyline alloc] init] autorelease];
    pl.levels = (NSString*) [dic objectForKey:LEVELS_KEY];
    pl.points = (NSString*) [dic objectForKey:POINTS_KEY];
    return pl;
    
}
@end
