//
//  SRINDataViewController.m
//  Utilities
//
//  Created by MSCI on 2/13/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import "SRINDataViewController.h"

@interface SRINDataViewController ()

@end

@implementation SRINDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
