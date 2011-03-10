#import <Foundation/Foundation.h>
#import "DataFetcher.h"

@class GMapsCoordinate;
@interface ScenicParkFetcher : DataFetcher {
    
}


+(id) parkFetcherWithDelegate: (id<DataFetcherDelegate>) _delegate;


@end