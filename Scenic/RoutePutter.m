//
//  RoutePutter.m
//  Scenic
//
//  Created by Jack Reilly on 4/13/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "RoutePutter.h"
#import "GMapsPolyline.h"

static NSString* PL_KEY = @"plstring";
static NSString* RATING_KEY = @"rating";



@implementation RoutePutter


+(id) putterWithPL: (GMapsPolyline*) pl rating: (int) rating andDelegate: (id<ServerPutterDelegate>) _pDelegate {
    NSDictionary* qs = [NSDictionary dictionaryWithObjectsAndKeys:pl.plString,PL_KEY,[NSString stringWithFormat:@"%i",rating],RATING_KEY, nil];
    return [RoutePutter serverPutterWithCommand:@"route" queries:qs delegate:_pDelegate];
}

@end
