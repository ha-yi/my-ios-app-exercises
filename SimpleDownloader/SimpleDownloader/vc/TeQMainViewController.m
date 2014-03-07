//
//  TeQMainViewController.m
//  SimpleDownloader
//
//  Created by MSCI on 2/20/14.
//  Copyright (c) 2014 TQ. All rights reserved.
//

#import "TeQMainViewController.h"
#import "TeQDlCell.h"

@interface TeQMainViewController ()
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation TeQMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Simple Download Manager";
    _data = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewDownload:(UIButton *)sender {
    if (_textField.text.length == 0) {
        NSLog(@"Url is empty");
        return;
    }
    [_data addObject:_textField.text];
    
    _textField.text = @"";
    [self.view endEditing:YES];
    [_tabelView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"DlCell";
    TeQDlCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [TeQDlCell cell]; 
    }
    cell.labelTitle.text = [_data objectAtIndex:indexPath.row];
    cell.labelStatus.text = @"";
//    cell.textLabel.text = [_data objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}
@end
