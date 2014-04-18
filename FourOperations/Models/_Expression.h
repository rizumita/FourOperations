// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Expression.h instead.

#import <CoreData/CoreData.h>


extern const struct ExpressionAttributes {
	__unsafe_unretained NSString *leftSideValue;
	__unsafe_unretained NSString *operator;
	__unsafe_unretained NSString *result;
	__unsafe_unretained NSString *rightSideValue;
} ExpressionAttributes;

extern const struct ExpressionRelationships {
} ExpressionRelationships;

extern const struct ExpressionFetchedProperties {
} ExpressionFetchedProperties;







@interface ExpressionID : NSManagedObjectID {}
@end

@interface _Expression : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ExpressionID*)objectID;





@property (nonatomic, strong) NSString* leftSideValue;



//- (BOOL)validateLeftSideValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* operator;



//- (BOOL)validateOperator:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* result;



//- (BOOL)validateResult:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* rightSideValue;



//- (BOOL)validateRightSideValue:(id*)value_ error:(NSError**)error_;






@end

@interface _Expression (CoreDataGeneratedAccessors)

@end

@interface _Expression (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveLeftSideValue;
- (void)setPrimitiveLeftSideValue:(NSString*)value;




- (NSString*)primitiveOperator;
- (void)setPrimitiveOperator:(NSString*)value;




- (NSString*)primitiveResult;
- (void)setPrimitiveResult:(NSString*)value;




- (NSString*)primitiveRightSideValue;
- (void)setPrimitiveRightSideValue:(NSString*)value;




@end
