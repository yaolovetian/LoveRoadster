//
//  DetailModel.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "MyModel.h"

@interface DetailModel : MyModel

@property (nonatomic,copy)NSNumber *ID;
@property (nonatomic,copy)NSString *Content;
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *CreateDate;

@end
