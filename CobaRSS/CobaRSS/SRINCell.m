//
//  SRINCell.m
//  CobaRSS
//
//  Created by MSCI on 2/14/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import "SRINCell.h"

@implementation SRINCell

//@synthesize titleLabel = _titleLabel;
//@synthesize authorLabel = _authorLabel;
//@synthesize ratingLabel = _ratingLabel;
//@synthesize thumbnailImageView = _thumbnailImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"RecipeTableCell" owner:self options:nil] objectAtIndex:0];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
