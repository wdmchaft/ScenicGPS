//
//  CDRoute.h
//  Scenic
//
//  Created by Jack Reilly on 3/30/11.
//  Copyright (c) 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDRoute : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) id route;

@end
