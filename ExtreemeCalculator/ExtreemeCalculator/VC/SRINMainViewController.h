//
//  SRINMainViewController.h
//  ExtreemeCalculator
//
//  Created by MSCI on 2/17/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRINMainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *buttonSuhu;
@property (strong, nonatomic) IBOutlet UIButton *buttonJarak;
@property (strong, nonatomic) IBOutlet UIButton *buttonLuasVolume;

-(IBAction)unwindKeluar:(UIStoryboardSegue *) segue;

@end
