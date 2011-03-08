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
#import "PanoramioContent.h"
#import "ScenicContent.h"
#import "ScenicContentViewController.h"
#import "ScenicMapViewController.h"

@implementation RouteRootViewController
@synthesize startTF, endTF, routeLabel;

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    [fetcher release];

    /*
    NSArray* routes = (NSArray*) response;
    NSString* routesString = @"";
    for (GMapsRoute* route in routes) {
        routesString = [routesString stringByAppendingFormat:@"%@,",route.summary];
    } 
    routeLabel.text = routesString;
    */
    ScenicMapViewController * MV = [[ScenicMapViewController alloc] initWithNibName:@"ScenicMapViewController" bundle:nil];
    
    [self.navigationController pushViewController:MV animated:YES];
    
}

-(IBAction) getRoutes:(id)sender {
    GMapsRouter* router = [[GMapsRouter routeWithStart:startTF.text andEnd:endTF.text withDelegate:self] retain];
    [router fetch];
}

-(IBAction) addTwitPic: (id) sender {
    NSURL* MyURL = [NSURL URLWithString:@"http://3.bp.blogspot.com/-vzKYcr3ueLs/TXUPZbrO-HI/AAAAAAAAAPg/NBPOO2KR2hs/s400/mets2_clean.png"];
    PanoramioContent* panCon = [[PanoramioContent alloc] init];
    panCon.url = MyURL;
    ScenicContent* scenic = [[ScenicContent alloc] init];
    scenic.contentProvider = panCon;
    scenic.title = @"this is the twitpic";
    ScenicContentViewController* vc = [[ScenicContentViewController alloc] initWithNibName:@"ScenicContentViewController" bundle:nil andContent:scenic];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    [panCon release];
    [scenic release];
}

@end
