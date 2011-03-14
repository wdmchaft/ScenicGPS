//
//  GMapsCoordinate.m
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsCoordinate.h"

static NSString* LAT_KEY = @"lat";
static NSString* LNG_KEY = @"lng";
@implementation GMapsCoordinate
@synthesize lat, lng;


+(id) coordFromJSONDic: (NSDictionary*) dic {
    GMapsCoordinate* coord = [[[GMapsCoordinate alloc] init] autorelease];
    coord.lat = (NSNumber*) [dic objectForKey:LAT_KEY];
    coord.lng = (NSNumber*) [dic objectForKey:LNG_KEY];
    return coord;
    
}

-(NSString*) pairString {
    return [NSString stringWithFormat:@"%f,%f",[self.lat doubleValue],[self.lng doubleValue]];
}

+(GMapsCoordinate*) coordFromCLCoord: (CLLocationCoordinate2D)coordinate {
    GMapsCoordinate* newCoord = [[GMapsCoordinate alloc] init];
    newCoord.lat = [NSNumber numberWithDouble:coordinate.latitude];
    newCoord.lng = [NSNumber numberWithDouble:coordinate.longitude];
    return [newCoord autorelease];
}

@end
