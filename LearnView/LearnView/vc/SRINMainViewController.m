//
//  SRINMainViewController.m
//  LearnView
//
//  Created by MSCI on 2/18/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import "SRINMainViewController.h"

@interface SRINMainViewController ()

@end

@implementation SRINMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) doPan: (UIPanGestureRecognizer *) gesture {
    CGPoint location = [gesture locationInView:self.view];
    CGPoint translation = [gesture translationInView:self.view];
    NSLog(@"x=%f y=%f", location.x, location.y);
    CGRect frame = _butonOk.frame;
    frame.origin.x += translation.x;
    frame.origin.y += translation.y;
    _butonOk.frame = frame;
    [gesture setTranslation:CGPointZero inView:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIImage *biImage = [[UIImage imageNamed:@"blueButton"] stretchableImageWithLeftCapWidth:72/4 topCapHeight:72/4];
    UIImage *biImage = [[UIImage imageNamed:@"blueButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(70/4, 70/4, 70/4, 70/4)];
    [_butonOk setBackgroundImage:biImage forState:UIControlStateNormal];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPan:)];
    [_butonOk addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLongPresssss:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [[[UIAlertView alloc]initWithTitle:@"Long Press" message:@"Wow,, its soooo long" delegate:nil cancelButtonTitle:@"Kill me baby" otherButtonTitles:@"Go to Hell", @"What the hell??", nil]show];
    }
    
}

- (IBAction)doClickonButton:(UIButton *)sender {
  
}
@end
