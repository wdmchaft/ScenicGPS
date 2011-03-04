//
//  DataFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "DataFetcher.h"


@implementation DataFetcher
@synthesize fetcher, delegate, base, queries;

-(id) initWithBase: (NSString*) _base andQueries: (NSDictionary*) _queries andDelegate: (id<DataFetcherDelegate>) _delegate {
    if ((self = [super init])) {
        self.base = _base;
        self.queries = _queries;
        self.delegate = _delegate;        
    }
    return self;
}

-(void) fetch {
    JSONFetcher* temp = [[JSONFetcher alloc] init];
    self.fetcher = temp;
    [temp release];
    fetcher._delegate = self;
    [fetcher fetchURL:base withQueries:queries];
}


-(id) getResponseFromResult: (id) result {
    return result;
}


-(void) fetcherFinished:(JSONFetcher *)_fetcher withResult:(id)result {
    id response = [self getResponseFromResult:result];
    [delegate dataFetcher:self hasResponse:response];
    
}

-(void) dealloc {
    [super dealloc];
    [base release];
    [queries release];
}

@end
