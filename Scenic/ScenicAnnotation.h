//
//  ScenicAnnotation.h
//  Scenic
//
//  Created by Dan Lynch on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

// thank you Apple for the MapCallouts example
// http://developer.apple.com/library/ios/#samplecode/MapCallouts/Introduction/Intro.html#//apple_ref/doc/uid/DTS40009746

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ScenicAnnotation : NSObject <MKAnnotation>
{
    UIImage *image;    
    NSString * title;
    NSString * subtitle;
    
    CLLocationCoordinate2D coordinate;
}

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate;
- (void) setTitle : (NSString *) text;
- (void) setSubtitle : (NSString *) text;
- (CLLocationCoordinate2D) getCoordinate;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@end
