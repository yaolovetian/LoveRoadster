//
//  PicCell.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"

@interface PicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageCar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *CreateDateLabel;

@property (nonatomic,copy)NSString *wID;
@property (nonatomic,copy)NSString *Content;


@property (nonatomic,copy)NSString *category;
@property (nonatomic,retain)AppModel *model;

- (void)showDataWithModel:(AppModel *)model;


@end
