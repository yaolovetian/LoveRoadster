//
//  ConserveViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "ConserveViewController.h"

@interface ConserveViewController ()

@end

@implementation ConserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstDownload];
    [self creatRefreshView];
}

- (void)firstDownload {
    self.currentPage = 1;
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    self.category = @"2";
    [self addTaskUrl:self.requestUrl isRefreshing:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
