//
//  CityCell.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface CityCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageUrlView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *CreatDateLabel;

@property (nonatomic,copy)NSString *ID;

@property (nonatomic,retain)CityModel *model;

- (void)showDataWithModel:(CityModel *)model;


@end
