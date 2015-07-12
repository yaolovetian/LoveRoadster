//
//  LoveRoadsterViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "LoveRoadsterViewController.h"
#import "AppModel.h"
#import "PicCell.h"
#import "JHRefresh.h"
#import "DetalViewController.h"
#import "DetailModel.h"

@interface LoveRoadsterViewController ()

@end

@implementation LoveRoadsterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

#pragma mark -  创建表格视图

- (void)creatTableView {
    _dataArr = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PicCell" bundle:nil]forCellReuseIdentifier:@"PicCell"];
    [self.view addSubview:self.tableView];
}

#pragma mark - 实现tableView 的协议

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell"];
    AppModel *model = self.dataArr[indexPath.row];
    cell.category = self.category;
    [cell showDataWithModel:model];
    return cell;
}

#pragma mark - 选中cell 实现界面的跳转  跳转到详情页

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailModel *model = _dataArr[indexPath.row];
    DetalViewController *detail = [[DetalViewController alloc]init];
    detail.url = [NSString stringWithFormat:DETAIL_URL,model.ID];
    AppModel *model1 = _dataArr[indexPath.row];
    detail.CategoryID = model1.CategoryID.stringValue;
    detail.ID = model1.ID.stringValue;
    [self presentViewController:detail animated:YES completion:nil];
}


#pragma mark -   实现.h文件中的方法

- (void)firstDownload {
    self.currentPage = 1;
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    self.category = @"1";
    [self addTaskUrl:self.requestUrl isRefreshing:NO];
}

- (void)addTaskUrl:(NSString *)url isRefreshing:(BOOL)isRefreshing {
    url = [NSString stringWithFormat:CONTENTS_URL,self.category,self.currentPage,(long)20];
    __weak typeof(self)mySelf = self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            if (mySelf.currentPage == 1) {
                [mySelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *arr = dict[@"List"];
            for (NSDictionary *appDict in arr) {
                AppModel *model = [[AppModel alloc]init];
                [model setValuesForKeysWithDictionary:appDict];
                [mySelf.dataArr addObject:model];
            }
            [mySelf.tableView reloadData];
            [mySelf endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mySelf endRefreshing];
    }];
}

#pragma mark -  创建刷新视图

- (void)creatRefreshView {
    __weak typeof(self)mySelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (mySelf.isRefreshing) {
            return ;
        }
        mySelf.currentPage = 1;
        mySelf.isRefreshing = YES;
        [mySelf addTaskUrl:mySelf.requestUrl isRefreshing:YES];
    }];
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (mySelf.isLoadMore) {
            return ;
        }
        mySelf.isLoadMore = YES;
        mySelf.currentPage ++;
        [mySelf addTaskUrl:mySelf.requestUrl isRefreshing:YES];
    }];
}

#pragma mark - 结束刷新

-(void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
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
