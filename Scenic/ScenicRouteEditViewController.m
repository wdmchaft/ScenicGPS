//
//  ScenicRouteEditViewController.m
//  Scenic
//
//  Created by Dan Lynch on 4/5/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicRouteEditViewController.h"
#import "CDHelper.h"
#import "CDRoute.h"

@implementation ScenicRouteEditViewController
@synthesize route, rTitle, desc, delButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRoute:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil route:(CDRoute*)r
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        route = r;
        rTitle.text = r.title;
        desc.text = @"text goes here";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) deleteCDRoute {
    
    CDHelper * helper = [CDHelper sharedHelper];
    [helper deleteRoute:route];
    
    NSLog(@"attempted to delete route!");
    
    // need to tell table view to reload!
    // pop this view off as well
}

@end
