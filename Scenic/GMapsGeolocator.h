//
//  Gmaps.h
//  Scenic
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcher.h"

@class ASIHTTPRequest, DataFetcher;
@protocol GMapsGeolocatorDelegate;
@interface GMapsGeolocator : DataFetcher {
    
}

+(id) geolocatorWithAddress: (NSString*) description withDelegate: (id<DataFetcherDelegate>) _delegate;

@end