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
@synthesize map;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    MKMapView* mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeHybrid;
    self.map = mapView;
    [self.view addSubview:map];
    [mapView release];

}

-(void) setRoute: (GMapsRoute*) route {
    self.title = route.summary;
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
    [map setRegion:region animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
