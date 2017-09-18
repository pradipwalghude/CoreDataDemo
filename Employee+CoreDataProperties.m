//
//  Employee+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
}

@dynamic ename;
@dynamic eemail;
@dynamic emobile;
@dynamic eID;
@dynamic imageData;

@end
