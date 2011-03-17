//
//  PanoramioContent.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PanoramioContent.h"


@implementation PanoramioContent
@synthesize url;

-(UIView*) provideView {  
    return [[[UIImageView alloc] initWithImage:[self fetchImage]] autorelease];
}

-(UIImage*) fetchImage {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

-(UIImage*) iconImage {
    return [self fetchImage];
}

-(NSString*) tag {
    return @"Pano";
}

- (void) dealloc {
    [url release];
    [super dealloc];
}

@end
