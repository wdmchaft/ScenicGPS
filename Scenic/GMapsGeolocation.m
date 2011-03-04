//
//  GMapsGeolocation.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsGeolocation.h"


@implementation GMapsGeolocation
@synthesize lat, lng, title;

-(id) initWithLat: (NSNumber*) _lat andLng: (NSNumber*) _lng andTitle: (NSString*) _title {
    if ((self = [super init])) {
        self.lat = _lat;
        self.lng = _lng;
        self.title = _title;
    }
    return self;
}

-(void) dealloc {
    [super dealloc];
    [lat release];
    [lng release];
    [title release];
}

@end
