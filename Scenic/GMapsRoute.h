//
//  GMapsRoute.h
//  Scenic
//
//  Created by Jack Reilly on 3/3/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GMapsRoute : NSObject {
    NSString* summary;
    
    
}

@property (nonatomic, retain) NSString* summary;

+(id) routeFromJSONDictionary: (NSDictionary*) dic;

@end
