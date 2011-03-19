//
//  ScenicPolyline.h
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <objc/runtime.h>



@interface MKPolyline (isPrimary)
-(void)setIsPrimary:(BOOL)myBool;
-(BOOL)isPrimary;
-(MKPolylineView*) plView;
-(UIColor*) lineColor;
@end