//
//  ScenicTripModel.h
//  Scenic
//
//  Created by Jack Reilly on 3/28/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class GMapsCoordinate, ScenicRoute;
@interface ScenicTripModel : NSObject {
    ScenicRoute* route;
    GMapsCoordinate* location;
}

@property (nonatomic, retain) ScenicRoute* route;
@property (nonatomic, retain) GMapsCoordinate* location;


@end
