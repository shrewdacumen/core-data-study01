//
//  CarListTableViewController.h
//  core data study01
//
//  Created by sungwook on 09/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarListTableViewControllerDelegate.h"

@interface CarListTableViewController : UITableViewController <UITableViewDataSource>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSMutableArray * cars;

@property (nonatomic,weak) id<CarListTableViewControllerDelegate> delegate;

@property (nonatomic, strong) dispatch_queue_t readingCoreData;
@property (nonatomic, strong) dispatch_queue_t reading_aCell; // thread 1
@property (nonatomic, strong) dispatch_queue_t reading_aImage_in_aCell; //thread 2

- (IBAction)editButton_pressed:(id)sender;

@end
