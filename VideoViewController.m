//
//  VideoViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "VideoViewController.h"
#import "PlayVideoViewController.h"
#import "AppModel.h"


@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstDownload];
    [self creatRefreshView];
   
}

- (void)firstDownload {
    self.currentPage = 1;
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    self.category = @"4";
    [self addTaskUrl:self.requestUrl isRefreshing:NO];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppModel *model = self.dataArr[indexPath.row];
    PlayVideoViewController *play = [[PlayVideoViewController alloc]init];
    NSString *playUrl = [NSString stringWithFormat:VIDEO_URL,model.TargetUrl];
    play.url = playUrl;
    [self.navigationController pushViewController:play animated:YES];
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
