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
#import "CDRoute.h"
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
    [routes release];
    
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
    routes = [helper allCDRoutes];    
	[routes retain]; 
 
}


- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"we need to reload the table view!");    
//    [tableView reloadData];
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
     
    CDRoute * cdRoute = (CDRoute*)[routes objectAtIndex:indexPath.row];
    ScenicRoute * route = cdRoute.route;
    NSLog(@" %@", [route description]);
    
    cell.primaryLabel.text = cdRoute.title;
    cell.secondaryLabel.text = cdRoute.desc;
    cell.myImageView.image = [UIImage imageNamed:@"dest.png"];
	
	return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // push a map on!
    CDRoute * cdRoute = (CDRoute*)[routes objectAtIndex:indexPath.row];
    ScenicRoute * route = cdRoute.route;
    ScenicTripViewController* tripVC = [[ScenicTripViewController alloc] initWithNibName:@"ScenicTripViewController" bundle:nil route:route];

    [[self navigationController] pushViewController:tripVC animated:YES];
    [tripVC release];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Select a Route";
}


//- (BOOL)tableView:(UITableView *)tableView
//canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{return YES;}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//		
//        // Delete the managed object at the given index path.
//		
//		// Update the array and table view.
//        // [routes removeObjectAtIndex:indexPath.row];
//        // reload the table view
//        
//		// Commit the change.
//    }   
//}


- (void) pushEditView:(id)sender {

    CDRoute * cdRoute = (CDRoute*)[routes objectAtIndex:((UIButton*)sender).tag];

    ScenicRouteEditViewController * tmp = [[ScenicRouteEditViewController alloc] initWithRoute:@"ScenicRouteEditViewController" bundle:nil route:cdRoute];
    [[self navigationController] pushViewController:tmp animated:YES];
    
}
@end
