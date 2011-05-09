//
//  PicView.m
//  Scenic
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PicView.h"
#import "ScenicContent.h"
#import "UserPhotoContent.h"

@implementation PicView
@synthesize scenicContents, containerView, swipeView;

- (id)initWithFrame:(CGRect)frame withScenicContents: (NSMutableArray*) contents
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scenicContents = [[NSMutableArray alloc] init];
        
        self.containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        self.swipeView = [[SwipeView alloc] initWithFrame:[[UIScreen mainScreen] bounds] delegate:self];
                
        for(int i=0; i<[contents count]; i++) {
            if ([[contents objectAtIndex:i] class] != [UserPhotoContent class]) continue;
            [scenicContents addObject:[contents objectAtIndex:i]];
        }

        for(int i=0; i<[scenicContents count]; i++) {

            ScenicContent * c = (ScenicContent*) [scenicContents objectAtIndex:i];            
            UIImageView * iv = [[[UIImageView alloc] initWithImage:[c fetchImage]] autorelease];
            [containerView addSubview: iv];
        }
        
        containerView.backgroundColor  = [UIColor blackColor];        
        [containerView addSubview:swipeView];
        [self addSubview:containerView];
        
        index = 0;
        
    }
    return self;
}

- (void)dealloc
{
    [containerView release];
    [scenicContents release];
    [swipeView release];
    [super dealloc];
}

#pragma mark - Transitions

-(void)performTransition: (NSString*) subtype type: (NSString*) type 
{
    
    if ([[containerView subviews] count] <= 1) return;
    
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = 0.65;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	// Now to set the type of transition. Since we need to choose at random, we'll setup a couple of arrays to help us.
    
    transition.type = type;
    transition.subtype = subtype;
    
	
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
	transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	[containerView.layer addAnimation:transition forKey:nil];
    
    for(int i=0; i<[[containerView subviews] count]; i++) {
        if ([[[containerView subviews] objectAtIndex:i] isKindOfClass:[UIImageView class]]) {            
            UIView* v = (UIView*) [[containerView subviews] objectAtIndex:i];
            v.hidden = YES;
        }
    }
    
    
    unsigned int u;
    
    if (subtype == kCATransitionFromLeft) {
        u = --index % [scenicContents count];
    } else {
        u = ++index % [scenicContents count];        
    }
    
    UIView * cv = [[containerView subviews] objectAtIndex:u];
    cv.hidden = NO;
    
}

#pragma mark - Swipe Delegate

- (void) swipeLeft {
    
	if(!transitioning)
	{
		[self performTransition: kCATransitionFromRight type:kCATransitionReveal];
	}
    
}

- (void) swipeRight {
    
	if(!transitioning)
	{
		[self performTransition: kCATransitionFromLeft type:kCATransitionReveal];
	}
    
}

- (void) doubleTap {}

#pragma mark - Transition Delegate

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	transitioning = NO;
}


@end
