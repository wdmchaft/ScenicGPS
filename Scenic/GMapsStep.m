//
//  GMapsStep.m
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsStep.h"
#import "GMapsCoordinate.h"
#import "GMapsPolyline.h"

static NSString* MODE_KEY = @"travel_mode";
static NSString* START_KEY = @"start_location";
static NSString* END_KEY = @"end_location";
static NSString* PL_KEY = @"polyline";
static NSString* SECONDS_KEY = @"duration";
static NSString* SECONDS_VALUE_KEY = @"value";
static NSString* METERS_KEY = @"distance";
static NSString* METERS_VALUE_KEY = @"value";
static NSString* INS_KEY = @"html_instructions";


@implementation GMapsStep
@synthesize end,mode,start,meters,seconds,polyline, instructions;

+(id) stepFromJSONDic: (NSDictionary*) dic {
    GMapsStep* step =  [[[GMapsStep alloc] init] autorelease];
    step.mode = (NSString*) [dic objectForKey:MODE_KEY];
    step.instructions = (NSString*) [dic objectForKey:INS_KEY];
    step.seconds = (NSNumber*) [(NSDictionary*) [dic objectForKey:SECONDS_KEY] objectForKey:SECONDS_VALUE_KEY];
    step.meters = (NSNumber*) [(NSDictionary*) [dic objectForKey:METERS_KEY] objectForKey:METERS_VALUE_KEY];
    step.start = [GMapsCoordinate coordFromJSONDic:(NSDictionary*) [dic objectForKey:START_KEY]];
    step.end = [GMapsCoordinate coordFromJSONDic:(NSDictionary*) [dic objectForKey:END_KEY]];
    step.polyline = [GMapsPolyline polylineFromJSONDic:(NSDictionary*) [dic objectForKey:PL_KEY]];
    return step;
}

@end
