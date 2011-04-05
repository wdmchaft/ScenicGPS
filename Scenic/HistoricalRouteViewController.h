//
//  HistoricalRouteViewController.h
//  Scenic
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HistoricalRouteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *tableOfRoutes;
    NSArray * routes;
    
}

- (void) pushEditView:(id)sender;

@property (nonatomic, retain) IBOutlet NSArray * routes;
@property (nonatomic, retain) IBOutlet UITableView *tableOfRoutes;

@end
