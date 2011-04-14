//
//  RoutePutter.h
//  Scenic
//
//  Created by Jack Reilly on 4/13/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerPutter.h"

@class GMapsPolyline;
@interface RoutePutter : ServerPutter {
    
}

+(id) putterWithPL: (GMapsPolyline*) pl rating: (int) rating andDelegate: (id<ServerPutterDelegate>) _pDelegate;

@end
