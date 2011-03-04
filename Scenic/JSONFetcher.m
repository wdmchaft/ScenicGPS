//
//  JSONFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "JSONFetcher.h"
#import "ASIHTTPRequest.h"
#import "CJSONDeserializer.h"

@implementation JSONFetcher
@synthesize _delegate;

-(void) fetchURL: (NSString*) base withQueries: (NSDictionary*) dictionary {
    NSURL* url = [self urlFromBase:base andQueries:dictionary];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
}

-(NSURL*) urlFromBase: (NSString*) base andQueries: (NSDictionary*) dictionary {
    NSString* urlString = [NSString stringWithString:base];
    NSString* flag = @"?";
    NSString* value;
    NSEnumerator *enumerator = [dictionary keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        value = [dictionary objectForKey:key];
        urlString = [urlString stringByAppendingFormat:@"%@%@=%@",
                     flag,[key stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                     [value stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        flag = @"&";
    }
    return [NSURL URLWithString:urlString];
}


- (void)requestFinished:(ASIHTTPRequest *)request {
    NSData* data = [request responseData];
    CJSONDeserializer* deserializer = [CJSONDeserializer deserializer];
    NSDictionary* dic = [deserializer deserializeAsDictionary:data error:nil];
    [_delegate fetcherFinished:self withResult:dic];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    return;
}

@end
