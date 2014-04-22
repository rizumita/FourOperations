//
// Created by rizumita on 2013/12/23.
//


#import "CTiOSCoreDataAssembly.h"


@interface NSManagedObjectContext (InjectedInitialization)

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
             persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
                          parentContext:(NSManagedObjectContext *)parentContext;

@end


@implementation NSManagedObjectContext (InjectedInitialization)

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
             persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    self = [self initWithConcurrencyType:type];
    if (self) {
        [self setPersistentStoreCoordinator:persistentStoreCoordinator];
    }
    return self;
}

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
                          parentContext:(NSManagedObjectContext *)parentContext
{
    self = [self initWithConcurrencyType:type];
    if (self) {
        self.parentContext = parentContext;
    }
    return self;
}

@end


@implementation NSPersistentStoreCoordinator (InjectedInitialization)

- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel *)model type:(NSString *)type URL:(NSURL *)storeURL
                                   options:(NSDictionary *)options
{
    self = [self initWithManagedObjectModel:model];
    if (self) {
        [self addPersistentStoreWithType:type configuration:nil URL:storeURL options:options error:nil];
    }
    return self;
}

@end


@implementation CTiOSCoreDataAssembly
{

}

- (id)mainManagedObjectContext
{
    return [TyphoonDefinition withClass:[NSManagedObjectContext class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(initWithConcurrencyType:persistentStoreCoordinator:);
        [initializer injectWithObjectInstance:@(NSMainQueueConcurrencyType)];
        [initializer injectWithDefinition:self.persistentStoreCoordinator];
    }                        properties:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
        definition.lazy = YES;
    }];
}

- (id)managedObjectContext
{
    return [TyphoonDefinition withClass:[NSManagedObjectContext class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(initWithConcurrencyType:parentContext:);
        [initializer injectParameterAtIndex:0 withObject:@(NSPrivateQueueConcurrencyType)];
//        [initializer injectWithObjectInstance:@(NSPrivateQueueConcurrencyType)];
        [initializer injectWithDefinition:self.mainManagedObjectContext];
    }                        properties:^(TyphoonDefinition *definition) {
    }];
}

#pragma mark - Persistent store coordinator

- (id)persistentStoreCoordinator
{
    return [TyphoonDefinition withClass:[NSPersistentStoreCoordinator class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(initWithManagedObjectModel:type:URL:options:);
        [initializer injectWithDefinition:self.managedObjectModel];
        [initializer injectWithDefinition:self.storeType];
        [initializer injectWithDefinition:self.storeURL];
        [initializer injectWithObjectInstance:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                    [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                                                    [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil]];
    }];
}

- (id)storeType
{
    return [TyphoonDefinition withClass:[NSString class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(initWithString:);
        [initializer injectWithObjectInstance:NSSQLiteStoreType];
    }];
}

- (id)fileManager
{
    return [TyphoonDefinition withClass:[NSFileManager class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(defaultManager);
    }];
}

- (id)applicationDocumentsDirectories
{
    return [TyphoonDefinition withClass:[NSArray class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(URLsForDirectory:inDomains:);
        [initializer injectWithObjectInstance:@(NSDocumentDirectory)];
        [initializer injectWithObjectInstance:@(NSUserDomainMask)];
    }                        properties:^(TyphoonDefinition *definition) {
        definition.factory = [self fileManager];
    }];
}

- (id)applicationDocumentsDirectory
{
    return [TyphoonDefinition withClass:[NSURL class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(lastObject);
    }                        properties:^(TyphoonDefinition *definition) {
        definition.factory = [self applicationDocumentsDirectories];
    }];
}

- (id)storeURL
{
    return [TyphoonDefinition withClass:[NSURL class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(URLByAppendingPathComponent:);
        [initializer injectParameterAtIndex:0 withValueAsText:@"${coredata.sqlite}" requiredTypeOrNil:[NSString class]];
    }                        properties:^(TyphoonDefinition *definition) {
        definition.factory = [self applicationDocumentsDirectory];
    }];
}

#pragma mark - Managed object model

- (id)managedObjectModel
{
    return [TyphoonDefinition withClass:[NSManagedObjectModel class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(initWithContentsOfURL:);
        [initializer injectWithDefinition:self.modelURL];
    }];
}

- (id)mainBundle
{
    return [TyphoonDefinition withClass:[NSBundle class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(mainBundle);
    }];
}

- (id)modelURL
{
    return [TyphoonDefinition withClass:[NSURL class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(URLForResource:withExtension:);
        [initializer injectWithValueAsText:@"${coredata.filename}" requiredTypeOrNil:[NSString class]];
        [initializer injectWithValueAsText:@"momd" requiredTypeOrNil:[NSString class]];
    }                        properties:^(TyphoonDefinition *definition) {
        definition.factory = [self mainBundle];
    }];
}

@end