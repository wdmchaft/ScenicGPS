//
//  ScenicPolyline.m
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicPolyline.h"



@implementation MKPolyline (isPrimary)

-(MKPolylineView*) plViewWithPrimary: (bool) isPrim {
    MKPolylineView* plView = [[[MKPolylineView alloc] initWithPolyline:self] autorelease];
    plView.strokeColor = [self lineColorWithPrimary: isPrim];
    plView.lineWidth = 10;
    return plView;
}

-(UIColor*) lineColorWithPrimary: (bool) isPrim{
    if (isPrim) return [UIColor colorWithRed:100/255.f green:0 blue:207/255.f alpha:0x7f/255.f];
    return [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:0x7f/255.f];
}


@end
