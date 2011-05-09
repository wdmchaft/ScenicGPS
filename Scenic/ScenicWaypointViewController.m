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
#import "PanoramioContent.h"
#import "UserPhotoContent.h"
#import "UserContentMetadataViewController.h"
#import "UserContentRater.h"

@implementation ScenicWaypointViewController
@synthesize mainVC, delegate, toolTitle, navigationController;

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
    [navigationController release];
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

    
    if ([mainVC.content class] == [UserPhotoContent class]) {        
        
        UIBarButtonItem* editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonSystemItemAction target:self action:@selector(editContent)];

        [toolbar setItems:[NSArray arrayWithObjects:buttonItem, buttonDown, buttonUp, editButtonItem, nil]];
        [editButtonItem release];
        
    } else [toolbar setItems:[NSArray arrayWithObjects:buttonItem, buttonDown, buttonUp, nil]];
    
    [buttonUp release];
    [buttonDown release];
    [buttonItem release];
    
    [self.view addSubview:toolbar];
    [toolbar release];
}

#pragma mark - 
#pragma mark Callbacks and Votes

- (void) editContent {
    
    UserContentMetadataViewController * vc = [[UserContentMetadataViewController alloc] initWithNibName:@"UserContentMetadataViewController" bundle:nil];
    vc.content = mainVC.content;

    [[self navigationController ] pushViewController:vc animated:YES];

}

- (void) voteUp {
    int rating = 1;
    [self voteWithRating:rating];
    
} 

- (void) voteDown {
    int rating = -1;
    [self voteWithRating:rating];
}
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mainVC.titleLabel.text = self.mainVC.content.title;
}


-(void) voteWithRating: (int) rating {
    

    if ([mainVC.content class] == [PanoramioContent class]) {
        
//        PanoramioRater* putter = [PanoramioRater putterWithContent:mainVC.content rating:rating andDelegate:self];
//        [putter fetch];
        
    } else {
        
//        NSLog(@"need to rate %@", [[mainVC.content class] description]);
                
        UserContentRater* putter = [UserContentRater putterWithContent:mainVC.content rating:rating andDelegate:self];
        [putter fetch];
                                   
    }
    
}



-(NSString*) getBackTitle {
    if (!self.toolTitle)
        self.toolTitle = @"Add to Route";
    return self.toolTitle;
}

#pragma mark -
#pragma View Stuff

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
