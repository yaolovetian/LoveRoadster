//
//  ADView.m
//  UITableView_Cell定制
//
//  Created by LZXuan on 14-12-18.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//

#import "ADView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "DetalViewController.h"
#import "AppModel.h"

#define kUrl @"http://data.wanchezhijia.com/data.ashx?action=getparentnewsformobile&CategoryParentID=1&page=1&Size=10"

#define kScreenSize [UIScreen mainScreen].bounds.size

@implementation ADView
{
    UIImageView *_imageView;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr=[[NSMutableArray alloc] init];
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self downloadDataWithUrl];
     }
    return self;
}

-(void)downloadDataWithUrl{
    NSString *url = kUrl;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            //用AFNetWorking 下载的数据 记着需要加那句转化成二进制 代码
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *arr = dict[@"List"];
            for (NSDictionary *appDict in arr) {
                [_dataArr addObject:appDict[@"ImageUrl"]];
            }
            [self creatView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载失败");
    }];
}


- (void)creatView{
    if (kScreenSize.width == 320) {
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 220)];
        _imageView.userInteractionEnabled = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 220)];
        for (int i = 0; i < 5; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, 220)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_dataArr[i]]placeholderImage:[UIImage imageNamed: @"6"]];
            [_scrollView addSubview:imageView];
        }
        //下面设置滚动视图
        _scrollView.contentSize = CGSizeMake(5*kScreenSize.width, 200);
        _scrollView.showsVerticalScrollIndicator = NO;
        //按页
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        [_imageView addSubview:_scrollView];
        //页码器
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 200, kScreenSize.width, 30)];
        _pageControl.numberOfPages = 5;
        [_pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
        [_imageView addSubview:_pageControl];
    }else if (kScreenSize.width == 375) {
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 250)];
        _imageView.userInteractionEnabled = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 250)];
        for (int i = 0; i < 5; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, 250)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_dataArr[i]]placeholderImage:[UIImage imageNamed: @"6"]];
            [_scrollView addSubview:imageView];
        }
        //下面设置滚动视图
        _scrollView.contentSize = CGSizeMake(5*kScreenSize.width, 240);
        _scrollView.showsVerticalScrollIndicator = NO;
        //按页
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        [_imageView addSubview:_scrollView];
        //页码器
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 220, kScreenSize.width, 50)];
        _pageControl.numberOfPages = 5;
        [_pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
        [_imageView addSubview:_pageControl];
    }
   
    [self addSubview:_imageView];
}

- (void)pageClick:(UIPageControl *)page {
    //修改滚动视图的偏移量
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*page.currentPage, 0) animated:YES];
}
//减速停止的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //修改页码
    CGPoint offset = _scrollView.contentOffset;
    _pageControl.currentPage = offset.x/_scrollView.bounds.size.width;
}

@end
