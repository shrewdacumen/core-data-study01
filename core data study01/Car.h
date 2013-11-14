//
//  Car.h
//  core data study01
//
//  Created by sungwook on 09/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Car : NSManagedObject

@property (nonatomic, retain) NSString * maker;
@property (nonatomic, retain) NSString * model_name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSNumber * mpg;

@end
