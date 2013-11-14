//
//  AppDelegate.h
//  core data study01
//
//  Created by sungwook on 05/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
