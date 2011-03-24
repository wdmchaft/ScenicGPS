//
//  ScenicMapView.m
//  Scenic
//
//  Created by Jack Reilly on 3/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapView.h"


@implementation ScenicMapView

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"yo yo yo");
    [super touchesEnded:touches withEvent:event];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"heyyy");
    [super touchesBegan:touches withEvent:event];
}

@end
