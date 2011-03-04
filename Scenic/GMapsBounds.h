//
//  GMapsBounds.h
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMapsCoordinate;
@interface GMapsBounds : NSObject {
    GMapsCoordinate* sw;
    GMapsCoordinate* ne;
    
}


@property (nonatomic, retain) GMapsCoordinate* sw;
@property (nonatomic, retain) GMapsCoordinate* ne;

+(id) boundsFromJSONDic: (NSDictionary*) dic;


@end
