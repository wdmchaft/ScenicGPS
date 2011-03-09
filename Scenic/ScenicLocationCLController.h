//
//  ScenicLocationCLController.h
//  Scenic
//
//  Created by Dan Lynch on 3/9/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

// thanks for the tips on this site for using CoreLocation
// http://www.mobileorchard.com/hello-there-a-corelocation-tutorial/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol ScenicLocationCLControllerDelegate <NSObject>
@required
- (void)locationUpdate:(CLLocation *)location; 
- (void)locationError:(NSError *)error;
@end

@interface ScenicLocationCLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) id <ScenicLocationCLControllerDelegate> delegate;

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error;

@end