//
//  UserPhotoContentGetter.m
//  Scenic
//
//  Created by Jack Reilly on 4/27/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "UserPhotoContentGetter.h"
#import "GMapsPolyline.h"
#import "UserPhotoContent.h"
static NSString* command = @"getuserphotos";
static NSString* PHOTOS_KEY = @"photos";



@implementation UserPhotoContentGetter

-(id) initWithCommand:(NSString *)_command andQueries:(NSDictionary *)_queries andDelegate:(id<DataFetcherDelegate>)_delegate {
    if ((self = [super initWithCommand:_command andQueries:_queries andDelegate:_delegate])) {
        
    }
    return self;
}

-(id) getResponseFromResult:(id)result {
    id firstResponse = [super getResponseFromResult:result];
    if (firstResponse) {
        firstResponse = (NSDictionary*) firstResponse;
        NSArray* photos = (NSArray*) [firstResponse objectForKey:PHOTOS_KEY];
        NSMutableArray* contents = [NSMutableArray arrayWithCapacity:[photos count]];
        for (NSDictionary* dic in photos) {
            [contents addObject:[UserPhotoContent contentFromJSONDic: dic]];
        }
        return [NSArray arrayWithArray:contents];
    }
    return nil;
}

+(UserPhotoContentGetter*) photoGetterWithDelegate: (id<DataFetcherDelegate>) delegate {
    UserPhotoContentGetter* getter = [[[UserPhotoContentGetter alloc] initWithCommand:command andQueries:[NSDictionary dictionary] andDelegate:delegate] autorelease];
    return getter;
}

@end