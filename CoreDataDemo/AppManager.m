//
//  AppManager.m
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//

#import "AppManager.h"
#import "Employee+CoreDataClass.h"

@implementation AppManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//Syncronized Singleton object of DBMananager
static AppManager* _sharedDBManager = nil;

+(AppManager *)sharedDBManager {
    
    @synchronized([AppManager class]) {
        
        if (!_sharedDBManager)
            _sharedDBManager = [[self alloc] init];
        
        return _sharedDBManager;
    }
    
    return nil;
}

-(id)isRecordExistWithEntityName:(NSString *) entityName withPredicate:(NSPredicate *) predicate {
    
    id _record = nil;
    NSManagedObjectContext *_context =[self managedObjectContext];
    NSFetchRequest *_fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *_entityDesc =[NSEntityDescription entityForName:entityName inManagedObjectContext:_context];
    [_fetchRequest setEntity:_entityDesc];
    
    [_fetchRequest setPredicate:predicate];
    _fetchRequest.fetchLimit = 1;
    
    NSError *_error;
    NSArray *_fetchedOjects = [_context executeFetchRequest:_fetchRequest error:&_error];
    
    if (_fetchedOjects.count > 0) {
        _record = [_fetchedOjects objectAtIndex:0];
    }
    
    return _record;
}

#pragma mark - Database Helpers

-(void)saveContext {
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    if (managedObjectContext != nil) {
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *directoryURL = [NSURL fileURLWithPath:[self applicationDocumentsDirectory]];
    NSURL *storeURL = [directoryURL URLByAppendingPathComponent:@"Project_Perfect.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application Documents Directory

// Returns the URL to the application's Documents directory.
- (NSString *)applicationDocumentsDirectory {
    
    NSArray *searchPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([searchPathArray count] > 0) {
        
        return [searchPathArray lastObject];
    }
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



#pragma mark - Save or Update Application Data Methods

-(void)saveDataInDB:(NSMutableDictionary *)appEventTypeDict {
    
    Employee *appEventTypeRecord = [self isRecordExistWithEntityName:@"Employee" withPredicate:[NSPredicate predicateWithFormat:@"self == %@", [appEventTypeDict objectForKey:@"id"]]];
    
    if (appEventTypeRecord != nil) {
        
        if ([appEventTypeDict valueForKey:@"ename"] != [NSNull null])
            [appEventTypeRecord setEname:[appEventTypeDict valueForKey:@"name"]];
        
        if ([appEventTypeDict valueForKey:@"eemail"] != [NSNull null])
            [appEventTypeRecord setEemail:[appEventTypeDict valueForKey:@"email"]];
        
        if ([appEventTypeDict valueForKey:@"emobile"] != [NSNull null])
            [appEventTypeRecord setEmobile:[appEventTypeDict valueForKey:@"mobile"]];

        
        if ([appEventTypeDict valueForKey:@"eid"] != [NSNull null])
            [appEventTypeRecord setEID:[appEventTypeDict valueForKey:@"id"]];
        
        if ([appEventTypeDict valueForKey:@"eid"] != [NSNull null])
            [appEventTypeRecord setImageData:[appEventTypeDict valueForKey:@"imageData"]];
        
        
    }
    else {
        
        Employee *newAppEventTypeRecord = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:[self managedObjectContext]];
        
        if ([appEventTypeDict valueForKey:@"ename"] != [NSNull null])
            [newAppEventTypeRecord setEname:[appEventTypeDict valueForKey:@"name"]];
        
        if ([appEventTypeDict valueForKey:@"eemail"] != [NSNull null])
            [newAppEventTypeRecord setEemail:[appEventTypeDict valueForKey:@"email"]];
        
        if ([appEventTypeDict valueForKey:@"emobile"] != [NSNull null])
            [newAppEventTypeRecord setEmobile:[appEventTypeDict valueForKey:@"mobile"]];
        
        if ([appEventTypeDict valueForKey:@"eid"] != [NSNull null])
            [newAppEventTypeRecord setEID:[appEventTypeDict valueForKey:@"id"]];
        
        if ([appEventTypeDict valueForKey:@"imageData"] != [NSNull null])
            [newAppEventTypeRecord setImageData:[appEventTypeDict valueForKey:@"imageData"]];
    }
    
    [self saveContext];

}

//  recipient  member
-(id)getEmployeeName:(NSNumber * )eID
{
    NSPredicate *recipientPredicate = [NSPredicate predicateWithFormat:@"self ==%@", eID];
    
    NSEntityDescription *entityDescForRecipient = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:[self managedObjectContext]];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescForRecipient];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setPredicate:recipientPredicate];
    NSArray *recipientObject_arr = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    fetchRequest = nil;
    return recipientObject_arr;
}


-(id)getEmployeeData
{
    
    NSEntityDescription *entityDescForRecipient = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:[self managedObjectContext]];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescForRecipient];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSArray *recipientObject_arr = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    fetchRequest = nil;
    return recipientObject_arr;
}


-(id)getEmployeeEmailID
{
    
    NSEntityDescription *entityDescForEmployee = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:[self managedObjectContext]];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entityDescForEmployee];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSArray *recipientObject_arr = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    fetchRequest = nil;
    return recipientObject_arr;
}


@end
