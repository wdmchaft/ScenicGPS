//
//  UserPhotoContent.h
//  Scenic
//
//  Created by Jack Reilly on 3/30/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicContent.h"

@interface UserPhotoContent : ScenicContent <ScenicContentProvider> {
    UIImage* photo;
}

@property (nonatomic, retain) UIImage* photo;
-(UIImage*)imageWithBorderFromImage:(UIImage*)source;
-(UIImage*) fetchImage;
+(id) contentWithPhoto: (UIImage*) photo andCoordinate: (GMapsCoordinate*) coord;
-(UIView*) provideView;
@end
