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
#import "ScenicRoute.h"

@implementation ScenicRouteEditViewController
@synthesize route, rTitle, desc, delButton;


- (id)initWithRoute:(CDRoute*)r
{
    self = [super initWithNibName:@"ScenicRouteEditViewController" bundle:nil];
    if (self) {
        route = r;
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
    
    self.rTitle.text = route.title; //route.title;
    self.desc.text = route.desc;

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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes, delete it!", nil];
    [alert show];  
    [alert release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) return;
    
   CDHelper * helper = [CDHelper sharedHelper];
   [helper deleteRoute:route];
      
   // need to tell table view to reload!
   // pop this view off as well
   
   [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction) updateFields {
    
    
    CDHelper * helper = [CDHelper sharedHelper];
    route.title = rTitle.text;
    route.desc = desc.text;
    [helper saveContext];
    
    [[self navigationController] popViewControllerAnimated:YES];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
