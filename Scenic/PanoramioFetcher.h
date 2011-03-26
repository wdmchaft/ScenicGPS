//
//  PanoramioFetcher.h
//  Scenic
//
//  Created by Jack Reilly on 3/26/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcher.h"

@class GMapsCoordinate;
@interface PanoramioFetcher : DataFetcher {
    
}

-(id) getResponseFromResult:(id)result;

+(id) fetcherForCoord: (GMapsCoordinate*) coord andDelegate: (id<DataFetcherDelegate>) _delegate;

@end
