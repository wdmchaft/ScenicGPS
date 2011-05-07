//
//  ScenicMapSelectorModel.h
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GMapsRouter.h"
#import "ScenicContent.h"
#import "ScenicWaypointViewController.h"

@protocol ScenicMapSelectorModelDelegate;
@class ScenicRoute, GMapsBounds, GMapsCoordinate;
@interface ScenicMapSelectorModel : NSObject <CLLocationManagerDelegate, DataFetcherDelegate, ScenicContentDelegate, NSCopying> {
    NSArray* routes;
    int primaryRouteIndex;
    NSMutableArray* scenicContents;
    CLLocationManager* locationManager;
    id<ScenicMapSelectorModelDelegate> delegate;
    bool frozen;
}

@property (nonatomic, retain) NSArray* routes;
@property (nonatomic, assign) int primaryRouteIndex;
@property (nonatomic, retain) NSMutableArray* scenicContents;
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, assign) id<ScenicMapSelectorModelDelegate> delegate;
@property (nonatomic, assign) bool frozen;
-(id) init;
-(void) initContents;
-(void) addContent: (ScenicContent*) content;
-(NSArray*) secondaryRoutes;
-(ScenicRoute*) primaryRoute;
-(NSArray*) testContent;
-(void) addTestContent;
-(void) addContentToPrimaryRoute: (ScenicContent*) content;
-(void) removeWaypointWithContent:(ScenicContent*)content;
-(void) refetch;
-(void) removeContentFromPrimaryRoute: (ScenicContent*) content;
-(void) fetchNewContent;
-(void) fetchNewContentWithBounds:(GMapsBounds*)bounds;
-(void) fetchNewContentWithCoord:(GMapsCoordinate*)coord;
@end

@protocol ScenicMapSelectorModelDelegate

-(void) mapSelectorModelFinishedGettingRoutes: (ScenicMapSelectorModel*) model;
-(void) mapSelectorModelFinishedFetchingContent: (ScenicMapSelectorModel*) model;
-(void) mapSelectorModelHeadingUpdate:(CLHeading*)heading;

@end