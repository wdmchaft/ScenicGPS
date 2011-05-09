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
#import "ScenicParkFetcher.h"
#import "GMapsGeolocation.h"
#import "PanoramioPicFetcher.h"
#import "YelpFetcher.h"
#import "ScenicRoute.h"
#import "PanoramioFetcher.h"

@implementation RouteRootViewController
@synthesize startTF, endTF, routeLabel;

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
     
    [self handleRoutes: (NSArray*) response];
}

-(void) viewDidLoad {
    [super viewDidLoad];
    UIColor* color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"frontpage.png"]];
    self.view.backgroundColor = color;
    [color release];
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    self.title = @"Choose Origin/Destination";
}

-(void) handleRoutes: (NSArray*) routes {
    
    ScenicMapViewController* smVC = [[ScenicMapViewController alloc] initWithNibName:@"ScenicMapViewController" bundle:nil routes:routes];
    [self.navigationController pushViewController:smVC animated:YES];
    [smVC release];
    
}

-(IBAction) getRoutes:(id)sender {
    GMapsRouter* router = [[GMapsRouter routeWithStart:startTF.text end:endTF.text scenicContents:nil scenicWaypoints:nil withDelegate:self] retain];
    [router fetch];
}

@end
