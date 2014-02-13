//
//  birdsAppDelegate.m
//  Bird Surveys
//
//  Created by Peter Gosling on 1/6/14.
//  Copyright (c) 2014 Peter Gosling. All rights reserved.
//

#import "birdsAppDelegate.h"
#import "birdsViewController.h"

@implementation birdsAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    birdsViewController *controller = (birdsViewController *)self.window.rootViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    [self.window makeKeyAndVisible];
    return YES;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *coordinatesData = [NSEntityDescription insertNewObjectForEntityForName:@"Coordinates" inManagedObjectContext:context];
    
    [coordinatesData setValue:@"-192.234" forKey:@"latitude"];
    [coordinatesData setValue:@"43.222343" forKey:@"longitude"];

    
    NSError *error;
    
    if (![context save:&error]) {
        NSLog(@"Whoops!, couldn't save: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Coordinates" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray  *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"Latitude: %@", [fetchedObjects objectAtIndex:0]);
    NSLog(@"Longtitude: %@", [fetchedObjects objectAtIndex:1]);
    
    
    // Override point for customization after application launch.
    return YES;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Bird Surveys.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //Don't use abort() in a production environment. It is better to use an UIAlertView
        //and ask users to quick app using the home button.
        abort();
    }
    
    return __persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
