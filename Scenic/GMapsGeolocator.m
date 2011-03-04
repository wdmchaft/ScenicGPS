//
//  Gmaps.m
//  Scenic
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsGeolocator.h"
#import "JSONFetcher.h"
#import "GMapsGeolocation.h"


static NSString* base = @"http://maps.googleapis.com/maps/api/geocode/json";
static NSString* SENSOR_KEY = @"sensor";
static NSString* ADDRESS_KEY = @"address";
static NSString* RESULTS_KEY = @"results";
static NSString* GEOMETRY_KEY = @"geometry";
static NSString* LOCATION_KEY = @"location";
static NSString* LAT_KEY = @"lat";
static NSString* LNG_KEY = @"lng";
static NSString* FMT_ADDRESS_KEY = @"formatted_address";

@implementation GMapsGeolocator


-(id) getResponseFromResult:(id)result {
    NSDictionary* responseDic = (NSDictionary*) result;
    NSDictionary* resultDic =(NSDictionary*) [(NSArray*) [responseDic objectForKey:RESULTS_KEY] objectAtIndex:0];
    NSString* title = (NSString*) [resultDic objectForKey:FMT_ADDRESS_KEY];
    NSDictionary* locationDic =(NSDictionary*) [(NSDictionary*) [resultDic objectForKey:GEOMETRY_KEY] objectForKey:LOCATION_KEY];
    NSNumber* lat = (NSNumber*)[locationDic objectForKey:LAT_KEY];
    NSNumber* lng = (NSNumber*)[locationDic objectForKey:LNG_KEY];
    return [[[GMapsGeolocation alloc] initWithLat:lat andLng:lng andTitle:title] autorelease];
}


+(id) geolocatorWithAddress: (NSString*) description withDelegate: (id<DataFetcherDelegate>) _delegate {
    NSString* sensorString = @"false";
    NSDictionary* queries = [NSDictionary dictionaryWithObjectsAndKeys:description,ADDRESS_KEY,sensorString,SENSOR_KEY, nil];
    return [[[super alloc] initWithBase:base andQueries:queries andDelegate:_delegate] autorelease];
}

@end