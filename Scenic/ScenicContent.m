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
@synthesize coord, title, score, contentProvider, contentView, geoHash;

- (void) computeHash {
    geoHash = [GeoHash hash:CLLocationCoordinate2DMake([coord.lat doubleValue], [coord.lng doubleValue])];
}


-(MKAnnotationView*) contentAVWithRoute: (ScenicRoute*) route {
    MKAnnotationView *annotationView = [[[MKAnnotationView alloc] initWithAnnotation:self
                                                                     reuseIdentifier:ScenicAnnotationIdentifier] autorelease];
    annotationView.canShowCallout = YES;
    
    UIImage *flagImage = [self fetchIcon];
    annotationView.image = flagImage;
    annotationView.opaque = NO;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    annotationView.rightCalloutAccessoryView = rightButton;
    UIImage* image;
    if (![route.scenicContents containsObject:self])
        image = [UIImage imageNamed:@"add-28.png"];
    else
        image = [UIImage imageNamed:@"remove.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0,0.0, 28.0, 28.0)];
    [button setImage:image forState:UIControlStateNormal];
    annotationView.leftCalloutAccessoryView = button;
    return annotationView;
}

+(NSString*) SCAVID {
    return ScenicAnnotationIdentifier;
}

-(NSString*) tag {
    return ScenicAnnotationIdentifier;
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


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
