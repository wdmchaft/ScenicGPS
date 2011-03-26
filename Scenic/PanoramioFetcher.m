//
//  PanoramioFetcher.m
//  Scenic
//
//  Created by Jack Reilly on 3/26/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PanoramioFetcher.h"
#import "PanoramioContent.h"
#import "GMapsBounds.h"

static NSString* base = @"http://www.panoramio.com/map/get_panoramas.php";
static NSString* SET_KEY = @"set";
static NSString* SET_VALUE = @"public";
static NSString* SIZE_KEY = @"size";
static NSString* DEF_SIZE = @"medium";
static NSString* FILTER_KEY = @"mapfilter";
static NSString* DEF_FILTER = @"true";
static NSString* FROM_KEY = @"from";
static NSString* TO_KEY = @"to";
static NSString* MINX_KEY = @"minx";
static NSString* MAXX_KEY = @"maxx";
static NSString* MINY_KEY = @"miny";
static NSString* MAXY_KEY = @"maxy";
static NSString* DEF_FROM = @"0";

static double DEF_RANGE_DEGREES = .1f;
static int DEF_N_RETURNS = 20;

@implementation PanoramioFetcher

-(id) getResponseFromResult:(id)result {
    NSDictionary* dic = (NSDictionary*) result;
    return [PanoramioContent contentsFromJSONDic:dic];
}


+(id) fetcherForCoord: (GMapsCoordinate*) coord andDelegate: (id<DataFetcherDelegate>) _delegate {
    double range = DEF_RANGE_DEGREES;
    double lng = [coord.lng doubleValue];
    double lat = [coord.lat doubleValue];
    double minx = lng - range / 2;
    double maxx = lng + range / 2;
    double miny = lng - range / 2;
    double maxy = lat + range / 2;
    GMapsBounds* bounds = [[[GMapsBounds alloc] init] autorelease];
    bounds.sw = [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(minx, miny)];
    bounds.ne = [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(maxx, maxy)];
    return [PanoramioFetcher fetcherForBounds:bounds andDelegate:_delegate];
    
}

+(id) fetcherForBounds: (GMapsBounds*) bounds andDelegate: (id<DataFetcherDelegate>) _delegate {
    
    NSMutableDictionary* queries = [[NSMutableDictionary alloc] init];
    [queries setObject:SET_VALUE forKey:SET_KEY];
    [queries setObject:DEF_SIZE forKey:SIZE_KEY];
    [queries setObject:DEF_FILTER forKey:FILTER_KEY];
    [queries setObject:[NSString stringWithFormat:@"%f",[bounds.sw.lng doubleValue]] forKey:MINX_KEY];
    [queries setObject:[NSString stringWithFormat:@"%f",[bounds.ne.lng doubleValue]] forKey:MAXX_KEY];
    [queries setObject:[NSString stringWithFormat:@"%f",[bounds.sw.lat doubleValue]] forKey:MINY_KEY];
    [queries setObject:[NSString stringWithFormat:@"%f",[bounds.ne.lat doubleValue]] forKey:MAXY_KEY];
    [queries setObject:@"0" forKey:FROM_KEY];
    [queries setObject:[NSString stringWithFormat:@"%i",DEF_N_RETURNS] forKey:TO_KEY];
    NSDictionary* queriesDic = [NSDictionary dictionaryWithDictionary:queries];
    [queries release];
    return [[[super alloc] initWithBase:base andQueries:queriesDic andDelegate:_delegate] autorelease];
}

@end
