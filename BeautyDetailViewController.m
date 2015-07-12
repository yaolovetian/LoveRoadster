//
//  BeautyDetailViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-21.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "BeautyDetailViewController.h"
#import "GDataXMLNode.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "AppModel.h"

@interface BeautyDetailViewController ()<UIScrollViewDelegate,UMSocialUIDelegate>
{
    AFHTTPRequestOperationManager *_manager;
    UIImageView *_imageView;
    UIScrollView *_scrollView;
    NSMutableArray *_strArr;
}


@property (nonatomic,strong)NSMutableArray *strArr;
@end

@implementation BeautyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strArr = [[NSMutableArray alloc]init];
    [self showUI];
    [self downloadDetailDataWithUrl:self.url];
}

- (void)showUI {
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView1.image = [UIImage imageNamed: @"7"];
    [self.view addSubview:imageView1];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
    UIButton *button1 = [MyControl creatButtonWithFrame:CGRectMake(5, 15, 50, 50) target:self sel:@selector(btnClick:) tag:101 image:nil title:@"返回"];
    button1.tintColor = [UIColor blackColor];
    UIButton *button2 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-55, 15, 50, 50) target:self sel:@selector(btnClick:) tag:102 image:@"share@2x" title:nil];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.frame];
    [imageView setImage:[UIImage imageNamed: @"31"]];
    [view addSubview:imageView];
    
    [view addSubview:button1];
    [view addSubview:button2];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
}

- (void)btnClick:(UIButton *)button {
    switch (button.tag) {
        case 101:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 102:
        {
            //分享
            [self shareData];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UM分享

- (void)shareData {
    NSString *name = @"qctp";
    NSString *body = [NSString stringWithFormat:SHARAE_URL,name,self.ID];
    [UMSocialSnsService presentSnsIconSheetView:self
                            appKey:@"507fcab25270157b37000010"
                                shareText:body
                                     shareImage:[UIImage imageNamed:@"icon"]
                                       shareToSnsNames:@[UMShareToTwitter,UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToSms] delegate:self];
}

#pragma mark - 实现下载方法

- (void)downloadDetailDataWithUrl:(NSString *)url {
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            _htmlStr = dict[@"Content"];
            [self parserDataWithWebOrGData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
}

#pragma mark -解析数据

- (void)parserDataWithWebOrGData {
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithHTMLString:self.htmlStr encoding:NSUTF8StringEncoding error:nil];
    NSArray *trNodeArr = [doc nodesForXPath:@"//tr" error:nil];
    for (GDataXMLElement *element in trNodeArr) {
        GDataXMLElement *td = [element nodesForXPath:@"td" error:nil][2];
        [imageArr addObject:td];
    }
    NSArray *srcArr = [[NSArray alloc]init];
    for (NSInteger i = 0; i<imageArr.count; i++) {
        srcArr = [imageArr[i]nodesForXPath:@"//@src" error:nil];
    }
    for (GDataXMLNode *node in srcArr) {
        NSString *src = [node stringValue];
        [self.strArr addObject:src];
    }
    [self creatScrollView];
}

- (void)creatScrollView {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, kScreenSize.width, kScreenSize.height-64)];
    for (NSInteger i = 0; i<_strArr.count; i++) {
        if (i%2 == 1) {
            _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i/2*_scrollView.bounds.size.width, kScreenSize.height/4, _scrollView.bounds.size.width, _scrollView.bounds.size.height/2)];
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_strArr[i]] placeholderImage:[UIImage imageNamed: @"6"]];
            _imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:_imageView];
        }
    }
    _scrollView.contentSize = CGSizeMake(_strArr.count/2*_scrollView.bounds.size.width, _scrollView.bounds.size.height-64);
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}

#pragma mark - 滚动协议

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
