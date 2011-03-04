//
//  GMapsGeolocation.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMapsCoordinate;
@interface GMapsGeolocation : NSObject {
    NSString* title;
    GMapsCoordinate* coord;
}

@property (nonatomic, retain) NSString* title;
@property(nonatomic, retain) GMapsCoordinate* coord;


-(id) initWithLat: (NSNumber*) _lat andLng: (NSNumber*) _lng andTitle: (NSString*) _title;

+(id) locationWithCoord: (GMapsCoordinate*) _coord andTitle: (NSString*) _title;

@end
