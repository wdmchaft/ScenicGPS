//
//  ScenicPolyline.m
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicPolyline.h"



@implementation MKPolyline (isPrimary)


-(void)setIsPrimary: (BOOL)myBool
{
    objc_setAssociatedObject(self, &MYPrimaryString, myBool, OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)isPrimary
{
    return (BOOL)objc_getAssociatedObject(self, &MYPrimaryString);
}

-(MKPolylineView*) plView {
    MKPolylineView* plView = [[[MKPolylineView alloc] initWithPolyline:self] autorelease];
    plView.strokeColor = [self lineColor];
    plView.lineWidth = 10;
    return plView;
}

-(UIColor*) lineColor {
    if (self.isPrimary) return [UIColor colorWithRed:100/255.f green:0 blue:207/255.f alpha:0x7f/255.f];
    return [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:0x7f/255.f];
}


@end
