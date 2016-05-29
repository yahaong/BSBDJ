//
//  MeCell.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.textColor = [UIColor grayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if ( nil == self.imageView.image) {
        return;
    }
    self.imageView.y = kMargin * 0.5;
    self.imageView.height = self.height - 2 * self.imageView.y;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
