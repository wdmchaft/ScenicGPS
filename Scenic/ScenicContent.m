//
//  ScenicContent.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicContent.h"
#import <MapKit/MapKit.h>
#import "GMapsCoordinate.h"
#import "ScenicRoute.h"
#import "GeoHash.h"

static NSString* ScenicAnnotationIdentifier = @"ScenicAnnotationIdentifier";

@implementation ScenicContent
@synthesize coord, title, score, contentProvider, geoHash;

- (void) computeHash {
    self.geoHash = [GeoHash hash:CLLocationCoordinate2DMake([coord.lat doubleValue], [coord.lng doubleValue])];
}

+(NSString*) SCAVID {
    return ScenicAnnotationIdentifier;
}

-(NSString*) tag {
    return self.title;
}

-(CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake([self.coord.lat doubleValue], [self.coord.lng doubleValue]);
}

+(CGSize) defIconSize {
    return CGSizeMake(50, 50);
}

-(UIImage*) fetchIcon {
    return [ScenicContent imageWithImage:[self iconImage] scaledToSize:[ScenicContent defIconSize]];
}

-(UIImage*) iconImage {
    return [UIImage imageNamed:@"location.png"];
}

-(UIImage*) fetchImage {
    return [UIImage imageNamed:@"location.png"];
}

-(void) setCoord:(GMapsCoordinate *)newCoord {
    [newCoord retain];
    [coord release];
    coord = newCoord;
    [self computeHash];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.coord];
    [aCoder encodeObject:self.contentProvider];
    [aCoder encodeObject:self.geoHash];
    [aCoder encodeObject:self.title];
    [aCoder encodeFloat:self.score forKey:@"score"];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.coord = [aDecoder decodeObject];
        self.contentProvider = [aDecoder decodeObject];
        self.geoHash = [aDecoder decodeObject];
        self.title = [aDecoder decodeObject];
        self.score = [aDecoder decodeFloatForKey:@"score"];
    }
    return self;
}

@end
