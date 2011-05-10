//
//  ScenicMapView.m
//  Scenic
//
//  Created by Jack Reilly on 3/22/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicMapView.h"
#import "GeoHash.h"
#import "ScenicContentDisplayViewController.h"
#import "ScenicContent.h"
#import "ScenicContentTextVC.h"
#import "ScenicContentViewController.h"
#import "PanoramioContent.h"
#import "ScenicWaypointViewController.h"
#import "ScenicRoute.h"
#import "ScenicPolyline.h"
#import "ScenicTextContent.h"
#import "ScenicMapSelectorModel.h"


@implementation ScenicMapView
@synthesize model, navigationController, scenicDelegate, primaryPL, updateHeading;


-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.delegate = self;
        updateHeading = FALSE;
    }
    return self;
}


-(id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.delegate = self;
        updateHeading = FALSE;
    }
    return self;
}

- (void) compassFrame:(BOOL)b {
    if (b) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.frame = CGRectMake(-200, -200, self.frame.size.height*1.414, self.frame.size.height*1.414);
        }else{
            self.frame = CGRectMake(-100, -100, self.frame.size.height*1.414, self.frame.size.height*1.414);
        }
        
    } else
        self.frame = [[UIScreen mainScreen] bounds];
}


-(void) changeToRouteNumber: (int) n {
    self.model.primaryRouteIndex = n;
    [self drawRoutes];
}

-(MKOverlayView*) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKOverlayView* olView =  [((MKPolyline*) overlay) plViewWithPrimary:(overlay == self.primaryPL)];
        return olView;
    }
    return nil;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"yo");
    [super touchesEnded:touches withEvent:event];
}

-(void) overlayTouched: (MKOverlayView*) olView {
    //NSLog(@"touched");
}

-(void) putNewRoutes: (NSArray*) routes {
    self.model.routes = routes;
    [self updateRoutesOnMap];
}

-(void) updateRoutesOnMap {
    [self.scenicDelegate scenicMapViewUpdatedRoutes];
    [self drawRoutes];
}


