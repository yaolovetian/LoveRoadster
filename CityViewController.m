//
//  CityViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "CityViewController.h"
#import "CityModel.h"
#import "CityCell.h"
#import "JHRefresh.h"
#import "DetalViewController.h"
#import "DetailModel.h"
#import "AppModel.h"

//#import "DetailCell.h"


@interface CityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    AFHTTPRequestOperationManager *_manager;
}
@property (nonatomic,retain)UICollectionView *collectionView;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic)NSInteger currentPage;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
//分类 看是属于哪个类 改装 养护和视频

@property (nonatomic,copy)NSString *requestUrl;

@property (nonatomic,copy)NSString *category;
@end

@implementation CityViewController
//车讯界面可以用UICollectionView 来做 效果就是这样的

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCollectionView];
    [self creatRefreshView];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     [self firstDownload];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}
#pragma mark -第一次下载

- (void)firstDownload {
    self.currentPage = 1;
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    self.category = @"5";
    [self addTaskUrl:self.requestUrl isRefreshing:NO];
}

#pragma mark -  创建collectionView 不用父类的tableView 自己重新写一个collectionView,下载数据不用重写,直接就可以继承 就是重新布局的问题

- (void)creatCollectionView {
    _dataArr = [[NSMutableArray alloc]init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64-49) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CityCell" bundle:nil] forCellWithReuseIdentifier:@"CityCell"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
}

#pragma mark -  实现UICollectionView 的协议方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
       return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityCell" forIndexPath:indexPath];
    CityModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenSize.width-10)/2, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailModel *model = _dataArr[indexPath.row];
    DetalViewController *detail = [[DetalViewController alloc]init];
    detail.url = [NSString stringWithFormat:DETAIL_URL,model.ID];
    AppModel *model1 = _dataArr[indexPath.row];
    detail.CategoryID = model1.CategoryID.stringValue;
    detail.ID = model1.ID.stringValue;
    [self presentViewController:detail animated:YES completion:nil];
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
                CityModel *model = [[CityModel alloc]init];
                [model setValuesForKeysWithDictionary:appDict];
                [mySelf.dataArr addObject:model];
            }
            [mySelf.collectionView reloadData];
            [mySelf endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mySelf endRefreshing];
    }];
}

#pragma mark -  创建刷新视图

- (void)creatRefreshView {
    __weak typeof(self)mySelf = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (mySelf.isRefreshing) {
            return ;
        }
        mySelf.currentPage = 1;
        mySelf.isRefreshing = YES;
        [mySelf addTaskUrl:mySelf.requestUrl isRefreshing:YES];
    }];
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
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
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.collectionView footerEndRefreshing];
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
