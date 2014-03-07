//
//  SRINGuideViewController.m
//  StepByStep
//
//  Created by MSCI on 2/18/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import "SRINGuideViewController.h"
#import "SRINAppDelegate.h"
#import "Guides.h"
#import "Steps.h"



@interface SRINGuideViewController () {
    BOOL keyboardShown;
}

@property (strong, nonatomic) UIBarButtonItem *barButtonCancel;
@property (strong, nonatomic) UIBarButtonItem *barButtonDone;
@property BOOL isEdited;
@property int stepNumber;
@property int lastStepNumber;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *steps;
@property (strong, nonatomic) UIImagePickerController *mediaPicker;
@property (strong,nonatomic) UIImage *selectedImage;
@property (strong,nonatomic) NSMutableDictionary *stepDict;

//@property (strong, nonatomic) NSString *barBUttonTextDone;

@end

NSString *barBUttonTextDone = @"Done";
NSString *barBUttonTextCancel = @"Cancel";
NSString *barBUttonTextBack = @"Back";
NSString *barBUttonTextEdit = @"Edit";


@implementation SRINGuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _modeEdit = NO;
    }
    return self;
}

- (id)initWithModeEdit {
    self = [self init];
    _modeEdit = YES;
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Create new Guide"];
    // Do any additional setup after loading the view from its nib.
    [self initBottomViewLayoutStyles];
    
    _barButtonCancel = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:self action:@selector(cancelEdit:)];
    
    _barButtonDone = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:self action:@selector(doneEditing:)];
    
    [self toggleUIEnableWithModeEditingStatus];
    
    self.navigationItem.leftBarButtonItem = _barButtonCancel;
    self.navigationItem.rightBarButtonItem = _barButtonDone;
    // just for test
    _lastStepNumber = 0;
    if(_modeEdit) {
        _lastTitle = _textFieldTitle.text;
        
    }
    
    SRINAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //2
    self.managedObjectContext = appDelegate.managedObjectContext;
    [_bottomViewLayout setHidden:YES];
    
    // set buttons image
    UIImage *buttonImage = [[UIImage imageNamed:@"greyButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greyButtonHighlighted"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [_buttonAddPhoto setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [_buttonAddPhoto setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    UIImage *buttonImageGreen = [[UIImage imageNamed:@"greenButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageGreenHighlight = [[UIImage imageNamed:@"greenButtonHighlighted"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [_buttonDoneStep setBackgroundImage:buttonImageGreen forState:UIControlStateNormal];
    [_buttonDoneStep setBackgroundImage:buttonImageGreenHighlight forState:UIControlStateHighlighted];
}




#pragma mark - Bottom View Layout
- (void) setBottomViewLayoutVisible: (BOOL) visible withPositionX: (float) x andY: (float) y animationDuration: (NSTimeInterval) duration andCurve: (UIViewAnimationCurve) curve{
    
    CGRect frame = _bottomViewLayout.frame;
    
    CGRect initFrame;
    if (!keyboardShown) {
        initFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,frame.size.height);
    } else {
        initFrame = CGRectMake(0, self.view.frame.size.height, frame.size.width,frame.size.height);
    }
    
    frame.origin.y = y - 5;
    frame.origin.x = x;
    
    if (visible) {
        // create animations
        [_bottomViewLayout setHidden:NO];
        [self.view addSubview:_bottomViewLayout];
        [UIView animateWithDuration:duration
                        delay:0.0 options:(curve << 16)
                         animations:^{
                             _bottomViewLayout.frame = frame;
                         } completion:^(BOOL finished) {
                             
                         }];
        
        
    } else {
        frame.origin.y = self.view.frame.size.height;
        
        [UIView animateWithDuration:duration
                              delay:0.0 options:(curve << 16) animations:^{
            _bottomViewLayout.frame = frame;
        } completion:^(BOOL finished) {
            NSLog(@"animation finished");
            [_bottomViewLayout setHidden:YES];
            [_bottomViewLayout removeFromSuperview];
        }];
    }
}

- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    NSLog(@"animationFinished called");
    if ([animationID isEqualToString:@"hide_view"])
    {
        
        [_bottomViewLayout setHidden:YES];
        [_bottomViewLayout removeFromSuperview];
    }
}

- (void) setBottomViewLayoutVisible: (BOOL) visible withKeyboardHeight: (float) height animationDuration: (NSTimeInterval) duration andCurve: (UIViewAnimationCurve) curve {
    CGRect frame = _bottomViewLayout.frame;
    float y = self.view.frame.size.height - frame.size.height - height;
    float x = (self.view.frame.size.width - frame.size.width) / 2;
    
    [self setBottomViewLayoutVisible:visible withPositionX:x andY:y animationDuration:duration andCurve:curve];
}

- (void) initBottomViewLayoutStyles {
    // set corener radius
    [_bottomViewLayout.layer setCornerRadius:5.0f];
    
    // add border
    [_bottomViewLayout.layer setBorderColor: argb(1, 0.7, 0.7, 0.7).CGColor];
    [_bottomViewLayout.layer setBorderWidth:1.0f];
    
    [_bottomViewLayout.layer setShadowColor:[UIColor blackColor].CGColor];
    [_bottomViewLayout.layer setShadowOpacity:0.8];
    [_bottomViewLayout.layer setShadowRadius:3.0];
    [_bottomViewLayout.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    // set position
    CGRect frame = _bottomViewLayout.frame;
    frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2;
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    _bottomViewLayout.frame = frame;
    
    // configuring TextVield
    [_textViewStepDescriptions.layer setCornerRadius:5.0f];
    [_textViewStepDescriptions.layer setBorderColor:argb(1, 0.8, 0.8, 0.8).CGColor];
    [_textViewStepDescriptions.layer setBorderWidth:1.0f];
    
    
    
}

#pragma mark - Main View: Handling Keyboard event

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    NSLog(@"will appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self.view.window];
}

- (void)keyboardDidShow:(NSNotification *) notification {
    keyboardShown = YES;
    if (![_bottomViewLayout isHidden]) {
        NSDictionary *dict = [notification userInfo];
        CGSize keyboardSize = [[ dict objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        NSTimeInterval duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve animationCurve = [[dict objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];

        
        [self setBottomViewLayoutVisible:YES withKeyboardHeight:keyboardSize.height animationDuration:duration andCurve:animationCurve];
    }
}

- (void)keyboardDidHide:(NSNotification *) notification {
    keyboardShown = NO;
    if (![_bottomViewLayout isHidden]) {
        NSDictionary *dict = [notification userInfo];
        NSTimeInterval duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve animationCurve = [[dict objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        [self setBottomViewLayoutVisible:YES withKeyboardHeight:0 animationDuration:duration andCurve:animationCurve];
    }
}

#pragma mark - Main View: UI events

- (IBAction)editingTitleBegin:(UITextField *)sender {
    _lastTitle = sender.text;
}

- (IBAction)doneAddingStep:(id)sender {
    
}

- (IBAction)editingTitleEnd:(UITextField *)sender {
    if (![_lastTitle isEqualToString:sender.text] || _stepNumber != _lastStepNumber) {
        _isEdited = YES;
    } else {
        _isEdited = YES;
    }
    [self.view endEditing:YES];
}

- (IBAction)buttonSelectImagePressed:(id)sender {
    _mediaPicker = [[UIImagePickerController alloc] init];
    _mediaPicker.delegate = self;
    _mediaPicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take photo", @"Choose Existing", nil];
        [actionSheet showInView:self.view];
    } else {
        _mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_mediaPicker animated:YES completion:nil];
    }
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    _selectedImage =(UIImage*)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSLog(@"image: %@", _selectedImage);
    [_buttonAddPhoto setImage:_selectedImage forState:UIControlStateNormal];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        _mediaPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 1) {
        _mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:_mediaPicker animated:YES completion:nil];
//    [self presentModalViewController:_mediaPicker animated:YES];
}



- (void) toggleUIEnableWithModeEditingStatus {
    NSString *rightBarButtonText;
    NSString *leftBarButtonText;
    
    [_textFieldTitle setEnabled:_modeEdit];
    [_buttonAddNewStep setEnabled:_modeEdit];
    if (!_modeEdit) {
        rightBarButtonText = barBUttonTextEdit;
        leftBarButtonText = barBUttonTextBack;
    } else {
        rightBarButtonText = barBUttonTextDone;
        leftBarButtonText = barBUttonTextCancel;
    }
    
    [_barButtonCancel setTitle:leftBarButtonText];
    [_barButtonDone setTitle:rightBarButtonText];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)addNewSteps:(UIButton *)sender {
    if (_bottomViewLayout.isHidden) {
        [self setBottomViewLayoutVisible:YES withKeyboardHeight:0 animationDuration:0.3 andCurve:UIViewAnimationCurveLinear];
    } else {
        
        [self setBottomViewLayoutVisible:NO withKeyboardHeight:0 animationDuration:0.3 andCurve:UIViewAnimationCurveLinear];
    }
}

- (void)cancelEdit:(UIBarButtonItem *)sender {
    NSLog(@"cancel editing");
    if (_modeEdit) {
        _modeEdit = NO;
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self toggleUIEnableWithModeEditingStatus];
    
}

- (void)doneEditing:(UIBarButtonItem *)sender {
    NSLog(@"done editing");
    if (!_modeEdit) {
        _modeEdit = YES;
        [self toggleUIEnableWithModeEditingStatus];
    } else {
        if ([self saveToDatabase]) {
            NSLog(@"saved");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [[[UIAlertView alloc]initWithTitle:@"Failed" message:@"failed to save guide" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]show];
        }
        
    }
    
}

- (BOOL) saveToDatabase {
    NSLog(@"saving to database");
    Guides *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Guides" inManagedObjectContext:self.managedObjectContext];
    newEntry.title = _textFieldTitle.text;
    newEntry.dateCreated = [NSDate date];
    newEntry.author = @"My Self";
    newEntry.isUploaded = [NSNumber numberWithBool:YES];
    newEntry.steps = nil;
    NSLog(@"trying to save now....");
    
    NSError *error;
    if ([self.managedObjectContext save:&error]) {
        NSLog(@"saved....");
        [self.view endEditing:YES];
        return YES;
    }
    NSLog(@"Whoops, couldn't save: %@", error);
    //  5
    return NO;
}

#pragma mark - Other
- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
