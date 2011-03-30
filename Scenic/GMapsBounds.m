//
//  GMapsBounds.m
//  Scenic
//
//  Created by Jack Reilly on 3/4/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GMapsBounds.h"
#import "GMapsCoordinate.h"

static NSString* NE_KEY = @"northeast";
static NSString* SW_KEY = @"southwest";



@implementation GMapsBounds
@synthesize ne,sw;


+(id) boundsFromJSONDic: (NSDictionary*) dic {
    GMapsBounds* bounds =  [[[GMapsBounds alloc] init] autorelease];
    bounds.ne = [GMapsCoordinate coordFromJSONDic:(NSDictionary*) [dic objectForKey:NE_KEY]];
    bounds.sw = [GMapsCoordinate coordFromJSONDic:(NSDictionary*) [dic objectForKey:SW_KEY]];
    return bounds;
    
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.ne];
    [aCoder encodeObject:self.sw];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.ne = [aDecoder decodeObject];
        self.sw = [aDecoder decodeObject];
    }
    return self;
}

@end
