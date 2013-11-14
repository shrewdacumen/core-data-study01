//
//  CarListTableViewControllerDelegate.h
//  core data study01
//
//  Created by sungwook on 12/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@protocol CarListTableViewControllerDelegate <NSObject>

@required
@property (nonatomic,strong) Car * selectedCar;

@optional

@end
