//
//  mouldItemTableViewCell.m
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/8.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import "mouldItemTableViewCell.h"

@interface mouldItemTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *contenLabel;
@end

@implementation mouldItemTableViewCell

- (void)setEntity:(NSDictionary *)entity {
    self.contenLabel.text = entity[@"contentValue"];
    self.contenLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
