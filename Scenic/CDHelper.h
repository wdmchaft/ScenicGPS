//
//  CDHelper.h
//  Scenic
//
//  Created by Jack Reilly on 3/30/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScenicRoute;
@interface CDHelper : NSObject {
    
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(NSArray*) allRoutes;
-(void) saveRoute: (ScenicRoute*) route;
+(id) sharedHelper;
-(void) storePhoto: (UIImage*) photo;
@end
