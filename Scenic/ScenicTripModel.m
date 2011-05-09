//
//  ScenicTripModel.m
//  Scenic
//
//  Created by Jack Reilly on 3/28/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicTripModel.h"


@implementation ScenicTripModel
@synthesize route, location;

+(id) modelFromModel: (ScenicMapSelectorModel*) model {
    ScenicTripModel* tripModel = [[model copy] autorelease];
    tripModel.routes = [NSArray arrayWithObject:[tripModel primaryRoute]];
    tripModel.primaryRouteIndex = 0;
    tripModel.frozen = YES;
    [tripModel.locationManager startUpdatingHeading];
    return tripModel;
}

+(id) modelFromRoute: (ScenicRoute*) route {
    ScenicTripModel* tripModel = [[[ScenicTripModel alloc] init] autorelease];
    tripModel.routes = [[[NSArray alloc] initWithObjects:route, nil] autorelease];
    tripModel.primaryRouteIndex = 0;
    tripModel.frozen = YES;
    return tripModel;
}


@end
