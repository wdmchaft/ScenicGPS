//
//  DataUploader.h
//  Scenic
//
//  Created by Dan Lynch on 4/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@class UserPhotoContent;
@interface DataUploader : NSObject <ASIHTTPRequestDelegate> {
    UserPhotoContent* content;
    
}

@property (nonatomic, retain) UserPhotoContent* content;

-(void) uploadUserContent: (UserPhotoContent*) _content;
-(void) uploadUserContent: (UserPhotoContent*) _content withVideo: (NSURL*) video;


@end
