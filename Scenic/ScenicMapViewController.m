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

@implementation ScenicMapViewController
@synthesize mapView, mPlacemark, mapType, locationController, currentLocation, mapAnnotations, currentRoute;

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
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:3];
    
    [GeoHash hash:CLLocationCoordinate2DMake(57.64911,10.40744)];
    // should be  u4pruydqqvj
    
    // annotation for the City of San Francisco
    ScenicAnnotation *sf = [[ScenicAnnotation alloc] init];
    [sf setCoordinate:CLLocationCoordinate2DMake(37.786996, -122.419281)];
    [sf setTitle:@"San Francisco"];
    [sf setSubtitle:@"Founded: June 29, 1776"];
    [self.mapAnnotations insertObject:sf atIndex:0];
    [sf release];
    
    // grace cathedral
    ScenicAnnotation *gt = [[ScenicAnnotation alloc] init];
    [gt setCoordinate:CLLocationCoordinate2DMake(37.791847, -122.412891)];	
    [gt setTitle:@"Grace Cathedral"];
    [gt setSubtitle:@"Grace Cathedral is a house of prayer for all people."];
    [self.mapAnnotations insertObject:gt atIndex:1];
    [gt release];
                                                 
    // the embarcadero
    ScenicAnnotation *em = [[ScenicAnnotation alloc] init];
    [em setCoordinate:CLLocationCoordinate2DMake(37.7945047, -122.3940806)];	
    [em setTitle:@"The Embarcadero"];
    [em setSubtitle:@"Whether it's family fun, unique shopping, an up-close look at California's playful sea lions, an encounter with a street performer or delightful dining, San Francisco's PIER 39 is the place to be -- for PIER FUN!"];
    [self.mapAnnotations insertObject:em atIndex:2];
    [em release];
    
    [mapView addAnnotations:mapAnnotations];
    
}

-(void) setRoute: (GMapsRoute*) route {
    self.currentRoute = route;
    [self.mapView removeOverlays: [self.mapView overlays]];
    [self drawRoute];
}

-(void) drawRoute {
    self.title = currentRoute.summary;
    
    
    CLLocationCoordinate2D startPos = [currentRoute startPos];
    MKReverseGeocoder * geoCoderStart=[[MKReverseGeocoder alloc] initWithCoordinate:startPos];
    [geoCoderStart setDelegate:self];
    [geoCoderStart start];
    
    CLLocationCoordinate2D endPos = [currentRoute endPos];
    MKReverseGeocoder * geoCoderEnd=[[MKReverseGeocoder alloc] initWithCoordinate:endPos];
    [geoCoderEnd setDelegate:self];
    [geoCoderEnd start];
    
    GMapsCoordinate* sw = currentRoute.bounds.sw;
    GMapsCoordinate* ne = currentRoute.bounds.ne;
    double swlat = [sw.lat doubleValue];
    double swlng = [sw.lng doubleValue];
    double nelat = [ne.lat doubleValue];
    double nelng = [ne.lng doubleValue];
    CLLocationCoordinate2D center = {.latitude = (swlat + nelat)*.5,
        .longitude = (swlng + nelng)*.5};
    MKCoordinateSpan span =  MKCoordinateSpanMake(nelat - swlat, nelng - swlng);
    MKCoordinateRegion region = {center, span};
    [mapView setRegion:region animated:YES];
    [mapView addOverlay:[currentRoute polylineOverlay]];
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
    
    if ([annotation isKindOfClass:[ScenicAnnotation class]]) {
        static NSString* ScenicAnnotationIdentifier = @"ScenicAnnotationIdentifier";
        MKPinAnnotationView* pinView =
        (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ScenicAnnotationIdentifier];
        if (!pinView)
        {
            MKAnnotationView *annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                             reuseIdentifier:ScenicAnnotationIdentifier] autorelease];
            annotationView.canShowCallout = YES;
            
            UIImage *flagImage = [UIImage imageNamed:@"location.png"];
            
            CGRect resizeRect;
            
            resizeRect.size = flagImage.size;
            CGSize maxSize = CGRectInset(self.view.bounds,
                                         [ScenicMapViewController annotationPadding],
                                         [ScenicMapViewController annotationPadding]).size;
            maxSize.height -= self.navigationController.navigationBar.frame.size.height + [ScenicMapViewController calloutHeight];
            if (resizeRect.size.width > maxSize.width)
                resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
            if (resizeRect.size.height > maxSize.height)
                resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
            
            resizeRect.origin = (CGPoint){0.0f, 0.0f};
            UIGraphicsBeginImageContext(resizeRect.size);
            [flagImage drawInRect:resizeRect];
            UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            annotationView.image = resizedImage;
            annotationView.opaque = NO;
            
            UIImageView *sfIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dest.png"]];
            annotationView.leftCalloutAccessoryView = sfIconView;
            [sfIconView release];
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
            //[GeoHash hash:[(ScenicAnnotation *)annotation getCoordinate]];
            annotationView.rightCalloutAccessoryView = rightButton;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(0.0,0.0, 28.0, 28.0)];
            [button setImage:[UIImage imageNamed:@"add-28.png"] forState:UIControlStateNormal];
            annotationView.leftCalloutAccessoryView = button;
            
            
            return annotationView;
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

    ScenicAnnotation * a = view.annotation;
    NSLog(@"we have %@", a);
    
    ScenicContent* content = [[ScenicContent alloc] init];
    content.title = a.title;
    content.coord = [GMapsCoordinate coordFromCLCoord:a.coordinate];
    
    if( view.leftCalloutAccessoryView == control) {
        [self addWaypointWithContent:content];
        return;
    }
    
    
    ScenicContentTextVC* textVC = [[ScenicContentTextVC alloc] initWithNibName:@"ScenicContentTextVC" bundle:nil andDescription:a.subtitle];
    content.contentProvider = textVC;
    [textVC release];
    ScenicContentViewController* scenicVC = [[ScenicContentViewController alloc] initWithNibName:@"ScenicContentViewController" bundle:nil andContent:content];
    [content release];
    
    ScenicWaypointViewController* waypointVC = [[ScenicWaypointViewController alloc] init];
    waypointVC.mainVC = scenicVC;
    waypointVC.delegate = self;
    [scenicVC release];
    
    
    
    [self.navigationController pushViewController:waypointVC animated:YES];
    [waypointVC release];

    
    
    
    
}

-(void) addWaypointWithContent:(ScenicContent*)content {
    GMapsRouter* router = [[GMapsRouter routeWithStart:[[currentRoute startCoord] pairString] end:[[currentRoute endCoord] pairString] waypoints:[NSArray arrayWithObject:[content.coord pairString]] withDelegate:self] retain];
    [router fetch];
}

-(void) dataFetcher:(DataFetcher *)fetcher hasResponse:(id)response {
    NSArray* routes = (NSArray*) response;
    [self setRoute:(GMapsRoute*) [routes objectAtIndex:0]];
}

@end
