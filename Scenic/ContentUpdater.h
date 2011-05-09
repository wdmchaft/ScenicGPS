//
//  ContentUpdatePutter.h
//  Scenic
//
//  Created by Jack Reilly on 5/8/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerPutter.h"

@class UserPhotoContent;
@interface ContentUpdater : ServerPutter {
    
}



+(id) updaterWithContent: (UserPhotoContent*) content andDelegate: (id<ServerPutterDelegate>) _pDelegate;
+(NSDictionary*) contentQueries: (UserPhotoContent*) content;


@end
