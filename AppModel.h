//
//  AppModel.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "MyModel.h"

@interface AppModel : MyModel

@property (nonatomic,copy)NSNumber *ID;
@property (nonatomic,copy)NSNumber *CategoryID;
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *Description;
@property (nonatomic,copy)NSString *UpdateDate;
@property (nonatomic,copy)NSString *CreateDate;
@property (nonatomic,copy)NSString *ImageUrl;
@property (nonatomic,copy)NSString *Keywords;
@property (nonatomic,copy)NSString *Content;
@property (nonatomic,copy)NSString *TargetUrl;

@end
