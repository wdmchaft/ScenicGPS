//
//  PlacePutter.m
//  Scenic
//
//  Created by Dan Lynch on 4/17/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ContentRater.h"
#import "ScenicContent.h"

static NSString* LAT_KEY = @"lat";
static NSString* LNG_KEY = @"lng";
static NSString* RATING_KEY = @"rating";
static NSString* DEVICE_KEY = @"deviceid";
static NSString* TITLE_KEY = @"title";
static NSString* CONTENT_COMMAND = @"content";


#define i2s(x) [NSString stringWithFormat:@"%i",x]
#define i2f(x) [NSString stringWithFormat:@"%f",x]

@implementation ContentRater

+(id) putterWithContent: (ScenicContent*) content rating: (int) rating andDelegate: (id<ServerPutterDelegate>) _pDelegate {
    

    return [ContentRater serverPutterWithCommand:[ContentRater command] queries:[self queriesWithContent:content andRating:rating] delegate:_pDelegate];
}

+(NSDictionary*) queriesWithContent: (ScenicContent*) content andRating: (int) rating
{
    GMapsCoordinate* coord = content.coord;
    NSString* title = content.title;
    
    return [NSDictionary dictionaryWithObjectsAndKeys:i2f([coord.lat doubleValue]), LAT_KEY, i2f([coord.lng doubleValue]), LNG_KEY,i2s(rating),RATING_KEY, [[UIDevice currentDevice] uniqueIdentifier], DEVICE_KEY,title,TITLE_KEY, nil];
}

+(NSString*) command {
    return CONTENT_COMMAND;
}

@end
