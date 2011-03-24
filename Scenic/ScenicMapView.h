//
//  ScenicMapView.h
//  Scenic
//
//  Created by Jack Reilly on 3/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ScenicMapView : MKMapView {
    
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
