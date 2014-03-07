//
//  TeQDlCell.m
//  SimpleDownloader
//
//  Created by MSCI on 2/20/14.
//  Copyright (c) 2014 TQ. All rights reserved.
//

#import "TeQDlCell.h"

@implementation TeQDlCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (TeQDlCell *)cell {
    return [[[NSBundle mainBundle] loadNibNamed:@"DlCell" owner:nil options:nil] objectAtIndex:0];
}

@end
