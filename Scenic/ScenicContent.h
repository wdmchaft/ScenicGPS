//
//  ScenicContent.h
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicContentProvider.h"
#import <MapKit/MapKit.h>
#import "GMapsCoordinate.h"

@class GMapsCoordinate, ScenicContentProvider, MKAnnotationView, ScenicRoute;
@interface ScenicContent : NSObject <MKAnnotation, NSCoding>{
    GMapsCoordinate* coord;
    NSString* title;

    int score;
    id<ScenicContentProvider> contentProvider;
    NSString* geoHash;
}


@property (nonatomic, retain) GMapsCoordinate* coord;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) int score;
@property (nonatomic, retain) id<ScenicContentProvider> contentProvider;
@property (nonatomic, retain) NSString* geoHash;


+(NSString*) SCAVID;
-(CLLocationCoordinate2D) coordinate;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
-(UIImage*) fetchIcon;
-(UIImage*) iconImage;
+(CGSize) defIconSize;
-(NSString*) tag;
-(UIImage*) fetchImage;

- (void) computeHash;

@end
