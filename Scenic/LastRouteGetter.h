//
//  LastRouteGetter.h
//  Scenic
//
//  Created by Jack Reilly on 4/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerGetter.h"


@interface LastRouteGetter : ServerGetter {
    
}

+(LastRouteGetter*) lastRouteFetcherWithDelegate: (id<DataFetcherDelegate>) delegate;

-(id) getResponseFromResult:(id)result;
@end
