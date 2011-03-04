//
//  RouteRootViewController.h
//  ScenicGPS
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMapsGeolocator.h"


@interface RouteRootViewController : UIViewController <UITextFieldDelegate, DataFetcherDelegate> {
    UITextField* descriptionTF;
    UILabel* latLabel;
    UILabel* lngLabel;
    UILabel* titleLabel;
}

@property (nonatomic, retain)   IBOutlet UITextField* descriptionTF;
@property (nonatomic, retain) IBOutlet UILabel* latLabel;
@property (nonatomic, retain) IBOutlet UILabel* lngLabel;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response;

@end
