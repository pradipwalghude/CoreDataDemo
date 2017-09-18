//
//  Employee+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *ename;
@property (nullable, nonatomic, copy) NSString *eemail;
@property (nullable, nonatomic, copy) NSString *emobile;
@property (nullable, nonatomic, copy) NSString *eID;
@property (nullable, nonatomic, retain) NSData *imageData;


@end

NS_ASSUME_NONNULL_END
