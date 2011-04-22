//
//  ServerGetter.h
//  Scenic
//
//  Created by Jack Reilly on 4/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcher.h"

@interface ServerGetter : DataFetcher {
    
}

+(id) serverGetterWithCommand: (NSString*) _command queries: (NSDictionary*) _queries delegate: (id<DataFetcherDelegate>) _delegate;

                                                                                                 

@end
