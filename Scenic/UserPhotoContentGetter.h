//
//  UserPhotoContentGetter.h
//  Scenic
//
//  Created by Jack Reilly on 4/27/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerGetter.h"

@class GMapsCoordinate;
@interface UserPhotoContentGetter : ServerGetter {
    
}

+(UserPhotoContentGetter*) photoGetterWithDelegate: (id<DataFetcherDelegate>) delegate andCoordinate: (GMapsCoordinate*) coord;
-(id) getResponseFromResult:(id)result;
-(id) initWithCommand:(NSString *)_command andQueries:(NSDictionary *)_queries andDelegate:(id<DataFetcherDelegate>)_delegate ;

@end
