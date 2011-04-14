//
//  TableCell.h
//  Scenic
//
//  Created by Dan Lynch on 3/10/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDRoute;

@interface TableCell : UITableViewCell {
	UILabel *primaryLabel;
	UILabel *secondaryLabel;
	UIImageView *myImageView;
    UIButton *mEditButton;
    CDRoute * route;
}

@property(nonatomic,retain)CDRoute *route;
@property(nonatomic,retain)UILabel *primaryLabel;
@property(nonatomic,retain)UILabel *secondaryLabel;
@property(nonatomic,retain)UIImageView *myImageView;
@property(nonatomic,retain)UIButton *mEditButton;
@end
