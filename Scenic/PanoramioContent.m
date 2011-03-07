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

-(UIImage*) provideImage {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

@end
