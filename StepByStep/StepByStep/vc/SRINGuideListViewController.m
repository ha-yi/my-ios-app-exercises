//
//  SRINGuideListViewController.m
//  StepByStep
//
//  Created by MSCI on 2/18/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import "SRINGuideListViewController.h"
#import "Guides.h"
#import "Steps.h"
#import "SRINAppDelegate.h"


@interface SRINGuideListViewController ()

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSArray* fetchedRecordsArray;

@end

@implementation SRINGuideListViewController

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
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.fetchedRecordsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Guides * record = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",record.title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",record.author];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    SRINAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedRecordsArray = [appDelegate getAllGuidesRecord];
    [_tableView reloadData];
    NSLog(@"view will appear");
}

@end