- (MKAnnotationView *) mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    
    if ([annotation isKindOfClass:[ScenicContent class]]) {
        ScenicContent* sc = (ScenicContent*) annotation;
        MKPinAnnotationView* pinView =
        (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:[sc tag]];
        if (!pinView)
        {
            return [self annotationViewForContent:sc];
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

-(MKAnnotationView*) annotationViewForContent:(ScenicContent*) content {
    MKAnnotationView* annotationView = [[[MKAnnotationView alloc] initWithAnnotation:content reuseIdentifier:[content tag]] autorelease];
    annotationView.canShowCallout = YES;
    
    UIImage *flagImage = [content fetchIcon];
    annotationView.image = flagImage;
    annotationView.opaque = NO;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    annotationView.rightCalloutAccessoryView = rightButton;
    if (!self.model.frozen) {
        UIImage* image;
        if (![[self.model primaryRoute].scenicContents containsObject:content])
            image = [UIImage imageNamed:@"add-28.png"];
        else
            image = [UIImage imageNamed:@"remove.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0.0,0.0, 28.0, 28.0)];
        [button setImage:image forState:UIControlStateNormal];
        annotationView.leftCalloutAccessoryView = button;
    }
    return annotationView;
}


#pragma mark - ScenicMapSelectorModelDelegate

-(void) mapSelectorModelFinishedGettingRoutes:(ScenicMapSelectorModel *)model {
    [self putNewRoutes:self.model.routes];
}

-(void)mapSelectorModelFinishedFetchingContent: (ScenicMapSelectorModel*) model {
    [self updateVisibleContents];
}

-(void) mapSelectorModelHeadingUpdate:(CLHeading *)heading {
  //  NSLog(@"%d is heading", updateHeading);
    
    if (!updateHeading) return;
 
    self.transform = CGAffineTransformMakeRotation(-heading.trueHeading* M_PI / 180.0);
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self updateVisibleContents];
}

#pragma mark - visible contents

-(void) updateVisibleContents {
    NSArray* routeContents = [self.model primaryRoute].scenicContents;
    NSArray* visibleMapContents = [self visibleContentsForCurrentRegion];
    NSArray* visibleContents = [routeContents arrayByAddingObjectsFromArray:visibleMapContents];
    
    
    // remove nonvisible
    
    NSArray* mapAnnotations = [NSArray arrayWithArray:self.annotations];
    
    for (id<MKAnnotation> annotation in mapAnnotations) {
        if ([annotation isKindOfClass:[ScenicContent class]]) {
            if (![visibleContents containsObject:annotation ]) {
                [self removeAnnotation:annotation];
            }
        }
    }
    
    // add unadded
    for (ScenicContent* content in visibleContents) {
        if (![self.annotations containsObject:content]) {
            [self addAnnotation:content];
        }
    }
    
}

-(NSArray*) visibleContentsForCurrentRegion {
    MKCoordinateRegion region = self.region;
    int level = 4;
    
    double delta = (region.span.latitudeDelta + region.span.longitudeDelta)/2.0;
    /*
     float a, b, u, v;
     a = 12; // max 11? this is the total number of chars of a geoHash string
     b = 1; // could be 1 (or 0 theoretically) this is the lowest number of characters to match 
     u = 0.48;
     v = 1; // max [0.818, 188] 
     */
    double delta_max = 188;
    double delta_min = .00818;
    int c_max = 12;
    int c_min  = 3;
    double rho = 1000.;
    double cDel = (double) (c_max - c_min);
    double dDel = delta_max - delta_min;
    //NSLog(@"%f",delta);
    
    level = (int) (c_min + floor(cDel*(dDel - (delta - delta_min))/(rho*(delta - delta_min) + dDel)));
    
    
    //NSLog(@"level: %d", level);
    
    
    
    NSMutableDictionary * aDict = [[[NSMutableDictionary alloc] init] autorelease];
    // ADD ALL TO HASH (since only unique key will contain 1 object)
    for( ScenicContent* content in self.model.scenicContents ){
        NSString * checkStr =[content.geoHash substringToIndex:level-1];
        [aDict setObject:content forKey:checkStr];
    }
    return [aDict allValues];
}

-(void) setInitialRoutes: (NSArray*) routes {
    if (!self.model) {
        [self createModel];
    }
    [self putNewRoutes:routes];
    [self.model fetchNewContentWithBounds:[GMapsBounds boundsFromMapView:self]];
}

-(void) createModel {
    ScenicMapSelectorModel* tempModel = [[ScenicMapSelectorModel alloc] init];
    self.model = tempModel;
    [tempModel release];
}

-(void) setModel:(ScenicMapSelectorModel *)_model {
    [_model retain];
    [model release];
    model = _model;
    self.model.delegate = self;
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	//NSLog(@"Reverse Geocoder Errored");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	[self addAnnotation:placemark];
}

-(void) addUserContent: (ScenicContent*) content {
    [self.model addContent:content];
    [self updateVisibleContents];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
        
    ScenicTextContent * content = (ScenicTextContent*) view.annotation;
    //NSLog(@"we have %@", content.title);
    bool alreadyAdded = [[self.model primaryRoute].scenicContents containsObject:content];
    
    if( view.leftCalloutAccessoryView == control) {
        if (alreadyAdded)
            [self.model removeWaypointWithContent:content];
        else
            [self.model addWaypointWithContent:content];
        [self removeAnnotation:content];
        [self addAnnotation:content];
        return;
    }
    
    // right button!
    
    NSLog(@"%@", [self.model description]);
    ScenicWaypointViewController* waypointVC = [[ScenicWaypointViewController alloc] init];
    ScenicContentViewController* scVC = [[ScenicContentViewController alloc] initWithNibName:@"ScenicContentViewController" bundle:nil andContent:content];
    
    waypointVC.mainVC = scVC;
    [scVC release];
    waypointVC.delegate = self.model;
    waypointVC.navigationController = self.navigationController;
    if (alreadyAdded)
        waypointVC.toolTitle = @"Remove from Route";
    [self.navigationController pushViewController:waypointVC animated:YES];
    [waypointVC release];
}

-(void) drawRoutes {
    [self refreshRouteDrawings];
    ScenicRoute* primRoute = [self.model primaryRoute];
    BOOL isPrimary;
    GMapsRoute* gRoute;
    for (ScenicRoute* route in self.model.routes) {
        isPrimary = route == primRoute;
        gRoute = route.gRoute;
        CLLocationCoordinate2D startPos = [gRoute startPos];
        MKReverseGeocoder * geoCoderStart=[[MKReverseGeocoder alloc] initWithCoordinate:startPos];
        [geoCoderStart setDelegate:self];
        [geoCoderStart start];
        
        CLLocationCoordinate2D endPos = [gRoute endPos];
        MKReverseGeocoder * geoCoderEnd=[[MKReverseGeocoder alloc] initWithCoordinate:endPos];
        [geoCoderEnd setDelegate:self];
        [geoCoderEnd start];
        
        GMapsCoordinate* sw = gRoute.bounds.sw;
        GMapsCoordinate* ne = gRoute.bounds.ne;
        double swlat = [sw.lat doubleValue];
        double swlng = [sw.lng doubleValue];
        double nelat = [ne.lat doubleValue];
        double nelng = [ne.lng doubleValue];
        CLLocationCoordinate2D center = {.latitude = (swlat + nelat)*.5,
            .longitude = (swlng + nelng)*.5};
        MKCoordinateSpan span =  MKCoordinateSpanMake(nelat - swlat, nelng - swlng);
        MKCoordinateRegion region = {center, span};
        [self setRegion:region animated:YES];
        MKPolyline* sp = [gRoute polylineOverlay];
        if (isPrimary) {
            self.primaryPL = sp;
        }
        [self addOverlay:sp];
    }
}

-(void) refreshRouteDrawings {
    [self removeOverlays: [self overlays]];
}

@end
