//
//  EnlargedTableViewController.h
//  core data study01
//
//  Created by sungwook on 12/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarListTableViewControllerDelegate.h"

@interface EnlargedTableViewController : UITableViewController <CarListTableViewControllerDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableViewCell *maker;
@property (weak, nonatomic) IBOutlet UITableViewCell *model_name;
@property (weak, nonatomic) IBOutlet UITableViewCell *mpg;

@end
