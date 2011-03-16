//
//  ScenicTextContent.m
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicTextContent.h"
#import "ScenicContent.h"
#import "GMapsCoordinate.h"
#import "ScenicContentTextVC.h"

@implementation ScenicTextContent




+(id) contentWithTitle: (NSString*) t subTitle: (NSString*) st coordinate: (GMapsCoordinate*) _coord {
    ScenicContent* sf = [[ScenicContent alloc] init];
    sf.coord = [GMapsCoordinate coordFromCLCoord:CLLocationCoordinate2DMake(37.786996, -122.419281)];
    sf.title = t;
    ScenicContentTextVC* sft = [[ScenicContentTextVC alloc] initWithNibName:@"ScenicContentTextVC" bundle:nil andDescription:st];
    sf.contentProvider = sft;
    sf.coord = _coord;
    [sft release];
    return [sf autorelease];
}

@end
