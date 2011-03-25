//
//  ScenicMapViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapViewController.h"
#import <MapKit/MapKit.h>
#import "GMapsRoute.h"
#import "GMapsRouter.h"


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
#import "ScenicMapView.h"

@implementation ScenicMapViewController
@synthesize mapView, mapType, model, toggleMapType, mapTypeToolbar;

#pragma mark - View lifecycle

-(void) createModel {
    ScenicMapSelectorModel* tempModel = [[ScenicMapSelectorModel alloc] init];
    self.model = tempModel;
    self.model.delegate = self;
    [tempModel release];
}

-(void) mapSelectorModelFinishedGettingRoutes:(ScenicMapSelectorModel *)model {
    [self putNewRoutes:self.model.routes];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self createModel];
    [self.model addTestContent];
    [self addAnnotationsToMap];
}

-(IBAction) hideToolbar: (id) sender {
    [self.mapTypeToolbar setHidden:YES];
    [self.toggleMapType setHidden:NO];
}
-(IBAction) showToolbar: (id) sender {
    [self.mapTypeToolbar setHidden:NO];
    [self.toggleMapType setHidden:YES];
}

-(IBAction) changeMapType: (id) sender {
    switch (self.mapType.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

-(void) addAnnotationsToMap {
    [self.mapView addAnnotations:self.model.scenicContents];
}

-(void) changeRoute {
    // do somethin
    [self drawRoutes];
}

-(void) drawRoutes {
    [self refreshRouteDrawings];
    ScenicRoute* primRoute = [self.model primaryRoute];
    BOOL isPrimary;
    GMapsRoute* gRoute;
    for (ScenicRoute* route in self.model.routes) {
        isPrimary = route == primRoute;
        gRoute = route.gRoute;
        if (isPrimary)
            self.title = gRoute.summary;
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
        [mapView setRegion:region animated:YES];
        MKPolyline* sp = [gRoute polylineOverlay];
        [sp setIsPrimary:isPrimary];
        [mapView addOverlay:sp];
    }
}

-(void) refreshRouteDrawings {
    [self.mapView removeOverlays: [self.mapView overlays]];
}

- (void)changeType {
	if(mapType.selectedSegmentIndex==0){
		mapView.mapType=MKMapTypeStandard;
	}
	else if (mapType.selectedSegmentIndex==1){
		mapView.mapType=MKMapTypeSatellite;
	}
	else if (mapType.selectedSegmentIndex==2){
		mapView.mapType=MKMapTypeHybrid;
	}
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
            return [sc contentAV];
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
 
    for( id<MKAnnotation> annotation in [[self mapView] annotations] ){
        
        if( [annotation isKindOfClass:[ScenicContent class]] && [annotation conformsToProtocol:@protocol(MKAnnotation)] ){
            //ScenicContent * s = (ScenicContent*) annotation;
            //[s setVisibility:![s visibility]];
        }
        
    }
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    ScenicTextContent * content = (ScenicTextContent*) view.annotation;
    NSLog(@"we have %@", content);
    
    
    if( view.leftCalloutAccessoryView == control) {
        [self.model addWaypointWithContent:content];
        return;
    }
    
    ScenicWaypointViewController* waypointVC = [[ScenicWaypointViewController alloc] init];
    ScenicContentViewController* scVC = [[ScenicContentViewController alloc] initWithNibName:@"ScenicContentViewController" bundle:nil andContent:content];
    
    waypointVC.mainVC = scVC;
    [scVC release];
    waypointVC.delegate = self.model;
    [self.navigationController pushViewController:waypointVC animated:YES];
    [waypointVC release];
}

-(void) putNewRoutes: (NSArray*) routes {
    self.model.routes = routes;
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


-(void) mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews {
    for (MKOverlayView* olView in overlayViews) {
        [mapView bringSubviewToFront:olView];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"yo");
    [super touchesEnded:touches withEvent:event];
}

-(void) overlayTouched: (MKOverlayView*) olView {
    NSLog(@"touched");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	//NSLog(@"Reverse Geocoder Errored");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	[mapView addAnnotation:placemark];
}

- (void)gotoLocation:(CLLocation *) location{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = location.coordinate.latitude;
    newRegion.center.longitude = location.coordinate.longitude;
    newRegion.span.latitudeDelta = 0.1;
    newRegion.span.longitudeDelta = 0.1;
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)dealloc
{
    [super dealloc];
    [mapView release];
}

@end
