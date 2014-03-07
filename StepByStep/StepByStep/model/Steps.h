//
//  Steps.h
//  StepByStep
//
//  Created by MSCI on 2/20/14.
//  Copyright (c) 2014 CHIBI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guides;

@interface Steps : NSManagedObject

@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * stepNumber;
@property (nonatomic, retain) Guides *owner;

@end
