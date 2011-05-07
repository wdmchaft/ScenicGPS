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
    CLHeading * heading;
}

-(UIImage*)imageWithBorderFromImage:(UIImage*)source;
-(UIImage*) fetchImage;
-(UIView*) provideView;

+(id) contentWithPhoto: (UIImage*) photo andCoordinate: (GMapsCoordinate*) coord andCLHeading: (CLHeading*) h;
+(id) contentFromJSONDic: (NSDictionary*) dic;

@property (nonatomic, retain) UIImage* photo;
@property (nonatomic, retain) CLHeading * heading;

@end
