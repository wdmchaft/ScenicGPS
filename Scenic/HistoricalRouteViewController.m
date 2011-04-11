//
//  HistoricalRouteViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "HistoricalRouteViewController.h"
#import "TableCell.h"
#import "CDHelper.h"
#import "ScenicRoute.h"
#import "ScenicTripViewController.h"
#import "ScenicAppDelegate.h"
#import "ScenicRouteEditViewController.h"

@implementation HistoricalRouteViewController
@synthesize tableOfRoutes, routes;

//- (void)setEditing:(BOOL)editing animated:(BOOL)animate {
//    
//    [super setEditing:editing animated:animate];
//    if(editing)
//    {
//        NSLog(@"editMode on");
//    }
//    else
//    {
//        NSLog(@"Done leave editmode");
//    }
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // add edit button
        //self.navigationItem.rightBarButtonItem = self.editButtonItem;

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
    
    CDHelper* helper = [CDHelper sharedHelper];
    routes = [helper allRoutes];
    
    //routes = [NSArray arrayWithObjects:@"route1", @"asfas", @"Big Two", @"Custom", nil];
	[routes retain];

    
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



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return 1;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	TableCell *cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[TableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
    [[cell mEditButton] addTarget:self action:@selector(pushEditView:) forControlEvents:UIControlEventTouchUpInside];
    [[cell mEditButton] setTag:indexPath.row];
     
    ScenicRoute * route = [routes objectAtIndex:indexPath.row];
    NSLog(@" %@", [route description]);
    
    cell.primaryLabel.text = route.gRoute.summary;
    cell.secondaryLabel.text = cell.primaryLabel.text;
    cell.myImageView.image = [UIImage imageNamed:@"dest.png"];
	
	return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected %d", indexPath.row);	
    // push a map on!
    ScenicRoute * route = [routes objectAtIndex:indexPath.row];
    ScenicTripViewController* tripVC = [[ScenicTripViewController alloc] initWithNibName:@"ScenicTripViewController" bundle:nil route:route];

    [[self navigationController] pushViewController:tripVC animated:YES];
    [tripVC release];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Select a Route";
}

- (void) pushEditView:(id)sender {

    ScenicRouteEditViewController * tmp = [[ScenicRouteEditViewController alloc] initWithNibName:@"ScenicRouteEditViewController" bundle:nil];
    [[self navigationController] pushViewController:tmp animated:YES];
    
    NSLog(@" %@ ", [sender description]);
    
}


@end
