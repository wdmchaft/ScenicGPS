//
//  GeoHash.h
//  Scenic
//
//  Created by Dan Lynch on 3/11/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GeoHash : NSObject { }

+ (NSString *) hash : (CLLocationCoordinate2D) coord;

@end
