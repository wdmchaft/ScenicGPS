//
//  PanoramioContent.h
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicContentProvider.h"
#import "ScenicContent.h"

@interface PanoramioContent : ScenicContent <ScenicContentProvider> {
    NSURL* url;
    UIImage* image;
}

@property(nonatomic, retain) NSURL* url;
@property(nonatomic, retain) UIImage* image;
-(UIImage*) fetchImage;

+(NSArray*) contentsFromJSONDic: (NSDictionary*) dic;

- (UIImage*)imageWithBorderFromImage:(UIImage*)source;
@end
