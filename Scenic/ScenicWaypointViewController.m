//
//  ScenicWaypointViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/14/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicWaypointViewController.h"
#import "ScenicContentViewController.h"
#import "PanoramioRater.h"
#import "ScenicContent.h"

@implementation ScenicWaypointViewController
@synthesize mainVC, delegate, toolTitle;

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
    
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithTitle:[self getBackTitle] style:UIBarButtonSystemItemAction target:self action:@selector(addWaypoint)];
    
    UIImage *buttonImage = [UIImage imageNamed:@"thumbsup.png"];
    UIBarButtonItem * buttonUp = [[UIBarButtonItem alloc] initWithImage:buttonImage style:UIBarButtonSystemItemAction target:self action:@selector(voteUp)];    

    UIImage *buttonImage2 = [UIImage imageNamed:@"thumbsdown.png"];
    UIBarButtonItem * buttonDown = [[UIBarButtonItem alloc] initWithImage:buttonImage2 style:UIBarButtonSystemItemAction target:self action:@selector(voteDown)];    

 
    [toolbar setItems:[NSArray arrayWithObjects:buttonItem, buttonDown, buttonUp, nil]];
    [buttonUp release];
    [buttonDown release];
    [buttonItem release];
    
    [self.view addSubview:toolbar];
    [toolbar release];
}

- (void) voteUp {
    int rating = 1;
    [self voteWithRating:rating];
    
}

- (void) voteDown {
    int rating = -1;
    [self voteWithRating:rating];
}


-(void) voteWithRating: (int) rating {
    PanoramioRater* putter = [PanoramioRater putterWithContent:mainVC.content rating:rating andDelegate:self];
    [putter fetch];
}



-(NSString*) getBackTitle {
    if (!self.toolTitle)
        self.toolTitle = @"Add to Route";
    return self.toolTitle;
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

- (void) putterHasError:(ServerPutter *)putter {}

@end
