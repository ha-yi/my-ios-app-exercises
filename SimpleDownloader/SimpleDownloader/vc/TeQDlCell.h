//
//  TeQDlCell.h
//  SimpleDownloader
//
//  Created by MSCI on 2/20/14.
//  Copyright (c) 2014 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeQDlCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
+(TeQDlCell *) cell;

@end
