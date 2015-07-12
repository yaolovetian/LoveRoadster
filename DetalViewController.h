//
//  DetalViewController.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "BaseViewController.h"
#import "DetailModel.h"
#import "AppModel.h"

@interface DetalViewController : BaseViewController

@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *htmlStr;
@property (nonatomic,copy)NSString *Content;
@property (nonatomic,copy)NSString *CategoryID;


//- (void)downDetailDataWithURL:(NSString *)url;

- (void)showUI;
- (void)downloadDetailDataWithUrl:(NSString *)url;
- (void)parserDataWithWebOrGData;

@end
