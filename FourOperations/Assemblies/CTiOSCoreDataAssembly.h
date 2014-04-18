//
// Created by rizumita on 2013/12/23.
//


#import <Foundation/Foundation.h>


@interface NSPersistentStoreCoordinator (InjectedInitialization)

- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel *)model type:(NSString *)type URL:(NSURL *)storeURL
                                   options:(NSDictionary *)options;

@end


@interface CTiOSCoreDataAssembly : TyphoonAssembly

- (id)mainManagedObjectContext;

- (id)managedObjectContext;

- (id)persistentStoreCoordinator;

- (id)storeURL;

- (id)managedObjectModel;

@end