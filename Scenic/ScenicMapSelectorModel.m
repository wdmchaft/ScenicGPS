//
//  ScenicMapSelectorModel.m
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapSelectorModel.h"
#import "ScenicRoute.h"
#import "ScenicContent.h"
#import "GMapsCoordinate.h"
#import "GMapsBounds.h"
#import "PanoramioContent.h"
#import "ScenicTextContent.h"
#import "PanoramioFetcher.h"
#import "UserPhotoContentGetter.h"


@implementation ScenicMapSelectorModel
@synthesize routes, scenicContents, primaryRouteIndex, locationManager, delegate;
@synthesize frozen;

-(id) init {
    if ((self = [super init])) {
        [self initContents];
        CLLocationManager* manager = [[CLLocationManager alloc] init]; 
        manager.delegate = self;
        [manager startUpdatingLocation];
        self.locationManager = manager;
        self.frozen = NO;
        [self.locationManager startUpdatingHeading];
        [manager release];
    }
    return self;
}

#pragma mark - Waypoints

-(void) addWaypointWithContent:(ScenicContent*)content {
    [self addContentToPrimaryRoute:content];
    [self refetch];
}

-(void) removeWaypointWithContent:(ScenicContent*)content {
    [self removeContentFromPrimaryRoute:content];
    [self refetch];
}

#pragma mark - Fetcher

-(void) refetch {
    GMapsRouter* router = [GMapsRouter routeWithScenicRoute:[self primaryRoute] andDelegate:self];
    [router fetch];
}

-(void) dataFetcher:(DataFetcher *)fetcher hasResponse:(id)response {
    
    if ([fetcher isKindOfClass:[GMapsRouter class]]) {
        NSArray* newRoutes = (NSArray*) response;
        self.routes = newRoutes;
        self.primaryRouteIndex = 0;
        if (delegate != nil)
            [delegate mapSelectorModelFinishedGettingRoutes:self];
    } else if ([fetcher isKindOfClass:[PanoramioFetcher class]] ||[fetcher isKindOfClass:[UserPhotoContentGetter class]] ) {
        NSArray* newContents = (NSArray*) response;
        [self.scenicContents addObjectsFromArray:newContents];
        [self.delegate mapSelectorModelFinishedFetchingContent:self];
    } 
}

-(void) dealloc {
    [super dealloc];
    [routes release];
    [scenicContents release];
}

-(ScenicRoute*) primaryRoute {
    return (ScenicRoute*) [self.routes objectAtIndex:self.primaryRouteIndex];
}

-(NSArray*) secondaryRoutes {
    NSMutableArray* temp = [NSMutableArray arrayWithArray:self.routes];
    [temp removeObjectAtIndex:self.primaryRouteIndex];
    return [NSArray arrayWithArray:temp];
}

-(void) addContent: (ScenicContent*) content {
    if (!self.scenicContents) {
        [self initContents];
    }
    [self.scenicContents addObject:content];
}

-(void) initContents {
    NSMutableArray* temp = [[NSMutableArray alloc] initWithCapacity:10];
    self.scenicContents = temp;
    [temp release];
}

-(void) addContentToPrimaryRoute: (ScenicContent*) content {
    [[self primaryRoute] addContent:content];
}

-(void) removeContentFromPrimaryRoute: (ScenicContent*) content {
    [[self primaryRoute] removeContent:content];
}

-(void) addTestContent {
    for (ScenicContent* content in [self testContent]) {
        [self addContent:content];
    }
}

-(NSArray*) testContent {
    NSMutableArray* temp = [[[NSMutableArray alloc] initWithCapacity:4] autorelease];
    
    NSArray* cityTitles = [NSArray arrayWithObjects:@"San Francisco",@"San Francisco",@"San Francisco",@"San Francisco",@"San Francisco",@"San Francisco",@"San Francisco", @"Grace Cathedral", @"The Embarcadero",@"Sacramento",  nil];
    NSArray* cityDescriptions = [NSArray arrayWithObjects:@"SF", @"SF", @"SF", @"SF", @"SF", @"SF", @"Founded: June 29, 1776", @"Grace Cathedral is a house of prayer for all people.", @"Whether it's family fun, unique shopping, an up-close look at California's playful sea lions, an encounter with a street performer or delightful dining, San Francisco's PIER 39 is the place to be -- for PIER FUN!",@"Go Kings!",  nil];
    NSArray* locs = [NSArray arrayWithObjects:
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.786996, -122.419281)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.786, -122.419)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.786996, -122.46)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.778, -122.40)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.7996, -122.49281)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.76, -122.4281)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.791847, -122.412891)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.7945047, -122.3940806)],
                     [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(38.6, -121.5) ], nil];
    
    
    for (int i = 0; i < [locs count]; i++) {
        [temp addObject:[ScenicTextContent contentWithTitle:[cityTitles objectAtIndex:i] subTitle:[cityDescriptions objectAtIndex:i] coordinate:[locs objectAtIndex:i]]];
    }
    
    PanoramioContent* pc = [[PanoramioContent alloc] init];
    pc.title = @"google";
    pc.coord = [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.73,-122.37)];
    pc.url = [NSURL URLWithString:@"http://www.tnpsc.com/downloads/NaturesScenery.jpg"];
    [temp addObject:pc];
    [pc release];
    return temp;
}

-(void) fetchNewContentWithBounds:(GMapsBounds*)bounds {
    PanoramioFetcher* fetcher = [PanoramioFetcher fetcherForBounds:bounds  andDelegate:self];
    [fetcher fetch];
    UserPhotoContentGetter* getter = [UserPhotoContentGetter photoGetterWithDelegate:self andCoordinate:[bounds midPoint]];
    [getter fetch];
}



-(void) fetchNewContentWithCoord:(GMapsCoordinate*)coord {
    PanoramioFetcher* fetcher = [PanoramioFetcher fetcherForCoord:coord andDelegate:self];
    [fetcher fetch];
}

#pragma mark - LocationManager Delegate

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    return;
}

-(void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
//    NSLog(@"heading updated");
//        
//    NSLog(@"magnetic heading: %f", newHeading.magneticHeading);
//    NSLog(@"true heading: %f", newHeading.trueHeading);
//    
    [delegate mapSelectorModelHeadingUpdate:newHeading];
}

-(id) copyWithZone:(NSZone *)zone {
    ScenicMapSelectorModel* modelCopy = [[ScenicMapSelectorModel allocWithZone:zone] init];
    modelCopy.scenicContents = [NSMutableArray arrayWithArray:self.scenicContents];
    modelCopy.locationManager = self.locationManager;
    modelCopy.frozen = self.frozen;
    modelCopy.primaryRouteIndex = self.primaryRouteIndex;
    modelCopy.routes = [NSArray arrayWithArray:self.routes];
    return modelCopy;
}

@end
