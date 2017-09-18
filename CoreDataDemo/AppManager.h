//
//  AppManager.h
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface AppManager : NSObject


//Context Objects
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+(AppManager *)sharedDBManager;

-(void)saveDataInDB:(NSMutableDictionary *)appEventTypeDict ;
-(id)getEmployeeName:(NSNumber * )eID;
-(id)getEmployeeEmailID;
-(id)getEmployeeData;

@end
