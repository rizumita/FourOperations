// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Expression.m instead.

#import "_Expression.h"

const struct ExpressionAttributes ExpressionAttributes = {
	.leftSideValue = @"leftSideValue",
	.operator = @"operator",
	.result = @"result",
	.rightSideValue = @"rightSideValue",
};

const struct ExpressionRelationships ExpressionRelationships = {
};

const struct ExpressionFetchedProperties ExpressionFetchedProperties = {
};

@implementation ExpressionID
@end

@implementation _Expression

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Expression" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Expression";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Expression" inManagedObjectContext:moc_];
}

- (ExpressionID*)objectID {
	return (ExpressionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic leftSideValue;






@dynamic operator;






@dynamic result;






@dynamic rightSideValue;











@end
