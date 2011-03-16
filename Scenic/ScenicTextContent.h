//
//  ScenicTextContent.h
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicContent.h"

@class GMapsCoordinate;
@interface ScenicTextContent : ScenicContent {
    
}

+(id) contentWithTitle: (NSString*) t subTitle: (NSString*) st coordinate: (GMapsCoordinate*) _coord;

@end
