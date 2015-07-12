//
//  CityModel.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "MyModel.h"

@interface CityModel : MyModel
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *CreateDate;
@property (nonatomic,copy)NSString *ImageUrl;
@property (nonatomic,copy)NSNumber *ID;
@property (nonatomic,copy)NSNumber *CategoryID;


@end
