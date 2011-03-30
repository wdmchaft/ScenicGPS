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
-(MKPolylineView*) plViewWithPrimary: (bool) isPrim;
-(UIColor*) lineColorWithPrimary: (bool) isPrim;
@end