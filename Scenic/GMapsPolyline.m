//
//  GMapsPolyline.m
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsPolyline.h"
#import "GMapsCoordinate.h"

static NSString* LEVELS_KEY = @"levels";
static NSString* POINTS_KEY = @"points";



@implementation GMapsPolyline
@synthesize levels, points;

+(id) polylineFromJSONDic: (NSDictionary*) dic {
    GMapsPolyline* pl =  [[[GMapsPolyline alloc] init] autorelease];
    pl.levels = (NSString*) [dic objectForKey:LEVELS_KEY];
    pl.points = [GMapsPolyline decodePolyLine: [NSMutableString stringWithString: (NSString*) [dic objectForKey:POINTS_KEY]]];
    return pl;
    
}


+(NSArray *)decodePolyLine: (NSMutableString *)encoded {
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        GMapsCoordinate* coord = [[GMapsCoordinate alloc] init];
        coord.lat = latitude;
        coord.lng = longitude;
        [array addObject:coord];
        //NSLog(@"%f,%f",[latitude floatValue],[longitude floatValue]);
        [coord release];
        [latitude release];
        [longitude release];
    }
    NSArray* ptArray = [NSArray arrayWithArray:array];
    [array release];
    return ptArray;
}


@end
