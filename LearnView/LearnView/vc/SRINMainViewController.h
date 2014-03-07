//
//  SRINMainViewController.h
//  LearnView
//
//  Created by MSCI on 2/18/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRINMainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *butonOk;
- (IBAction)doLongPresssss:(UILongPressGestureRecognizer *)sender;
- (IBAction)doClickonButton:(UIButton *)sender;

@end
