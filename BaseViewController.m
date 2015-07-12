//
//  BaseViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "BaseViewController.h"
//#import "MyControl.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
- (void)addItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 50, 30) target:target sel:@selector(searchClick:) tag:100 image:@"search" title:title];
  [button setImage:[UIImage imageNamed: @"search"] forState:
     UIControlStateNormal];
   button.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}
*/
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
