//
//  BeautyCell.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyModel.h"

@interface BeautyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageUrlView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)shoeDataWithModel:(BeautyModel *)model;

@end
