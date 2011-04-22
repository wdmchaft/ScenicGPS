//
//  GMapsBounds.m
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsBounds.h"
#import "GMapsCoordinate.h"
#import "ScenicMapView.h"

static NSString* NE_KEY = @"northeast";
static NSString* SW_KEY = @"southwest";


@implementation GMapsBounds
@synthesize ne,sw;


+(id) boundsFromMapView:(ScenicMapView*) mMapView {
    
    CGPoint nePoint = CGPointMake(mMapView.bounds.origin.x + mMapView.bounds.size.width, mMapView.bounds.origin.y);
   
    CGPoint swPoint = CGPointMake((mMapView.bounds.origin.x), (mMapView.bounds.origin.y + mMapView.bounds.size.height));

    CLLocationCoordinate2D neCoord;
    neCoord = [mMapView convertPoint:nePoint toCoordinateFromView:mMapView];
    CLLocationCoordinate2D swCoord;
    swCoord = [mMapView convertPoint:swPoint toCoordinateFromView:mMapView];

    
    GMapsCoordinate * coord1 = [GMapsCoordinate coordFromCLCoord: neCoord];
    GMapsCoordinate * coord2 = [GMapsCoordinate coordFromCLCoord: swCoord];
    GMapsBounds * bounds = [[[GMapsBounds alloc] init] autorelease];
    bounds.ne = coord1;
    bounds.sw = coord2;
    return bounds;
}

+(id) boundsFromJSONDic: (NSDictionary*) dic {
    GMapsBounds* bounds =  [[[GMapsBounds alloc] init] autorelease];
    bounds.ne = [GMapsCoordinate coordFromJSONDic:(NSDictionary*) [dic objectForKey:NE_KEY]];
    bounds.sw = [GMapsCoordinate coordFromJSONDic:(NSDictionary*) [dic objectForKey:SW_KEY]];
    return bounds;
    
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.ne];
    [aCoder encodeObject:self.sw];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.ne = [aDecoder decodeObject];
        self.sw = [aDecoder decodeObject];
    }
    return self;
}

@end
