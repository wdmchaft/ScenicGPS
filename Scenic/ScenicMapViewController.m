//
//  ScenicMapViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapViewController.h"


@implementation ScenicMapViewController
@synthesize mapView   = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	
    _mapView.showsUserLocation=TRUE;
    _mapView.mapType=MKMapTypeStandard;
    
    /*Region and Zoom*/
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.9;
    span.longitudeDelta=0.9;
    
    CLLocationCoordinate2D location=_mapView.userLocation.coordinate;    
    location.latitude=37.8716667;
    location.longitude=-122.2716667;
    region.span=span;
    region.center=location;
    
    geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:location];
    [geoCoder setDelegate:self];
    [geoCoder start];

    CLLocationCoordinate2D location2=_mapView.userLocation.coordinate;    
    location.latitude=37.4241667;
    location.longitude=-122.165;
    
    
    MKReverseGeocoder * geoCoder2=[[MKReverseGeocoder alloc] initWithCoordinate:location2];
    [geoCoder2 setDelegate:self];
    [geoCoder2 start];
    
    
    [_mapView setRegion:region animated:TRUE];
    [_mapView regionThatFits:region];
    
    // add the segmented control and the callback
    mapType = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"Map", @"Satelitte", @"Hybrid", nil]];
    [mapType addTarget:self action:@selector(changeType) forControlEvents:UIControlEventValueChanged];
    [_mapView addSubview:mapType];
    
    // add the map
	[_mapView setDelegate:self];
    [self.view addSubview:_mapView];
    
        
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)changeType{
	if(mapType.selectedSegmentIndex==0){
		_mapView.mapType=MKMapTypeStandard;
	}
	else if (mapType.selectedSegmentIndex==1){
		_mapView.mapType=MKMapTypeSatellite;
	}
	else if (mapType.selectedSegmentIndex==2){
		_mapView.mapType=MKMapTypeHybrid;
	}
}


- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"Reverse Geocoder Errored");
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	NSLog(@"Reverse Geocoder completed");
	mPlacemark=placemark;
	[_mapView addAnnotation:placemark];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	annView.animatesDrop=TRUE;
	return annView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
