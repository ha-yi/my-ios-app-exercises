//
//  SRINCell.h
//  CobaRSS
//
//  Created by MSCI on 2/14/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRINCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *authorLabel;
@property (nonatomic,weak) IBOutlet UILabel *ratingLabel;
@property (nonatomic,weak) IBOutlet UIImageView *thumbnailImageView;

@end
