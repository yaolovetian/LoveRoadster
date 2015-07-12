//
//  PicCell.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "PicCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppModel.h"

@implementation PicCell

- (void)awakeFromNib {
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(AppModel *)model {
    self.model = model;
    NSString *str = model.CreateDate;
/************用字符串分割来求出时间*****************/
    if ([str hasPrefix:@"/"]) {
        NSString *subStr = [str substringWithRange:NSMakeRange(6, 10)];
         model.CreateDate = subStr;
    }
/************************************************/
    self.CreateDateLabel.text = [LZXHelper dateStringFromNumberTimer:model.CreateDate];
    self.titleLabel.text = model.Title;
    CGFloat h = [LZXHelper textHeightFromTextString:model.Title width:220 fontSize:14];
    CGRect frame = self.titleLabel.frame;
    frame.size.height = h;
    self.titleLabel.frame = frame;
    self.wID = model.ID.stringValue;
    self.Content = model.Content;
     [self.imageCar sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed: @"7"]];
}

@end
