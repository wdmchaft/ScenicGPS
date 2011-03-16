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

#import "ScenicAnnotation.h"
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

@implementation ScenicMapViewController
@synthesize mapView, mapType, locationController, currentLocation, routeChooser, model;

#pragma mark - View lifecycle

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    ScenicMapSelectorModel* tempModel = [[ScenicMapSelectorModel alloc] init];
    self.model = tempModel;
    [tempModel release];
    MKMapView* mv = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mv.mapType = MKMapTypeHybrid;
	
    mv.showsUserLocation=FALSE;
    mv.mapType=MKMapTypeStandard;    
    
    /* get location of user */
    /* modified below slightly to conform to the usual instance variable assignment convention using properties */    
    
    ScenicLocationCLController* tempCL = [[ScenicLocationCLController alloc] init];
	tempCL.delegate = self;
	[tempCL.locationManager startUpdatingLocation];
    self.locationController = tempCL;
    [tempCL release];
    
    // now currentLocation.coordinate.latitude, currentLocation.coordinate.longitude are available
    
    /*Region and Zoom*/
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(37.8716667, -122.2716667);
    MKCoordinateSpan span = MKCoordinateSpanMake(.9, .9);
    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
    
    [mv setRegion:region animated:TRUE];    
    
    UISegmentedControl* tempSeg = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"Map", @"Satelitte", @"Hybrid", nil]];
    tempSeg.frame = CGRectMake(33, 250, tempSeg.frame.size.width, tempSeg.frame.size.height);
    [tempSeg addTarget:self action:@selector(changeType) forControlEvents:UIControlEventValueChanged];
    [tempSeg setEnabled:YES forSegmentAtIndex:0];
    tempSeg.selectedSegmentIndex = 0;
    self.mapType = tempSeg;
    [mv addSubview:mapType];
    [tempSeg release];
    
    UISegmentedControl* tempRC = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"1", @"2", @"3", nil]];
    tempRC.frame = CGRectMake(33, 300, tempSeg.frame.size.width, tempSeg.frame.size.height);
    [tempRC addTarget:self action:@selector(changeRoute) forControlEvents:UIControlEventValueChanged];
    [tempRC setEnabled:YES forSegmentAtIndex:0];
    tempRC.selectedSegmentIndex = 0;
    self.routeChooser = tempRC;
    [mv addSubview:self.routeChooser];
    [tempRC release];
    
    // add the map
	[mv setDelegate:self];
    [self.view addSubview:mv];
    self.mapView = mv;
    [mv release];
    
    [self.model addTestContent];
    
    [self addAnnotationsToMap];
}

-(void) addAnnotationsToMap {
    [self.mapView addAnnotations:self.model.scenicContents];
}

-(void) changeRoute {
    self.model.primaryRouteIndex = routeChooser.selectedSegmentIndex;
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

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

    
    if ([annotation isKindOfClass:[ScenicContent class]]) {
        ScenicContent* sc = (ScenicContent*) annotation;
        MKPinAnnotationView* pinView =
        (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[sc tag]];
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




- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    ScenicTextContent * content = (ScenicTextContent*) view.annotation;
    NSLog(@"we have %@", content);
    
    
    if( view.leftCalloutAccessoryView == control) {
        [self addWaypointWithContent:content];
        return;
    }
    
    ScenicWaypointViewController* waypointVC = [[ScenicWaypointViewController alloc] init];
    ScenicContentViewController* scVC = [[ScenicContentViewController alloc] initWithNibName:@"ScenicContentViewController" bundle:nil andContent:content];
    
    waypointVC.mainVC = scVC;
    [scVC release];
    waypointVC.delegate = self;
    [self.navigationController pushViewController:waypointVC animated:YES];
    [waypointVC release];
}

-(void) addWaypointWithContent:(ScenicContent*)content {
    [self.model addContentToPrimaryRoute:content];
    GMapsRouter* router = [[GMapsRouter routeWithScenicRoute:[self.model primaryRoute] andDelegate:self] retain];
    [router fetch];
}

-(void) dataFetcher:(DataFetcher *)fetcher hasResponse:(id)response {
    NSArray* routes = (NSArray*) response;
    ScenicRoute* route = [routes objectAtIndex:0];
    self.title = [NSString stringWithFormat:@"%@ added!",route.startRequest];
    for (id annot in self.mapView.selectedAnnotations) {
        [self.mapView deselectAnnotation:annot animated:YES];
    }
    [self refreshRouteDrawings];
    [self putNewRoutes: routes];
}

-(void) putNewRoutes: (NSArray*) routes {
    self.model.routes = routes;
    self.model.primaryRouteIndex = 0;
    [self drawRoutes];
}


-(MKOverlayView*) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        return [((MKPolyline*) overlay) plView];
    }
    return nil;
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	//NSLog(@"Reverse Geocoder Errored");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
    self.title = [placemark description];
	[mapView addAnnotation:placemark];
}

- (void)locationUpdate:(CLLocation *)location {
    //  NSLog( @"%@", [location description]);
    //  NSLog(@"%f %f", location.coordinate.latitude, location.coordinate.longitude);
    currentLocation = location;
    
}

- (void)locationError:(NSError *)error {
    //NSLog( @"%@", [error description]);
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
