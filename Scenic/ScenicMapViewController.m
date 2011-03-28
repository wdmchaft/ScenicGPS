//
//  ScenicMapViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/7/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapViewController.h"
#import <MapKit/MapKit.h>
#import "GMapsRoute.h"
#import "GMapsRouter.h"
#import "ScenicMapView.h"
#import "ScenicRoute.h"

@implementation ScenicMapViewController
@synthesize mMapView, mapType, model, toggleMapType, mapTypeToolbar, routePicker;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - View lifecycle
-(void) setInitialRoutes: (NSArray*) routes {
    [self.mMapView setInitialRoutes:routes];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.mMapView.navigationController = self.navigationController;
    self.mMapView.scenicDelegate = self;
}


-(void) scenicMapViewUpdatedRoutes {
    [self updateRoutePicker];
    [self updateTitle];
}

-(IBAction) hideToolbar: (id) sender {
    [self.mapTypeToolbar setHidden:YES];
    [self.toggleMapType setHidden:NO];
}
-(IBAction) showToolbar: (id) sender {
    [self.mapTypeToolbar setHidden:NO];
    [self.toggleMapType setHidden:YES];
}

-(IBAction) changeMapType: (id) sender {
    switch (self.mapType.selectedSegmentIndex) {
        case 0:
            self.mMapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mMapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mMapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

-(IBAction) changeRoute: (id) sender {
    [self.mMapView changeToRouteNumber:self.routePicker.selectedSegmentIndex];
}

- (void)changeType {
	if(mapType.selectedSegmentIndex==0){
		mMapView.mapType=MKMapTypeStandard;
	}
	else if (mapType.selectedSegmentIndex==1){
		mMapView.mapType=MKMapTypeSatellite;
	}
	else if (mapType.selectedSegmentIndex==2){
		mMapView.mapType=MKMapTypeHybrid;
	}
}



-(void) updateRoutePicker {
    int nRoutes = [self.mMapView.model.routes count];
    if (nRoutes < 2) {
        self.routePicker.hidden = YES;
        return;
    }
    self.routePicker.hidden = NO;
    int oldNRoutes = self.routePicker.numberOfSegments;
    int difference = oldNRoutes - nRoutes;
    if (difference == 0) return;
    if (difference > 0) {
        for (int i = 0; i < difference; i++) {
            [self.routePicker removeSegmentAtIndex:self.routePicker.numberOfSegments - 1 animated:YES];
        }
        return;
    }
    for (int i = 0; i > difference; i--) {
        [self.routePicker insertSegmentWithTitle:[NSString stringWithFormat:@"%i",self.routePicker.numberOfSegments+1] atIndex:self.routePicker.numberOfSegments animated:YES];
    }
    self.routePicker.selectedSegmentIndex = 0;
    return;
    
}

-(void) updateTitle {
    self.title = [self.mMapView.model primaryRoute].gRoute.summary;
}


- (void)gotoLocation:(CLLocation *) location{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = location.coordinate.latitude;
    newRegion.center.longitude = location.coordinate.longitude;
    newRegion.span.latitudeDelta = 0.1;
    newRegion.span.longitudeDelta = 0.1;
    [self.mMapView setRegion:newRegion animated:YES];
}

- (void)dealloc
{
    [super dealloc];
    [mMapView release];
}

@end
