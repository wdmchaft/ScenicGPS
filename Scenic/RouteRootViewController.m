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
        [self handlePanoramio: (NSDictionary*) response];
    }
    else {
        [self handleRoutes: (NSArray*) response];
    }
    [fetcher release];

<<<<<<< HEAD
=======
    /*
    NSArray* routes = (NSArray*) response;
    NSString* routesString = @"";
    for (GMapsRoute* route in routes) {
        routesString = [routesString stringByAppendingFormat:@"%@,",route.summary];
    } 
    routeLabel.text = routesString;
    */
    
    ScenicMapViewController * MV = [[ScenicMapViewController alloc] init];
    
    [self.navigationController pushViewController:MV animated:YES];
    
>>>>>>> 76febd0910fc43c67359abce750daf4635f78323
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose Origin/Destination";
}

-(void) handlePanoramio: (NSDictionary*) dic {
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
    [scenic release];
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
    GMapsCoordinate* coord = [[GMapsCoordinate alloc] init];
    coord.lat = [NSNumber numberWithDouble:37.87];
    coord.lng = [NSNumber numberWithDouble:-122.46];
    
    PanoramioFetcher* fetcher = [[PanoramioFetcher panDicFromCoord:coord withDelegate:self] retain];
    [fetcher fetch];
}

@end
