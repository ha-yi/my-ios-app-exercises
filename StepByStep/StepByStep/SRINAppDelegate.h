//
//  SRINAppDelegate.h
//  StepByStep
//
//  Created by MSCI on 2/18/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRINAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSArray *) getAllGuidesRecord;
-(void) createNewGuide: (id) sender;
- (void) migrate;


@end
