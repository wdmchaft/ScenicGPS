//
//  RouteRootViewController.m
//  ScenicGPS
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "RouteRootViewController.h"
#import "GMapsRouter.h"
#import "GMapsRoute.h"
#import "PanoramioContent.h"
#import "ScenicContent.h"
#import "ScenicContentViewController.h"
#import "ScenicMapViewController.h"
#import "PanoramioFetcher.h"
#import "GMapsGeolocation.h"

@implementation RouteRootViewController
@synthesize startTF, endTF, routeLabel;

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    if ([fetcher isKindOfClass:[GMapsGeolocator class]])
    {
        [self handleGeoTag: (GMapsGeolocation*) response];
    }
    else if ([fetcher isKindOfClass:[PanoramioFetcher class]]) {
        [self handlePanoramio: (NSArray*) response];
    }
    else {
        [self handleRoutes: (NSArray*) response];
    }
    [fetcher release];
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose Origin/Destination";
}

-(void) handlePanoramio: (NSArray*) pts {
    ScenicMapViewController* smVC = [[ScenicMapViewController alloc] initWithNibName:@"ScenicMapViewController" bundle:nil];
    [self.navigationController pushViewController:smVC animated:YES];
    for (GMapsCoordinate* coord in pts) {
        [smVC.mapView addAnnotation:[[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([coord.lat doubleValue], [coord.lng doubleValue]) addressDictionary:nil] autorelease]];
    }
    [smVC release];
}

-(void) handleRoutes: (NSArray*) routes {
    
    ScenicMapViewController* smVC = [[ScenicMapViewController alloc] initWithNibName:@"ScenicMapViewController" bundle:nil];
    [self.navigationController pushViewController:smVC animated:YES];
    [smVC setRoute:(GMapsRoute*) [routes objectAtIndex:0]];
    [smVC release];
    
}

-(void) handleGeoTag: (GMapsGeolocation*) loc {
    PanoramioFetcher* serverFetch = [[PanoramioFetcher panDicFromCoord:loc.coord withDelegate:self] retain];
    [serverFetch fetch];
    routeLabel.text = loc.title;
    return;
}

-(IBAction) getGeoTag: (id) sender {
    GMapsGeolocator* fetcher = [[GMapsGeolocator geolocatorWithAddress:startTF.text withDelegate:self] retain];
    [fetcher fetch];
}

-(IBAction) getRoutes:(id)sender {
    GMapsRouter* router = [[GMapsRouter routeWithStart:startTF.text andEnd:endTF.text withDelegate:self] retain];
    [router fetch];
}

-(IBAction) getServerResource: (id) sender {
    PanoramioFetcher* fetcher = [[PanoramioFetcher panDicFromCoord:nil withDelegate:self] retain];
    [fetcher fetch];
}

@end
