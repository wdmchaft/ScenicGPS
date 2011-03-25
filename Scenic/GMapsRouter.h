//
//  GMapsRouter.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMapsGeolocator.h"

@class ScenicRoute;
@interface GMapsRouter : DataFetcher {
    NSArray* sRoutes;
    

}

@property (nonatomic, retain) ScenicRoute* sRoute;

+(id) routeWithStart: (NSString*) start end: (NSString*) end scenicContents: (NSMutableArray*) scenicContents scenicWaypoints:(NSMutableArray*) waypoints withDelegate: (id<DataFetcherDelegate>) _delegate;
+(id) routeWithScenicRoute: (ScenicRoute*) route andDelegate: (id<DataFetcherDelegate>) _delegate;


@end
