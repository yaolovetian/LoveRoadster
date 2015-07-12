//
//  CityCell.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell

- (void)awakeFromNib {
    // Initialization code
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"CityCell" owner:self options:nil];
//        self = [arr objectAtIndex:0];
//    }
//    return self;
//}

- (void)showDataWithModel:(CityModel *)model {
        self.model = model;
        NSString *str = model.CreateDate;
        /************用字符串分割来求出时间*****************/
        if ([str hasPrefix:@"/"]) {
            NSString *subStr = [str substringWithRange:NSMakeRange(6, 10)];
            model.CreateDate = subStr;
        }
        /************************************************/
        self.CreatDateLabel.text = [LZXHelper dateStringFromNumberTimer:model.CreateDate];
        self.TitleLabel.text = model.Title;
        CGFloat h = [LZXHelper textHeightFromTextString:model.Title width:kScreenSize.width-20 fontSize:12];
        CGRect frame = self.TitleLabel.frame;
        frame.size.height = h;
        self.TitleLabel.frame = frame;
        [self.ImageUrlView sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed: @"6"]];
}

@end
