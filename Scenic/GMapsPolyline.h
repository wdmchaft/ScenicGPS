//
//  GMapsPolyline.h
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GMapsPolyline : NSObject <NSCoding>{
    NSArray* points;
    NSString* levels;
    NSString* plString;
}

@property (nonatomic, retain) NSArray* points;
@property (nonatomic, retain) NSString* levels;
@property (nonatomic, retain) NSString* plString;

+(id) polylineFromJSONDic: (NSDictionary*) dic;
+(NSArray *)decodePolyLine: (NSMutableString *)encoded;

@end
