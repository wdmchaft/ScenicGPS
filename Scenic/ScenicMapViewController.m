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


@implementation ScenicMapViewController
@synthesize mapView, mPlacemark, mapType, locationController, currentLocation;

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
	
    mv.showsUserLocation=TRUE;
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
    [tempSeg addTarget:self action:@selector(changeType) forControlEvents:UIControlEventValueChanged];
    [tempSeg setEnabled:YES forSegmentAtIndex:0];
    self.mapType = tempSeg;
    [mv addSubview:mapType];
    [tempSeg release];
    
    // add the map
	[mv setDelegate:self];
    [self.view addSubview:mv];
    self.mapView = mv;
    [mv release];

}

-(void) setRoute: (GMapsRoute*) route {
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
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	annView.animatesDrop=TRUE;
	return annView; 
    
}

-(MKOverlayView*) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    MKPolylineView* plView = [[[MKPolylineView alloc] initWithPolyline:((MKPolyline*) overlay)] autorelease];
    plView.strokeColor = [UIColor colorWithRed:100/255.f green:0 blue:207/255.f alpha:0x7f/255.f];
    plView.lineWidth = 10;
    return plView;
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"Reverse Geocoder Errored");
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	NSLog(@"Reverse Geocoder completed");
	mPlacemark=placemark;
    self.title = [mPlacemark description];
	[mapView addAnnotation:placemark];
}

- (void)locationUpdate:(CLLocation *)location {
     NSLog( @"%@", [location description]);
     NSLog(@"%f %f", location.coordinate.latitude, location.coordinate.longitude);
     currentLocation = location;
    
}

- (void)locationError:(NSError *)error {
    NSLog( @"%@", [error description]);
}

@end
