//
//  SRINModelController.h
//  Utilities
//
//  Created by MSCI on 2/13/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRINDataViewController;

@interface SRINModelController : NSObject <UIPageViewControllerDataSource>

- (SRINDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(SRINDataViewController *)viewController;

@end
