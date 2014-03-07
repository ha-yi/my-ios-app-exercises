//
//  SRINGuideViewController.h
//  StepByStep
//
//  Created by MSCI on 2/18/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRINGuideViewController : UIViewController <UIDynamicAnimatorDelegate, UIImagePickerControllerDelegate>
- (IBAction)addNewSteps:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddNewStep;
@property (strong, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (strong, nonatomic) IBOutlet UIView *bottomViewLayout;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddPhoto;
@property (strong, nonatomic) IBOutlet UIButton *buttonDoneStep;
@property (strong, nonatomic) IBOutlet UITextView *textViewStepDescriptions;
@property BOOL modeEdit;
@property (strong, nonatomic) NSMutableDictionary *stepsDictionary;
@property (strong, nonatomic) NSString *lastTitle;



- (void) cancelEdit: (UIBarButtonItem *) sender;
- (void) doneEditing: (UIBarButtonItem *) sender;
- (id) initWithModeEdit;
- (IBAction)editingTitleBegin:(UITextField *)sender;
- (IBAction)doneAddingStep:(id)sender;
- (IBAction)editingTitleEnd:(UITextField *)sender;
- (IBAction)buttonSelectImagePressed:(id)sender;


// global var
extern NSString *barBUttonTextDone;
extern NSString *barBUttonTextCancel;
extern NSString *barBUttonTextBack;
extern NSString *barBUttonTextEdit;
@end
