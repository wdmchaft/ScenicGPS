//
//  GMapsGeolocation.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsGeolocation.h"
#import "GMapsCoordinate.h"

@implementation GMapsGeolocation
@synthesize title, coord;

-(id) initWithLat: (NSNumber*) _lat andLng: (NSNumber*) _lng andTitle: (NSString*) _title {
    if ((self = [super init])) {
        GMapsCoordinate* _coord = [[GMapsCoordinate alloc] init];
        _coord.lat = _lat;
        _coord.lng = _lng;
        self.coord = _coord;
        [_coord release];
        self.title = _title;
    }
    return self;
}

+(id) locationWithCoord: (GMapsCoordinate*) _coord andTitle: (NSString*) _title {
    GMapsGeolocation* loc = [[[GMapsGeolocation alloc] init] autorelease];
    loc.title = _title;
    loc.coord = _coord;
    return loc;
}

-(void) dealloc {
    [super dealloc];
    [coord release];
    //[title release];
}

@end
