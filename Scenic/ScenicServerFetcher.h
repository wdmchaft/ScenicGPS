//
//  ScenicServerFetcher.h
//  Scenic
//
//  Created by Jack Reilly on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcher.h"

@interface ScenicServerFetcher : DataFetcher {
    NSString* type;
}

@property (nonatomic, retain) NSString* type;

-(id) initWithType: (NSString*) _type withQueries: (NSDictionary*) queries andDelegate: (id<DataFetcherDelegate>) _delegate;
+(NSDictionary*) queries: (NSString*) _type withOldQueries: (NSDictionary*) old;


@end
