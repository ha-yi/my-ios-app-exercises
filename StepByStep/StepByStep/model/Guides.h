//
//  Guides.h
//  StepByStep
//
//  Created by MSCI on 2/20/14.
//  Copyright (c) 2014 CHIBI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Steps;

@interface Guides : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSNumber * isUploaded;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *steps;
@end

@interface Guides (CoreDataGeneratedAccessors)

- (void)insertObject:(Steps *)value inStepsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromStepsAtIndex:(NSUInteger)idx;
- (void)insertSteps:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeStepsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInStepsAtIndex:(NSUInteger)idx withObject:(Steps *)value;
- (void)replaceStepsAtIndexes:(NSIndexSet *)indexes withSteps:(NSArray *)values;
- (void)addStepsObject:(Steps *)value;
- (void)removeStepsObject:(Steps *)value;
- (void)addSteps:(NSOrderedSet *)values;
- (void)removeSteps:(NSOrderedSet *)values;
@end
