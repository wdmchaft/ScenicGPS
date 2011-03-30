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
@interface ScenicMapView : MKMapView <MKMapViewDelegate, ScenicMapSelectorModelDelegate, MKReverseGeocoderDelegate>{
    ScenicMapSelectorModel* model;
    UINavigationController* navigationController;
    id<ScenicMapViewDelegate> scenicDelegate;
    MKPolyline* primaryPL;
}


-(void) putNewRoutes: (NSArray*) routes;
-(void) drawRoutes;
-(void) refreshRouteDrawings;
-(void) createModel;
-(void) updateRoutesOnMap;
-(NSArray*) visibleContentsForCurrentRegion;
-(void) updateVisibleContents;
-(void) addNewContent;
-(void) changeToRouteNumber: (int) n;
-(void) setInitialRoutes: (NSArray*) routes;
-(MKAnnotationView*) annotationViewForContent:(ScenicContent*) content;
@property (nonatomic, retain) ScenicMapSelectorModel* model;
@property (nonatomic, retain)     UINavigationController* navigationController;
@property (nonatomic, assign) id<ScenicMapViewDelegate> scenicDelegate;
@property (nonatomic, retain) MKPolyline* primaryPL;
@end

@protocol ScenicMapViewDelegate <NSObject>

-(void) scenicMapViewUpdatedRoutes;


@end