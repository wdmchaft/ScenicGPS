//
//  ScenicTripViewController.m
//  Scenic
//
//  Created by Jack Reilly on 3/28/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicTripViewController.h"
#import "ScenicTripModel.h"
#import "UserPhotoContent.h"
#import "CDHelper.h"


@implementation ScenicTripViewController
@synthesize mMapView, trip, imgPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model: (ScenicMapSelectorModel*) model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.trip = [ScenicTripModel modelFromModel:model];
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
    self.mMapView.navigationController = self.navigationController;
    self.mMapView.model = self.trip;
    self.mMapView.scenicDelegate = self;
    [self.mMapView updateRoutesOnMap];
    [self initImagePicker];
    
}

-(void) initImagePicker {
    UIImagePickerController* tmp = [[UIImagePickerController alloc] init];
    tmp.delegate = self;
    tmp.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        tmp.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        tmp.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imgPicker = tmp;
    
    [tmp release];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self handleImage: (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage]];
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    
}

-(void) handleImage: (UIImage*) image {
    UserPhotoContent* content = [UserPhotoContent contentWithPhoto:image andCoordinate:[GMapsCoordinate coordFromCLCoord:self.mMapView.model.locationManager.location.coordinate]];
    [self.mMapView addUserContent:content];
    [[CDHelper sharedHelper] storePhoto: image];
    
}


-(void) scenicMapViewUpdatedRoutes {
    return;
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

-(IBAction) takePicture: (id) sender {
    [self presentModalViewController:self.imgPicker animated:YES];
}

@end
