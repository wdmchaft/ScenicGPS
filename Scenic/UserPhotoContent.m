//
//  UserPhotoContent.m
//  Scenic
//
//  Created by Jack Reilly on 3/30/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "UserPhotoContent.h"
#import "GMapsCoordinate.h"


@implementation UserPhotoContent
@synthesize photo;

+(id) contentWithPhoto: (UIImage*) photo andCoordinate: (GMapsCoordinate*) coord {
    UserPhotoContent* content = [[[UserPhotoContent alloc] init] autorelease];
    content.coord = coord;
    content.contentProvider = content;
    content.title = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    content.photo = photo;
    return content;
}


-(UIView*) provideView {  
    return [[[UIImageView alloc] initWithImage:[self fetchImage]] autorelease];
}

-(UIImage*) fetchImage {
    return self.photo;
}

-(UIImage*) iconImage {
    return [self imageWithBorderFromImage:[self fetchImage]];
}

-(NSString*) tag {
    return self.title;
}

- (void) dealloc {
    [photo release];
    [super dealloc];
}

- (UIImage*)imageWithBorderFromImage:(UIImage*)source
{
    CGSize size = [source size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0); 
    CGContextSetLineWidth(context, size.width/(20.));
    CGContextStrokeRect(context, rect);
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return testImg;
}


@end
