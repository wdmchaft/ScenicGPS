//
//  GMapsRouter.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMapsGeolocator.h"

@interface GMapsRouter : DataFetcher {

}

+(id) routeWithStart: (NSString*) start end: (NSString*) end waypoints:(NSArray*) waypoints withDelegate: (id<DataFetcherDelegate>) _delegate;


@end
