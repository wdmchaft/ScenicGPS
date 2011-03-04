//
//  RouteRootViewController.m
//  ScenicGPS
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "RouteRootViewController.h"
#import "GMapsGeolocator.h"
#import "GMapsGeolocation.h"


@implementation RouteRootViewController
@synthesize descriptionTF, latLabel, lngLabel, titleLabel;

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
    [super viewDidLoad];
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

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [descriptionTF resignFirstResponder];
    return NO;
}

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    [fetcher release];
    GMapsGeolocation* geolocation = (GMapsGeolocation*) response;
    latLabel.text = [geolocation.lat description];
    lngLabel.text = [geolocation.lng description];
    titleLabel.text = geolocation.title;
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    GMapsGeolocator* geolocator = [[GMapsGeolocator geolocatorWithAddress:textField.text withDelegate:self] retain];
    [geolocator fetch];
}

@end
