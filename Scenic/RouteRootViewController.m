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
#import "ScenicParkFetcher.h"
#import "GMapsGeolocation.h"
#import "PanoramioPicFetcher.h"
#import "YelpFetcher.h"
#import "ScenicRoute.h"
#import "PanoramioFetcher.h"

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
    else if ([fetcher isKindOfClass:[ScenicParkFetcher class]]) {
        [self handleParks: (NSArray*) response];
    }
    else if ([fetcher isKindOfClass:[PanoramioFetcher class]]) {
        [self handlePanoramio:(NSArray*) response];
    }
    else if ([fetcher isKindOfClass:[YelpFetcher class]]){
        [self handleYelp: response];
    } else {        
        [self handleRoutes: (NSArray*) response];    
    }
    [fetcher release];
}

-(void) viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    self.title = @"Choose Origin/Destination";
}

-(void) handleParks: (NSArray*) pts {
    ScenicMapViewController* smVC = [[ScenicMapViewController alloc] initWithNibName:@"ScenicMapViewController" bundle:nil];
    [self.navigationController pushViewController:smVC animated:YES];
    for (GMapsCoordinate* coord in pts) {
        [smVC.mMapView addAnnotation:[[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([coord.lat doubleValue], [coord.lng doubleValue]) addressDictionary:nil] autorelease]];
    }
    [smVC release];
}

-(void) handleRoutes: (NSArray*) routes {
    
    ScenicMapViewController* smVC = [[ScenicMapViewController alloc] initWithNibName:@"ScenicMapViewController" bundle:nil routes:routes];
    [self.navigationController pushViewController:smVC animated:YES];
    [smVC release];
    
}

-(void) handlePanoramio:(NSArray*) contents {
    /*
    NSURL* MyURL = [NSURL URLWithString:(NSString*) [dic objectForKey:@"url"]];
    PanoramioContent* panCon = [[PanoramioContent alloc] init];
    panCon.url = MyURL;
    ScenicContent* scenic = [[ScenicContent alloc] init];
    scenic.contentProvider = panCon;
    scenic.title = (NSString*) [dic objectForKey:@"title"];
    ScenicContentViewController* vc = [[ScenicContentViewController alloc] initWithNibName:@"ScenicContentViewController" bundle:nil andContent:scenic];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    [panCon release];
    [scenic release]; */
    
    
    return;
}

-(void) handleYelp: (NSDictionary*) dic {
    //NSLog(@"%@", [dic description]);
}

-(void) handleGeoTag:(GMapsGeolocation *)loc {
    //YelpFetcher* fetcher = [[YelpFetcher fetcherForCoord:loc.coord andDelegate:self] retain];
    PanoramioFetcher* fetcher = [[PanoramioFetcher fetcherForCoord:loc.coord andDelegate:self] retain];
    [fetcher fetch];
}

-(IBAction) getGeoTag: (id) sender {
    GMapsGeolocator* fetcher = [[GMapsGeolocator geolocatorWithAddress:startTF.text withDelegate:self] retain];
    [fetcher fetch];
}

-(IBAction) getRoutes:(id)sender {
    GMapsRouter* router = [[GMapsRouter routeWithStart:startTF.text end:endTF.text scenicContents:nil scenicWaypoints:nil withDelegate:self] retain];
    [router fetch];
}

-(IBAction) getServerResource: (id) sender {
    ScenicParkFetcher* fetcher = [[ScenicParkFetcher parkFetcherWithDelegate:self] retain];
    [fetcher fetch];
}

-(IBAction) getPanoramio:(id)sender {
    return;
}

@end
