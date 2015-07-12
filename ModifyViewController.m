//
//  ModifyViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "ModifyViewController.h"


#import "DetalViewController.h"

@interface ModifyViewController ()
{
    ADView *_view;
}
@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstDownload];
    if (kScreenSize.width == 320) {
      _view = [[ADView alloc]initWithFrame:CGRectMake(0, 100, kScreenSize.width, 220)];
    }else if (kScreenSize.width == 375) {
     _view = [[ADView alloc]initWithFrame:CGRectMake(0, 100, self.tableView.bounds.size.width, 250)];
    }
    self.tableView.tableHeaderView = _view;
    [self creatRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
