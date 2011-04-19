//
//  PanoramioRater.m
//  Scenic
//
//  Created by Jack Reilly on 4/18/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PanoramioRater.h"
#import "PanoramioContent.h"
static NSString* URL_KEY = @"contenturl";
static NSString* PAN_KEY = @"panrate";


@implementation PanoramioRater

+(NSDictionary*) queriesWithContent: (ScenicContent*) content andRating: (int) rating {
    NSDictionary* queries = [super queriesWithContent:content andRating:rating];
    PanoramioContent* pContent = (PanoramioContent*) content;
    NSString* url = [pContent.url description];
    NSMutableDictionary* newQueries = [NSMutableDictionary dictionaryWithDictionary:queries];
    [newQueries setObject:url forKey:URL_KEY];
    return [NSDictionary dictionaryWithDictionary:newQueries];
}

+(NSString*) command {
    return PAN_KEY;
}



@end
