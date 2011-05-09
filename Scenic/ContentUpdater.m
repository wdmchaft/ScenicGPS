//
//  ContentUpdatePutter.m
//  Scenic
//
//  Created by Jack Reilly on 5/8/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ContentUpdater.h"
#import "UserPhotoContent.h"

static NSString* TITLE_KEY = @"title";
static NSString* PK_KEY = @"pk";
static NSString* UPDATE_COMMAND = @"update";


#define i2s(x) [NSString stringWithFormat:@"%i",x]
#define i2f(x) [NSString stringWithFormat:@"%f",x]

@implementation ContentUpdater

-(id) initWithBase:(NSString *)_base andQueries:(NSDictionary *)_queries andDelegate:(id<DataFetcherDelegate>)_delegate {
    if ((self = [super initWithBase:_base andQueries:_queries andDelegate:_delegate])) {
        
    }
    return self;
}

+(id) updaterWithContent: (UserPhotoContent*) content andDelegate: (id<ServerPutterDelegate>) _pDelegate{
    return  [ContentUpdater serverPutterWithCommand:UPDATE_COMMAND queries:[ContentUpdater contentQueries:content] delegate:_pDelegate];
}

+(NSDictionary*) contentQueries: (UserPhotoContent*) content {
    return [NSDictionary dictionaryWithObjectsAndKeys:content.title, TITLE_KEY, i2s(content.pk),PK_KEY, nil];
}

@end
