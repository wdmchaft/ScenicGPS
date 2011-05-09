//
//  UserContentRater.m
//  Scenic
//
//  Created by Dan Lynch on 5/8/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "UserContentRater.h"
#import "UserPhotoContent.h"

static NSString* PK_KEY = @"pk";
static NSString* UPC_KEY = @"photorate";


@implementation UserContentRater

+(NSDictionary*) queriesWithContent: (ScenicContent*) content andRating: (int) rating {
    NSDictionary* queries = [super queriesWithContent:content andRating:rating];
    UserPhotoContent* uContent = (UserPhotoContent*) content;
    NSMutableDictionary* newQueries = [NSMutableDictionary dictionaryWithDictionary:queries];
    NSString * primaryKey = [[[NSString alloc] initWithFormat:@"%d", uContent.pk] autorelease];
    [newQueries setObject:primaryKey forKey:PK_KEY];
    return [NSDictionary dictionaryWithDictionary:newQueries];
}

+(NSString*) command {
    return UPC_KEY;
}

@end
