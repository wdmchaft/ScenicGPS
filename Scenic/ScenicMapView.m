//
//  ScenicMapView.m
//  Scenic
//
//  Created by Jack Reilly on 3/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapView.h"
#import "GeoHash.h"
#import "ScenicContentDisplayViewController.h"
#import "ScenicContent.h"
#import "ScenicContentTextVC.h"
#import "ScenicContentViewController.h"
#import "PanoramioContent.h"
#import "ScenicWaypointViewController.h"
#import "ScenicRoute.h"
#import "ScenicTextContent.h"
#import "ScenicPolyline.h"
#import "ScenicMapSelectorModel.h"


@implementation ScenicMapView
@synthesize model, navigationController, scenicDelegate;

-(void) changeToRouteNumber: (int) n {
    self.model.primaryRouteIndex = n;
    [self drawRoutes];
}

-(MKOverlayView*) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKOverlayView* olView =  [((MKPolyline*) overlay) plView];
        olView.userInteractionEnabled = YES;
        olView.multipleTouchEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(asfdas:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [olView addGestureRecognizer:tap];
        [tap release];
        return olView;
    }
    return nil;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"yo");
    [super touchesEnded:touches withEvent:event];
}

-(void) overlayTouched: (MKOverlayView*) olView {
    NSLog(@"touched");
}

-(void) putNewRoutes: (NSArray*) routes {
    self.model.routes = routes;
    [self updateRoutesOnMap];
}

-(void) updateRoutesOnMap {
    [self.scenicDelegate scenicMapViewUpdatedRoutes];
    [self drawRoutes];
}


- (MKAnnotationView *) mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    
    if ([annotation isKindOfClass:[ScenicContent class]]) {
        ScenicContent* sc = (ScenicContent*) annotation;
        MKPinAnnotationView* pinView =
        (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:[sc tag]];
        if (!pinView)
        {
            return [sc contentAVWithRoute:[self.model primaryRoute]];
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}


-(void) mapSelectorModelFinishedGettingRoutes:(ScenicMapSelectorModel *)model {
    [self putNewRoutes:self.model.routes];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self updateVisibleContents];
}

-(void) updateVisibleContents {
    NSArray* routeContents = [self.model primaryRoute].scenicContents;
    NSArray* visibleMapContents = [self visibleContentsForCurrentRegion];
    NSArray* visibleContents = [routeContents arrayByAddingObjectsFromArray:visibleMapContents];
    
    
    // remove nonvisible
    
    NSArray* mapAnnotations = [NSArray arrayWithArray:self.annotations];
    
    for (id<MKAnnotation> annotation in mapAnnotations) {
        if ([annotation isKindOfClass:[ScenicContent class]]) {
            if (![visibleContents containsObject:annotation ]) {
                [self removeAnnotation:annotation];
            }
        }
    }
    
    // add unadded
    NSArray* currentAnnotations = self.annotations;
    for (ScenicContent* content in visibleContents) {
        if (![currentAnnotations containsObject:content]) {
            [self addAnnotation:content];
        }
    }
    
}

-(NSArray*) visibleContentsForCurrentRegion {
    MKCoordinateRegion region = self.region;
    int level = 4;
    
    double delta = (region.span.latitudeDelta + region.span.longitudeDelta)/2.0;
    /*
     float a, b, u, v;
     a = 12; // max 11? this is the total number of chars of a geoHash string
     b = 1; // could be 1 (or 0 theoretically) this is the lowest number of characters to match 
     u = 0.48;
     v = 1; // max [0.818, 188] 
     */
    double delta_max = 188;
    double delta_min = .00818;
    int c_max = 12;
    int c_min  = 3;
    double rho = 1000.;
    double cDel = (double) (c_max - c_min);
    double dDel = delta_max - delta_min;
    NSLog(@"%f",delta);
    
    level = (int) (c_min + floor(cDel*(dDel - (delta - delta_min))/(rho*(delta - delta_min) + dDel)));
    
    
    
    
    
    NSLog(@"level: %d", level);
    
    
    
    NSMutableDictionary * aDict = [[[NSMutableDictionary alloc] init] autorelease];
    // ADD ALL TO HASH (since only unique key will contain 1 object)
    for( ScenicContent* content in self.model.scenicContents ){
        NSString * checkStr =[content.geoHash substringToIndex:level-1];
        [aDict setObject:content forKey:checkStr];
    }
    return [aDict allValues];
}

