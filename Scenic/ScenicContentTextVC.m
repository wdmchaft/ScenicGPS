//
//  ScenicContentTextVC.m
//  Scenic
//
//  Created by Jack Reilly on 3/12/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicContentTextVC.h"


@implementation ScenicContentTextVC
@synthesize descriptionLabel, description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andDescription: (NSString*) _description
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.description = _description;
    }
    return self;
}

-(UIView*) provideView {
    return self.view;
}

- (void)dealloc
{
    [super dealloc];
    [description release];
    [descriptionLabel release];
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
    descriptionLabel.text = description;
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

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [super  encodeWithCoder:aCoder];
    [aCoder encodeObject:self.description];
    [aCoder encodeObject:self.descriptionLabel];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.description = [aDecoder decodeObject];
        self.descriptionLabel = [aDecoder decodeObject];
    }
    return self;
}

@end
