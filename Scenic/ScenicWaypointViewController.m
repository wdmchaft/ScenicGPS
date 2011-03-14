//
//  ScenicWaypointViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/14/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicWaypointViewController.h"
#import "ScenicContentViewController.h"


@implementation ScenicWaypointViewController
@synthesize mainVC, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.view = mainVC.view;
    [super viewDidLoad];
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Location to Route" style:UIBarButtonSystemItemAction target:self action:@selector(addWaypoint)];
    [toolbar setItems:[NSArray arrayWithObject:buttonItem]];
    [buttonItem release];
    [self.view addSubview:toolbar];
    [toolbar release];
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

-(void) addWaypoint {
    [delegate addWaypointWithContent:self.mainVC.content];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
