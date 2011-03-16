//
//  ScenicMapSelectorModel.h
//  Scenic
//
//  Created by Jack Reilly on 3/15/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScenicRoute, ScenicContent;
@interface ScenicMapSelectorModel : NSObject {
    NSArray* routes;
    int primaryRouteIndex;
    NSMutableArray* scenicContents;
}

@property (nonatomic, retain) NSArray* routes;
@property (nonatomic, assign) int primaryRouteIndex;
@property (nonatomic, retain) NSMutableArray* scenicContents;


-(void) initContents;
-(void) addContent: (ScenicContent*) content;
-(NSArray*) secondaryRoutes;
-(ScenicRoute*) primaryRoute;
-(NSArray*) testContent;
-(void) addTestContent;
@end
