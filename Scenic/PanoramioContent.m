//
//  PanoramioContent.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "PanoramioContent.h"
#import <QuartzCore/QuartzCore.h>

static NSString* PHOTOS_KEY = @"photos";
static NSString* PHOTO_URL_KEY = @"photo_file_url";
static NSString* LAT_KEY = @"latitude";
static NSString* LNG_KEY = @"longitude";
static NSString* TITLE_KEY = @"photo_title";




@implementation PanoramioContent
@synthesize url;


-(id) init {
    if ((self = [super init])) {
        self.contentProvider = self;
    }
    return self;
}

-(UIView*) provideView {  
    return [[[UIImageView alloc] initWithImage:[self fetchImage]] autorelease];
}

-(UIImage*) fetchImage {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

-(UIImage*) iconImage {
    return [self imageWithBorderFromImage:[self fetchImage]];
}

-(NSString*) tag {
    return [self.url description];
}

- (void) dealloc {
    [url release];
    [super dealloc];
}

- (UIImage*)imageWithBorderFromImage:(UIImage*)source
{
    CGSize size = [source size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0); 
    CGContextSetLineWidth(context, size.width/(20.));
    CGContextStrokeRect(context, rect);
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return testImg;
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

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.url];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.url = [aDecoder decodeObject];
    }
    return self;
}

@end
