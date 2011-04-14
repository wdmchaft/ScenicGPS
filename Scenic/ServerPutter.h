//
//  ServerPutter.h
//  Scenic
//
//  Created by Jack Reilly on 4/13/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcher.h"

@protocol ServerPutterDelegate;
@interface ServerPutter : DataFetcher <DataFetcherDelegate> {
    id<ServerPutterDelegate> pDelegate;
}


@property (nonatomic, assign) id<ServerPutterDelegate> pDelegate;



+(NSDictionary*) commandLookup;
+(NSString*) getBaseFromCommand: (NSString*) command;
+(id) serverPutterWithCommand: (NSString*) _command queries: (NSDictionary*) _queries delegate: (id<ServerPutterDelegate>) _pDelegate;


@end

@protocol ServerPutterDelegate <NSObject>

-(void) putterHasError: (ServerPutter*) putter;


@end
