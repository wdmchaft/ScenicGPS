//
//  PlacePutter.h
//  Scenic
//
//  Created by Dan Lynch on 4/17/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerPutter.h"
#import "GMapsCoordinate.h"

@interface PlacePutter : ServerPutter {
    
}

+(id) putterWithCoords: (GMapsCoordinate*) coord rating: (int) rating andDelegate: (id<ServerPutterDelegate>) _pDelegate;

@end
