//
//  LoveRoadsterTabBarController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "LoveRoadsterTabBarController.h"
#import "LoveRoadsterViewController.h"


@interface LoveRoadsterTabBarController ()

@end

@implementation LoveRoadsterTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
}

- (void)creatViewControllers {
    NSArray *titles = @[@"改装",@"养护",@"视频",@"美图",@"车讯"];
    NSArray *classNames = @[@"ModifyViewController",@"ConserveViewController",@"VideoViewController",@"BeautyViewController",@"CityViewController"];
    NSArray *imageNames = @[@"1@2x",@"2@2x",@"3@2x",@"4@2x",@"5@2x"];
    NSArray *categorys = @[kMODIFY,kCONSERVE,kVIDEO,kBEAUTY,kCITY];
    NSMutableArray *vcArr = [NSMutableArray array];
    for (NSInteger i = 0 ; i<titles.count; i++) {
        Class vcClass = NSClassFromString(classNames[i]);
       LoveRoadsterViewController *vc = [[vcClass alloc]init];
        vc.category = categorys[i];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.title = titles[i];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"32"]];
        imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width,44);
        [nav.navigationBar addSubview:imageView];
        nav.tabBarItem.image = [[UIImage imageNamed:imageNames[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageNames[i]]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vcArr addObject:nav];
    }
    self.viewControllers = vcArr;
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
