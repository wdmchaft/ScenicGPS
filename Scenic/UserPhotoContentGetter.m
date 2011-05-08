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
#import "GMapsCoordinate.h"
#import "GeoHash.h"

static NSString* command = @"getuserphotos";
static NSString* PHOTOS_KEY = @"photos";
static NSString* NPICS_VAL = @"10";
static NSString* NPICS_KEY = @"npics";
static NSString* HASH_KEY = @"geohash";



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

+(UserPhotoContentGetter*) photoGetterWithDelegate: (id<DataFetcherDelegate>) delegate andCoordinate: (GMapsCoordinate*) coord {
    UserPhotoContentGetter* getter = [[[UserPhotoContentGetter alloc] initWithCommand:command andQueries:[NSDictionary dictionaryWithObjectsAndKeys:NPICS_VAL,NPICS_KEY, [GeoHash hash:CLLocationCoordinate2DMake([coord.lat doubleValue], [coord.lng doubleValue])],HASH_KEY, nil] andDelegate:delegate] autorelease];
    return getter;
}

@end