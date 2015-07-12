//
//  BeautyViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "BeautyViewController.h"
#import "BeautyModel.h"
#import "BeautyCell.h"
#import "DetalViewController.h"
#import "DetailModel.h"
#import "BeautyDetailViewController.h"
#import "AppModel.h"

@interface BeautyViewController ()

@end

@implementation BeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BeautyCell" bundle:nil] forCellReuseIdentifier:@"BeautyCell"];
    [self firstDownload];
    [self creatRefreshView];
}

- (void)firstDownload {
    self.currentPage = 1;
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    self.category = @"3";
    [self addTaskUrl:self.requestUrl isRefreshing:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeautyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeautyCell" forIndexPath:indexPath];
    BeautyModel *model = self.dataArr[indexPath.row];
    [cell shoeDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 280;
}
#pragma mark - 重写父类的方法 这个要实现照片墙的功能

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailModel *model = _dataArr[indexPath.row];
    BeautyDetailViewController *beauty = [[BeautyDetailViewController alloc]init];
    beauty.url = [NSString stringWithFormat:DETAIL_URL,model.ID];
    AppModel *model1 = _dataArr[indexPath.row];
    beauty.CategoryID = model1.CategoryID.stringValue;
    beauty.ID = model1.ID.stringValue;
    [self presentViewController:beauty animated:YES completion:nil];
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
