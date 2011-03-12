//
//  ScenicAnnotation.m
//  Scenic
//
//  Created by Dan Lynch on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicAnnotation.h"


@implementation ScenicAnnotation
@synthesize image, title, subtitle;

- (CLLocationCoordinate2D)coordinate { 
    return coordinate;
}

- (void)dealloc {
    [image release];
    [super dealloc];
}

- (NSString *)title {
    return title;
}

// optional
- (NSString *)subtitle {
    return subtitle;
}

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

- (CLLocationCoordinate2D) getCoordinate {
    return coordinate;
}


- (void) setTitle : (NSString *) text {
    title = text;
}
- (void) setSubtitle : (NSString *) text {
    subtitle = text;
}

@end