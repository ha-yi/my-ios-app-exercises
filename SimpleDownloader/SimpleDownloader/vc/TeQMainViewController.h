//
//  TeQMainViewController.h
//  SimpleDownloader
//
//  Created by MSCI on 2/20/14.
//  Copyright (c) 2014 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeQMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)addNewDownload:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tabelView;

@end
