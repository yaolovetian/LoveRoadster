//
//  LoveRoadsterViewController.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "BaseViewController.h"


extern NSArray *categorys;

@interface LoveRoadsterViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSInteger _currentPage;
    BOOL _isRefreshing;
    BOOL _isLoadMore;
    AFHTTPRequestOperationManager *_manager;
}

//想用set get方法

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic)NSInteger currentPage;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
//分类 看是属于哪个类 改装 养护和视频

@property (nonatomic,copy)NSString *requestUrl;

@property (nonatomic,copy)NSString *category;

#pragma mark - 如果不满足子类 那么子类自己重写 把方法写在.h中 方便子类调用 

- (void)firstDownload;

- (void)addTaskUrl:(NSString *)url isRefreshing:(BOOL)isRefreshing;

- (void)creatRefreshView;

- (void)endRefreshing;



@end
