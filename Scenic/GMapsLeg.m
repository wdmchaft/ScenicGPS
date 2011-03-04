//
//  GMapsLeg.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsLeg.h"
#import "GMapsGeolocation.h"
#import "GMapsStep.h"
#import "GMapsCoordinate.h"



static NSString* SECONDS_KEY = @"duration";
static NSString* SECONDS_VALUE_KEY = @"value";
static NSString* METERS_KEY = @"distance";
static NSString* METERS_VALUE_KEY = @"value";
static NSString* START_LOCATION_KEY = @"start_location";
static NSString* END_LOCATION_KEY = @"end_location";
static NSString* START_ADDRESS_KEY = @"start_address";
static NSString* END_ADDRESS_KEY = @"end_address";
static NSString* STEPS_KEY = @"steps";



@implementation GMapsLeg
@synthesize end, start, steps, meters, seconds, viaWaypoint;



+(id) legFromJSONDic: (NSDictionary*) dic {
    GMapsLeg* leg = [[[GMapsLeg alloc] init] autorelease];
    leg.seconds = (NSNumber*) [(NSDictionary*) [dic objectForKey:SECONDS_KEY] objectForKey:SECONDS_VALUE_KEY];
    leg.meters = (NSNumber*) [(NSDictionary*) [dic objectForKey:METERS_KEY] objectForKey:METERS_VALUE_KEY];
    NSDictionary* startDic = (NSDictionary*) [dic objectForKey:START_LOCATION_KEY];
    NSDictionary* endDic = (NSDictionary*) [dic objectForKey:END_LOCATION_KEY];
    leg.start = [GMapsGeolocation locationWithCoord:[GMapsCoordinate coordFromJSONDic:startDic] andTitle:(NSString*) [dic objectForKey:START_ADDRESS_KEY]];
    leg.end = [GMapsGeolocation locationWithCoord:[GMapsCoordinate coordFromJSONDic:endDic] andTitle:(NSString*) [dic objectForKey:END_ADDRESS_KEY]];
    NSArray* stepsJSON = (NSArray*) [dic objectForKey:STEPS_KEY];
    NSMutableArray* temp = [[NSMutableArray alloc] initWithCapacity:[stepsJSON count]];
    for (NSDictionary* step in stepsJSON) {
        [temp addObject:[GMapsStep stepFromJSONDic: step]];
    }
    leg.steps = temp;
    [temp release];
    return leg;
}

@end
