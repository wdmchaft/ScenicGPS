//
//  PlacePutter.m
//  Scenic
//
//  Created by Dan Lynch on 4/17/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PlacePutter.h"

@class GMapsCoordinate;

static NSString* LAT_KEY = @"lat";
static NSString* LNG_KEY = @"lng";
static NSString* RATING_KEY = @"rating";
static NSString* DEVICE_KEY = @"device";


#define i2s(x) [NSString stringWithFormat:@"%i",x]
#define i2f(x) [NSString stringWithFormat:@"%f",x]

@implementation PlacePutter

+(id) putterWithCoords: (GMapsCoordinate*) coord rating: (int) rating andDelegate: (id<ServerPutterDelegate>) _pDelegate {
    
    NSDictionary* qs = [NSDictionary dictionaryWithObjectsAndKeys:i2f([coord.lat doubleValue]), LAT_KEY, i2f([coord.lng doubleValue]), LNG_KEY,i2s(rating),RATING_KEY, [[UIDevice currentDevice] uniqueIdentifier], DEVICE_KEY, nil];
    return [PlacePutter serverPutterWithCommand:@"place" queries:qs delegate:_pDelegate];
}

@end
