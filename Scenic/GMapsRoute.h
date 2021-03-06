//
//  GMapsRoute.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMapsBounds.h"
#import <MapKit/MapKit.h>

@class GMapsPolyline, GMapsBounds, GMapsCoordinate, MKPolyline;
@interface GMapsRoute : NSObject <NSCoding> {
    NSString* summary;
    NSArray* legs;
    NSString* copyrights;
    GMapsPolyline* polyline;
    GMapsBounds* bounds;
}

@property (nonatomic, retain) NSString* summary;
@property (nonatomic, retain) NSArray* legs;
@property (nonatomic, retain) NSString* copyrights;
@property (nonatomic, retain) GMapsPolyline* polyline;
@property (nonatomic, retain) GMapsBounds* bounds;



+(id) routeFromJSONDictionary: (NSDictionary*) dic;

-(MKPolyline*) polylineOverlay;

- (CLLocationCoordinate2D) startPos;
- (CLLocationCoordinate2D) endPos;
- (GMapsCoordinate*) endCoord;
- (GMapsCoordinate*) startCoord;


@end
