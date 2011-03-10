//
//  ParkFetcher.h
//  Scenic
//
//  Created by Jack Reilly on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicServerFetcher.h"

@interface ScenicParkFetcher : ScenicServerFetcher {
    
}

+(id) parkFetcherWithDelegate: (id<DataFetcherDelegate>) _delegate;

@end
