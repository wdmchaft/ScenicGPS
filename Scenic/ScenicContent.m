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

static NSString* ScenicAnnotationIdentifier = @"ScenicAnnotationIdentifier";

@implementation ScenicContent
@synthesize coord, title, score, contentProvider, contentView;



-(MKAnnotationView*) contentAV {
    MKAnnotationView *annotationView = [[[MKAnnotationView alloc] initWithAnnotation:self
                                                                     reuseIdentifier:ScenicAnnotationIdentifier] autorelease];
    annotationView.canShowCallout = YES;
    
    UIImage *flagImage = [self fetchIcon];
    /*
     CGRect resizeRect;
     
     resizeRect.size = flagImage.size;
     CGSize maxSize = CGRectInset(self.view.bounds,
     [ScenicMapViewController annotationPadding],
     [ScenicMapViewController annotationPadding]).size;
     maxSize.height -= self.navigationController.navigationBar.frame.size.height + [ScenicMapViewController calloutHeight];
     if (resizeRect.size.width > maxSize.width)
     resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
     if (resizeRect.size.height > maxSize.height)
     resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
     
     resizeRect.origin = (CGPoint){0.0f, 0.0f};
     UIGraphicsBeginImageContext(resizeRect.size);
     [flagImage drawInRect:resizeRect];
     UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     */
    annotationView.image = flagImage;
    annotationView.opaque = NO;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    annotationView.rightCalloutAccessoryView = rightButton;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0,0.0, 28.0, 28.0)];
    [button setImage:[UIImage imageNamed:@"add-28.png"] forState:UIControlStateNormal];
    annotationView.leftCalloutAccessoryView = button;
    return annotationView;
}

- (void) setVisibility : (BOOL) vis {
    visible = vis;
}

- (BOOL) visibility {
    return visible;
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
