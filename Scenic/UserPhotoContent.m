//
//  UserPhotoContent.m
//  Scenic
//
//  Created by Jack Reilly on 3/30/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "UserPhotoContent.h"
#import "GMapsCoordinate.h"

static NSString* JSON_PHOTO = @"image";
static NSString* JSON_TITLE = @"title";
static NSString* JSON_COORD = @"coord";



@implementation UserPhotoContent
@synthesize photo, heading;

+(id) contentWithPhoto: (UIImage*) photo andCoordinate: (GMapsCoordinate*) coord andCLHeading:(CLHeading *)h

{
    UserPhotoContent* content = [[[UserPhotoContent alloc] init] autorelease];
    content.coord = coord;
    content.contentProvider = content;
    content.title = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    content.photo = photo;
    content.heading = h;
    return content;
}

+(id) contentFromJSONDic: (NSDictionary*) dic {
    UIImage* photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:(NSString*) [dic objectForKey:JSON_PHOTO]]]];
    NSString* title = (NSString*) [dic objectForKey:JSON_TITLE];
    GMapsCoordinate* coord = [GMapsCoordinate   coordFromJSONDic:(NSDictionary*) [dic objectForKey:JSON_COORD]];
    UserPhotoContent* content = [UserPhotoContent contentWithPhoto:photo andCoordinate:coord andCLHeading:nil];
    content.title = title;
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
