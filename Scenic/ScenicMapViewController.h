//
//  ScenicMapViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView, GMapsRoute;
@interface ScenicMapViewController : UIViewController {
    MKMapView* map;
}

@property (nonatomic, retain) MKMapView* map;
-(void) setRoute: (GMapsRoute*) route;
@end
