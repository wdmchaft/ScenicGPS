//
//  RouteRootViewController.h
//  ScenicGPS
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetcher.h"

@class GMapsGeolocation;
@interface RouteRootViewController : UIViewController <UITextFieldDelegate, DataFetcherDelegate> {
    UITextField* startTF;
    UITextField* endTF;
    UILabel* routeLabel;
}

@property (nonatomic, retain)   IBOutlet UITextField* startTF;
@property (nonatomic, retain)   IBOutlet UITextField* endTF;

@property (nonatomic, retain) IBOutlet UILabel* routeLabel;

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response;

-(IBAction) getRoutes: (id) sender;
-(IBAction) getGeoTag: (id) sender;
-(IBAction) getServerResource: (id) sender;
-(void) handlePanoramio: (NSDictionary*) dic;
-(void) handleRoutes: (NSArray*) routes;
-(void) handleGeoTag: (GMapsGeolocation*) loc;

@end