//
//  mouldGroupTableViewCell.m
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/8.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import "mouldGroupTableViewCell.h"

@interface mouldGroupTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomLineLeading;
@end

@implementation mouldGroupTableViewCell
- (void)setEntity:(NSDictionary *)entity {
    self.label.text  = entity[@"name"];
    self.label.textColor = [UIColor whiteColor];
    self.bottomLineLeading.constant = 76 + (arc4random() % 20);
    self.image.alpha = 0;
    [self.image sd_setImageWithURL:[NSURL URLWithString:entity[@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(error == nil){
            self.image.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.image.tintColor = [UIColor whiteColor];
            [UIView animateWithDuration:0.5f animations:^{
                self.image.alpha = 1;
            }];
        }
    }];
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
