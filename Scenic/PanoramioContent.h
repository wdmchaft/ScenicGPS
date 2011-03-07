//
//  PanoramioContent.h
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicContentProvider.h"

@interface PanoramioContent : NSObject <ScenicContentProvider> {
    NSURL* url;
}

@property(nonatomic, retain) NSURL* url;

@end
