//
//  BeautyCell.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "BeautyCell.h"

@implementation BeautyCell

- (void)awakeFromNib {
 //   self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)shoeDataWithModel:(BeautyModel *)model {
    self.titleLabel.text = model.Title;
    [self.imageUrlView sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed: @"6"]];
}








@end
