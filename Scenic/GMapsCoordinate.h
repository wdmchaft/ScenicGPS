//
//  GMapsCoordinate.h
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface GMapsCoordinate : NSObject <NSCoding>{
    NSNumber* lat;
    NSNumber* lng;
}

@property (nonatomic, retain) NSNumber* lat;
@property (nonatomic, retain) NSNumber* lng;


+(id) coordFromJSONDic: (NSDictionary*) dic;
-(NSString*) pairString;
+(GMapsCoordinate*) coordFromCLCoord:(CLLocationCoordinate2D) coordinate;
-(NSString*) pairString;
@end
