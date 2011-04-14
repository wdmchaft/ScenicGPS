//
//  ScenicTripModel.h
//  Scenic
//
//  Created by Jack Reilly on 3/28/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ScenicMapSelectorModel.h"
#import "ScenicRoute.h"


@class GMapsCoordinate;
@interface ScenicTripModel : ScenicMapSelectorModel {
    ScenicRoute* route;
    GMapsCoordinate* location;
}

+(id) modelFromModel: (ScenicMapSelectorModel*) model;
+(id) modelFromRoute: (ScenicRoute*) route;

@property (nonatomic, retain) ScenicRoute* route;
@property (nonatomic, retain) GMapsCoordinate* location;


@end
