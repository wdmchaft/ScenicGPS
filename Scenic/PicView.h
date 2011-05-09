//
//  PicView.h
//  Scenic
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SwipeView.h"

@interface PicView : UIView <SwipeViewDelegate> {
    
    NSMutableArray * scenicContents;
    
    BOOL transitioning; 
    UIView * containerView; 
    
    UIView * swipeView;
    
    int index;
    int count;
}

-(void)performTransition: (NSString*) subtype type: (NSString*) type;
- (id)initWithFrame:(CGRect)frame withScenicContents: (NSMutableArray*) contents;

@property (nonatomic, retain) NSMutableArray * scenicContents;
@property (nonatomic, retain) UIView * containerView;
@property (nonatomic, retain) UIView * swipeView;

@end
