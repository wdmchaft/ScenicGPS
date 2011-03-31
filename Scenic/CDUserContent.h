//
//  CDUserContent.h
//  Scenic
//
//  Created by Jack Reilly on 3/30/11.
//  Copyright (c) 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDUserContent : NSManagedObject {
@private
}
@property (nonatomic, retain) id photo;
@property (nonatomic, retain) NSDate * createdDate;

@end
