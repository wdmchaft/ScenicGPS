//
//  GMapsGeolocation.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GMapsGeolocation : NSObject {
    NSNumber* lat;
    NSNumber* lng;
    NSString* title;
}

@property (nonatomic, retain) NSNumber* lat;
@property (nonatomic, retain) NSNumber* lng;
@property (nonatomic, retain) NSString* title;


-(id) initWithLat: (NSNumber*) _lat andLng: (NSNumber*) _lng andTitle: (NSString*) _title;

@end
