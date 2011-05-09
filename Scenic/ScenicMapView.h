//
//  ScenicMapView.h
//  Scenic
//
//  Created by Jack Reilly on 3/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ScenicMapSelectorModel.h"

@protocol ScenicMapViewDelegate;
@class UserPhotoContent;
@interface ScenicMapView : MKMapView <MKMapViewDelegate, ScenicMapSelectorModelDelegate, MKReverseGeocoderDelegate>{
    ScenicMapSelectorModel* model;
    UINavigationController* navigationController;
    id<ScenicMapViewDelegate> scenicDelegate;
    MKPolyline* primaryPL;
    BOOL updateHeading;
}


-(void) putNewRoutes: (NSArray*) routes;
-(void) drawRoutes;
-(void) refreshRouteDrawings;
-(void) createModel;
-(void) updateRoutesOnMap;
-(NSArray*) visibleContentsForCurrentRegion;
-(void) updateVisibleContents;
-(void) changeToRouteNumber: (int) n;
-(void) setInitialRoutes: (NSArray*) routes;
-(void) addUserContent: (ScenicContent*) content;
-(MKAnnotationView*) annotationViewForContent:(ScenicContent*) content;

- (void) compassFrame:(BOOL)b;

@property (nonatomic, retain) ScenicMapSelectorModel* model;
@property (nonatomic, retain)     UINavigationController* navigationController;
@property (nonatomic, assign) id<ScenicMapViewDelegate> scenicDelegate;
@property (nonatomic, retain) MKPolyline* primaryPL;
@property (nonatomic, assign) BOOL updateHeading;

@end

@protocol ScenicMapViewDelegate <NSObject>

-(void) scenicMapViewUpdatedRoutes;


@end