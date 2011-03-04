//
//  JSONFetcher.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"


@protocol JSONFetcherDelegate;
@class ASIHTTPRequest;
@interface JSONFetcher : NSObject <ASIHTTPRequestDelegate> {
    id<JSONFetcherDelegate> _delegate;
}


@property (assign, nonatomic) id<JSONFetcherDelegate> _delegate;


-(void) fetchURL: (NSString*) base withQueries: (NSDictionary*) dictionary;
-(NSURL*) urlFromBase: (NSString*) base andQueries: (NSDictionary*) dictionary;

- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;

@end

@protocol JSONFetcherDelegate <NSObject>

@optional

@required
- (void)fetcherFinished: (JSONFetcher*) fetcher withResult: (id) result;

@end