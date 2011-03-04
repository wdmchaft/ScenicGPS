//
//  GMapsStep.h
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMapsCoordinate, GMapsPolyline;
@interface GMapsStep : NSObject {
    NSString* mode;
    NSNumber* seconds;
    NSNumber* meters;
    NSString* instructions;
    GMapsCoordinate* start;
    GMapsCoordinate* end;
    GMapsPolyline* polyline;
    
    
    
}


@property (nonatomic, retain) NSString* mode;
@property (nonatomic, retain) NSNumber* seconds;
@property (nonatomic, retain) NSNumber* meters;
@property (nonatomic, retain) NSString* instructions;
@property (nonatomic, retain) GMapsCoordinate* start;
@property (nonatomic, retain) GMapsCoordinate* end;
@property (nonatomic, retain) GMapsPolyline* polyline;

+(id) stepFromJSONDic: (NSDictionary*) dic;

@end
