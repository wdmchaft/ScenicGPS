//
//  GMapsCoordinate.h
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GMapsCoordinate : NSObject {
    NSNumber* lat;
    NSNumber* lng;
}

@property (nonatomic, retain) NSNumber* lat;
@property (nonatomic, retain) NSNumber* lng;


+(id) coordFromJSONDic: (NSDictionary*) dic;

@end