#import <Foundation/Foundation.h>
#import "DataFetcher.h"

@class GMapsCoordinate;
@interface PanoramioPicFetcher : DataFetcher {
    
}


+(id) panDicFromCoord:(GMapsCoordinate*) coord withDelegate: (id<DataFetcherDelegate>) _delegate;


@end