-(void) setInitialRoutes: (NSArray*) routes {
    if (!self.model) {
        [self createModel];
    }
    self.model.routes = routes;
    self.delegate = self;
    [self addNewContent];
    [self updateRoutesOnMap];
}


-(void) addNewContent {
    [self.model addTestContent];
    [self.model fetchNewContent];
    [self updateVisibleContents];
}

-(void) createModel {
    ScenicMapSelectorModel* tempModel = [[ScenicMapSelectorModel alloc] init];
    self.model = tempModel;
    self.model.delegate = self;
    [tempModel release];
}


- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	//NSLog(@"Reverse Geocoder Errored");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	[self addAnnotation:placemark];
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    ScenicTextContent * content = (ScenicTextContent*) view.annotation;
    NSLog(@"we have %@", content);
    bool alreadyAdded = [[self.model primaryRoute].scenicContents containsObject:content];
    
    if( view.leftCalloutAccessoryView == control) {
        if (alreadyAdded)
            [self.model removeWaypointWithContent:content];
        else
            [self.model addWaypointWithContent:content];
        [self removeAnnotation:content];
        [self addAnnotation:content];
        return;
    }
    
    ScenicWaypointViewController* waypointVC = [[ScenicWaypointViewController alloc] init];
    ScenicContentViewController* scVC = [[ScenicContentViewController alloc] initWithNibName:@"ScenicContentViewController" bundle:nil andContent:content];
    
    waypointVC.mainVC = scVC;
    [scVC release];
    waypointVC.delegate = self.model;
    if (alreadyAdded)
        waypointVC.toolTitle = @"Remove from Route";
    [self.navigationController pushViewController:waypointVC animated:YES];
    [waypointVC release];
}

-(void) drawRoutes {
    [self refreshRouteDrawings];
    ScenicRoute* primRoute = [self.model primaryRoute];
    BOOL isPrimary;
    GMapsRoute* gRoute;
    for (ScenicRoute* route in self.model.routes) {
        isPrimary = route == primRoute;
        gRoute = route.gRoute;
        CLLocationCoordinate2D startPos = [gRoute startPos];
        MKReverseGeocoder * geoCoderStart=[[MKReverseGeocoder alloc] initWithCoordinate:startPos];
        [geoCoderStart setDelegate:self];
        [geoCoderStart start];
        
        CLLocationCoordinate2D endPos = [gRoute endPos];
        MKReverseGeocoder * geoCoderEnd=[[MKReverseGeocoder alloc] initWithCoordinate:endPos];
        [geoCoderEnd setDelegate:self];
        [geoCoderEnd start];
        
        GMapsCoordinate* sw = gRoute.bounds.sw;
        GMapsCoordinate* ne = gRoute.bounds.ne;
        double swlat = [sw.lat doubleValue];
        double swlng = [sw.lng doubleValue];
        double nelat = [ne.lat doubleValue];
        double nelng = [ne.lng doubleValue];
        CLLocationCoordinate2D center = {.latitude = (swlat + nelat)*.5,
            .longitude = (swlng + nelng)*.5};
        MKCoordinateSpan span =  MKCoordinateSpanMake(nelat - swlat, nelng - swlng);
        MKCoordinateRegion region = {center, span};
        [self setRegion:region animated:YES];
        MKPolyline* sp = [gRoute polylineOverlay];
        [sp setIsPrimary:isPrimary];
        [self addOverlay:sp];
    }
}

-(void) refreshRouteDrawings {
    [self removeOverlays: [self overlays]];
}

@end
