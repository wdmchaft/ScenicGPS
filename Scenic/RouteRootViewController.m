//
//  RouteRootViewController.m
//  ScenicGPS
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "RouteRootViewController.h"
#import "GMapsRouter.h"
#import "GMapsRoute.h"


@implementation RouteRootViewController
@synthesize startTF, endTF, routeLabel;

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    [fetcher release];
    NSArray* routes = (NSArray*) response;
    NSString* routesString = @"";
    for (GMapsRoute* route in routes) {
        routesString = [routesString stringByAppendingFormat:@"%@,",route.summary];
    }
    routeLabel.text = routesString;
    
}

-(IBAction) getRoutes:(id)sender {
    GMapsRouter* router = [[GMapsRouter routeWithStart:startTF.text andEnd:endTF.text withDelegate:self] retain];
    [router fetch];
}

@end
