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

@implementation ScenicMapViewController
@synthesize mapView, mPlacemark, mapType, locationController, currentLocation, scenicRoute, mapAnnotations, currentRoute, secondaryRoutes;

+ (CGFloat)annotationPadding;
{
    return 10.0f;
}
+ (CGFloat)calloutHeight;
{
    return 40.0f;
}

- (void)dealloc
{
    [super dealloc];
    [mapView release];
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    
    [super viewDidLoad];
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
    tempSeg.frame = CGRectMake(33, 300, tempSeg.frame.size.width, tempSeg.frame.size.height);
    [tempSeg addTarget:self action:@selector(changeType) forControlEvents:UIControlEventValueChanged];
    [tempSeg setEnabled:YES forSegmentAtIndex:0];
    tempSeg.selectedSegmentIndex = 0;
    self.mapType = tempSeg;
    [mv addSubview:mapType];
    [tempSeg release];
    
    
    // add the map
	[mv setDelegate:self];
    [self.view addSubview:mv];
    self.mapView = mv;
    [mv release];
    
    
    // only add annotations after initializing mapView
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:4];
    
    [GeoHash hash:CLLocationCoordinate2DMake(57.64911,10.40744)];
    // should be  u4pruydqqvj

    NSArray* cityTitles = [NSArray arrayWithObjects:@"San Francisco", @"Grace Cathedral", @"The Embarcadero",@"Sacramento",  nil];
    NSArray* cityDescriptions = [NSArray arrayWithObjects:@"Founded: June 29, 1776", @"Grace Cathedral is a house of prayer for all people.", @"Whether it's family fun, unique shopping, an up-close look at California's playful sea lions, an encounter with a street performer or delightful dining, San Francisco's PIER 39 is the place to be -- for PIER FUN!",@"Go Kings!",  nil];
    NSArray* locs = [NSArray arrayWithObjects:[GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.786996, -122.419281)],[GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.791847, -122.412891)],[GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.7945047, -122.3940806)],[GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(38.6, -121.5) ], nil];
    
    
    for (int i = 0; i < [locs count]; i++) {
        [self.mapAnnotations addObject:[ScenicTextContent contentWithTitle:[cityTitles objectAtIndex:i] subTitle:[cityDescriptions objectAtIndex:i] coordinate:[locs objectAtIndex:i]]];
    }
    
    PanoramioContent* pc = [[PanoramioContent alloc] init];
    pc.title = @"google";
    pc.coord = [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.73,-122.37)];
    pc.url = [NSURL URLWithString:@"http://www.tnpsc.com/downloads/NaturesScenery.jpg"];
    pc.contentProvider = pc;
    [self.mapAnnotations addObject:pc];
    [pc release];
    [mapView addAnnotations:mapAnnotations];
    
}

-(void) putScenicRoutes: (NSArray*) sRoutes {
    [self putScenicRoute:[sRoutes objectAtIndex:0]];
    [self putSecondaryRoutes:[sRoutes subarrayWithRange:NSMakeRange(1, [sRoutes count] - 1)]];
    
}

-(void) putSecondaryRoutes: (NSArray*) secRoutes {
    self.secondaryRoutes = secRoutes;
    for (ScenicRoute* curRoute in secRoutes) {
        [self drawRoute: curRoute.gRoute asPrimary: NO];
    }
}

-(void) putScenicRoute: (ScenicRoute*) sr {
    self.scenicRoute = sr;
    [self putCurrentRoute:sr.gRoute];
}

-(void) putCurrentRoute:(GMapsRoute *)  cr {
    self.currentRoute = cr;
    [self drawRoute:currentRoute asPrimary:YES];
}

-(void) drawRoute: (GMapsRoute*) route asPrimary: (BOOL) isPrimary {
    if (isPrimary)
        self.title = route.summary;
    CLLocationCoordinate2D startPos = [route startPos];
    MKReverseGeocoder * geoCoderStart=[[MKReverseGeocoder alloc] initWithCoordinate:startPos];
    [geoCoderStart setDelegate:self];
    [geoCoderStart start];
    
    CLLocationCoordinate2D endPos = [route endPos];
    MKReverseGeocoder * geoCoderEnd=[[MKReverseGeocoder alloc] initWithCoordinate:endPos];
    [geoCoderEnd setDelegate:self];
    [geoCoderEnd start];
    
    GMapsCoordinate* sw = route.bounds.sw;
    GMapsCoordinate* ne = route.bounds.ne;
    double swlat = [sw.lat doubleValue];
    double swlng = [sw.lng doubleValue];
    double nelat = [ne.lat doubleValue];
    double nelng = [ne.lng doubleValue];
    CLLocationCoordinate2D center = {.latitude = (swlat + nelat)*.5,
        .longitude = (swlng + nelng)*.5};
    MKCoordinateSpan span =  MKCoordinateSpanMake(nelat - swlat, nelng - swlng);
    MKCoordinateRegion region = {center, span};
    [mapView setRegion:region animated:YES];
    [mapView addOverlay:[route polylineOverlay]];
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
    
    // handle our two custom annotations
    //
    
    if ([annotation isKindOfClass:[ScenicContent class]]) {
        
        MKPinAnnotationView* pinView =
        (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[ScenicContent SCAVID]];
        if (!pinView)
        {
            ScenicContent* sc = (ScenicContent*) annotation;
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


-(MKOverlayView*) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    MKPolylineView* plView = [[[MKPolylineView alloc] initWithPolyline:((MKPolyline*) overlay)] autorelease];
    plView.strokeColor = [UIColor colorWithRed:100/255.f green:0 blue:207/255.f alpha:0x7f/255.f];
    plView.lineWidth = 10;
    return plView;
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	//NSLog(@"Reverse Geocoder Errored");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	//NSLog(@"Reverse Geocoder completed");
	mPlacemark=placemark;
    self.title = [mPlacemark description];
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
    [self.scenicRoute addContent:content];
    GMapsRouter* router = [[GMapsRouter routeWithScenicRoute:self.scenicRoute andDelegate:self] retain];
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
    [self putScenicRoute:(ScenicRoute*) route];
}

@end
