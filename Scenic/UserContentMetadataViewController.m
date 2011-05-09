//
//  UserContentMetadataViewController.m
//  Scenic
//
//  Created by Dan Lynch on 4/27/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "UserContentMetadataViewController.h"
#import "ScenicContent.h"
#import "ContentUpdater.h"
#import "UserPhotoContent.h"
#import "ScenicContentViewController.h"


@implementation UserContentMetadataViewController
@synthesize name, desc, content;

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
    [content release];
    [name release];
    [desc release];
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
    
    name.text = content.title;
    desc.text = @"Enter description...";
    
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

#pragma mark - IBActions

- (IBAction) deleteUserContent {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes, delete it!", nil];
    [alert show];  
    [alert release];
    
}

- (IBAction) editUserContent {
    
    content.title = name.text;
    
    ContentUpdater* updater = [ContentUpdater updaterWithContent:(UserPhotoContent*)content andDelegate:self];
    [updater fetch];
    
    [[self navigationController] popViewControllerAnimated:YES];
}




#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) return;
    
//    CDHelper * helper = [CDHelper sharedHelper];
//    [helper deleteRoute:route];
    
    // need to tell table view to reload!
    // pop this view off as well
    
    [[self navigationController] popViewControllerAnimated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



@end
