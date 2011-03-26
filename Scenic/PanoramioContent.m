//
//  PanoramioContent.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PanoramioContent.h"

static NSString* PHOTOS_KEY = @"photos";
static NSString* PHOTO_URL_KEY = @"photo_file_url";
static NSString* LAT_KEY = @"latitude";
static NSString* LNG_KEY = @"longitude";
static NSString* TITLE_KEY = @"photo_title";




@implementation PanoramioContent
@synthesize url;

-(UIView*) provideView {  
    return [[[UIImageView alloc] initWithImage:[self fetchImage]] autorelease];
}

-(UIImage*) fetchImage {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

-(UIImage*) iconImage {
    return [self fetchImage];
}

-(NSString*) tag {
    return @"Pano";
}

- (void) dealloc {
    [url release];
    [super dealloc];
}

+(NSArray*) contentsFromJSONDic: (NSDictionary*) dic {
    NSArray* photos = (NSArray*) [dic objectForKey:PHOTOS_KEY];
    int nArray = [photos count];
    NSMutableArray* contents = [[NSMutableArray alloc] initWithCapacity:nArray];
    for (NSDictionary* photo in photos) {
        double lat = [((NSNumber*) [photo objectForKey:LAT_KEY]) doubleValue];
        double lng = [((NSNumber*) [photo objectForKey:LNG_KEY]) doubleValue];
        GMapsCoordinate* coord = [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(lat, lng)];
        NSString* title = (NSString*) [photo objectForKey:TITLE_KEY];
        NSURL* url = [NSURL URLWithString:(NSString*) [photo objectForKey:PHOTO_URL_KEY]];
        PanoramioContent* content = [[PanoramioContent alloc] init];
        content.url = url;
        content.coord = coord;
        content.title = title;
        [contents addObject:content];
        [content release];
    }
    NSArray* finalArray = [NSArray arrayWithArray:contents];
    [contents release];
    return finalArray;
}

@end
