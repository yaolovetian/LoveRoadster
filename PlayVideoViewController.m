//
//  PlayVideoViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "PlayVideoViewController.h"


@interface PlayVideoViewController ()

@end

@implementation PlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMoviePlayer];
}
#pragma mark - 创建视频播放器
- (void)creatMoviePlayer {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed: @"7"];
    [self.view addSubview:imageView];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, kScreenSize.height/4, kScreenSize.width, kScreenSize.height/2)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [web loadRequest:request];
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
