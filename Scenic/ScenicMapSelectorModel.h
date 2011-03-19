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

@protocol ScenicMapSelectorModelDelegate;
@class ScenicRoute, ScenicContent;
@interface ScenicMapSelectorModel : NSObject <CLLocationManagerDelegate, DataFetcherDelegate> {
    NSArray* routes;
    int primaryRouteIndex;
    NSMutableArray* scenicContents;
    CLLocationManager* locationManager;
    id<ScenicMapSelectorModelDelegate> delegate;
}

@property (nonatomic, retain) NSArray* routes;
@property (nonatomic, assign) int primaryRouteIndex;
@property (nonatomic, retain) NSMutableArray* scenicContents;
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, assign) id<ScenicMapSelectorModelDelegate> delegate;

-(id) init;
-(void) initContents;
-(void) addContent: (ScenicContent*) content;
-(NSArray*) secondaryRoutes;
-(ScenicRoute*) primaryRoute;
-(NSArray*) testContent;
-(void) addTestContent;
-(void) addContentToPrimaryRoute: (ScenicContent*) content;
@end

@protocol ScenicMapSelectorModelDelegate

-(void) mapSelectorModelFinishedGettingRoutes: (ScenicMapSelectorModel*) model;

@end