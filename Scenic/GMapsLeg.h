//
//  GMapsLeg.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMapsPoint, GMapsGeolocation;
@interface GMapsLeg : NSObject <NSCoding>{
    NSArray* steps;
    NSNumber* seconds;
    NSNumber* meters;
    GMapsGeolocation* start;
    GMapsGeolocation* end;
    NSArray* viaWaypoint;
}

@property (nonatomic, retain) NSArray* steps;
@property (nonatomic, retain) NSNumber* seconds;
@property (nonatomic, retain) NSNumber* meters;
@property (nonatomic, retain) GMapsGeolocation* start;
@property (nonatomic, retain) GMapsGeolocation* end;
@property (nonatomic, retain) NSArray* viaWaypoint;

+(id) legFromJSONDic: (NSDictionary*) dic;


@end
