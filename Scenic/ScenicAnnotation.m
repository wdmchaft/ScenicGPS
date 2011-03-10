//
//  ScenicAnnotation.m
//  Scenic
//
//  Created by Dan Lynch on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicAnnotation.h"


@implementation ScenicAnnotation
@synthesize image;
@synthesize latitude;
@synthesize longitude;


- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 37.786996;
    theCoordinate.longitude = -122.419281;
    return theCoordinate; 
}

- (void)dealloc
{
    [image release];
    [super dealloc];
}

- (NSString *)title
{
    return @"San Francisco";
}

// optional
- (NSString *)subtitle
{
    return @"Founded: June 29, 1776";
}

@end