//
//  DataFetcher.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONFetcher.h"

@class JSONFetcher;
@protocol DataFetcherDelegate;
@interface DataFetcher : NSObject <JSONFetcherDelegate> {
    JSONFetcher* fetcher;
    id<DataFetcherDelegate> delegate;
    NSString* base;
    NSDictionary* queries;
}

@property (nonatomic, retain) JSONFetcher* fetcher;
@property (nonatomic, assign) id<DataFetcherDelegate> delegate;
@property (nonatomic, retain) NSString* base;
@property (nonatomic, retain) NSDictionary* queries;

-(id) getResponseFromResult: (id) result;
-(void) fetcherFinished:(JSONFetcher *)_fetcher withResult:(id)result;
-(id) initWithBase: (NSString*) _base andQueries: (NSDictionary*) _queries andDelegate: (id<DataFetcherDelegate>) _delegate;
-(void) fetch;
@end

@protocol DataFetcherDelegate <NSObject>


-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response;

@end
