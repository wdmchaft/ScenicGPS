//
//  PlacePutter.h
//  Scenic
//
//  Created by Dan Lynch on 4/17/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerPutter.h"

@class ScenicContent;
@interface ContentRater : ServerPutter {
    
}

+(NSString*) command;
+(NSDictionary*) queriesWithContent: (ScenicContent*) content andRating: (int) rating;
+(id) putterWithContent: (ScenicContent*) content rating: (int) rating andDelegate: (id<ServerPutterDelegate>) _pDelegate;

@end
