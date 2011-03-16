//
//  PanoramioPicFetcher.h
//  Scenic
//
//  Created by Jack Reilly on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicServerFetcher.h"

@class GMapsCoordinate;
@interface PanoramioPicFetcher : ScenicServerFetcher {
    
}

+(id) panDicFromCoord:(GMapsCoordinate*) coord withDelegate: (id<DataFetcherDelegate>) _delegate;

@end
