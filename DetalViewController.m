//
//  DetalViewController.m
//  LoveRoadster
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#import "DetalViewController.h"
#import "AppModel.h"

//#import "DetailCell.h"
#import "UMSocial.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface DetalViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
{
    UIWebView * _webView;
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_datailDataArr;
    NSString *_htmlStr;
}

@property (nonatomic,strong)NSMutableArray *detailDataArr;
@property (nonatomic,strong)DetailModel *detailModel;
@end

@implementation DetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downloadDetailDataWithUrl:self.url];
    [self showUI];
}

- (void)showUI {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
    UIImageView *bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    bigImageView.image = [UIImage imageNamed: @"8"];
    [self.view addSubview:bigImageView];
 //   self.view.backgroundColor = [UIColor redColor];
    UIButton *button1 = [MyControl creatButtonWithFrame:CGRectMake(15, 15, 50, 50) target:self sel:@selector(btnClick:) tag:101 image:nil title:@"返回"];
    button1.tintColor = [UIColor blackColor];
    UIButton *button2 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-65, 15, 50, 50) target:self sel:@selector(btnClick:) tag:102 image:@"share@2x" title:nil];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
    imageView.image = [UIImage imageNamed: @"123"];
    [view addSubview:imageView];
    [view addSubview:button1];
    [view addSubview:button2];
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
    NSString *name = @"";
    switch (self.CategoryID.integerValue) {
        case 6:
        {
            name = @"xinche";
        }
            break;
        case 7:
        {
            name = @"gzcx";
        }
            break;
        case 8:
        {
            name = @"qindu";
        }
            break;
        case 9:
        {
            name = @"zhongdu";
        }
            break;
        case 10:
        {
            name = @"zuopin";
        }
            break;
        case 11:
        {
            name = @"byal";
        }
            break;
        case 19:
        {
            name = @"gaizhuangjian";
        }
            break;
        case 23:
        {
            name = @"jijie";
        }
            break;
        case 24:
        {
            name = @"jiqiao";
        }
            break;
        case 74:
        {
            name = @"gzcx";
        }
            break;
        case 79:
        {
            name = @"shenghuo";
        }
            break;
        case 80:
        {
            name = @"yanghu";
        }
            break;
        default:
            break;
    }
    NSString *body = [NSString stringWithFormat:SHARAE_URL,name,self.ID];
    [UMSocialSnsService presentSnsIconSheetView:self
                        appKey:@"507fcab25270157b37000010"
                          shareText:body
                            shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToSms] delegate:self];
}

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

- (void)parserDataWithWebOrGData {
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64)];
    _webView.delegate = self;
    [_webView loadHTMLString:_htmlStr baseURL:nil];
   
}

#pragma mark - 设置详情文本的大小

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (kScreenSize.width == 320 ) {
        NSString * srt = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '85%'";
        [_webView stringByEvaluatingJavaScriptFromString:srt];
        [webView stringByEvaluatingJavaScriptFromString:
         @"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function ResizeImages() { "
         "var myimg,oldwidth;"
         "var maxwidth=300;" //缩放系数
         "for(i=0;i <document.images.length;i++){"
         "myimg = document.images[i];"
         "if(myimg.width > maxwidth){"
         "oldwidth = myimg.width;"
         "myimg.width = maxwidth;"
         "myimg.height = myimg.height * (maxwidth/oldwidth)+120;"
         "}"
         "}"
         "}\";"
         "document.getElementsByTagName('head')[0].appendChild(script);"];
        [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    }else if (kScreenSize.width == 375) {
        NSString * srt = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '95%'";
        [_webView stringByEvaluatingJavaScriptFromString:srt];
        [webView stringByEvaluatingJavaScriptFromString:
         @"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function ResizeImages() { "
         "var myimg,oldwidth;"
         "var maxwidth=360;" //缩放系数
         "for(i=0;i <document.images.length;i++){"
         "myimg = document.images[i];"
         "if(myimg.width > maxwidth){"
         "oldwidth = myimg.width;"
         "myimg.width = maxwidth;"
         "myimg.height = myimg.height * (maxwidth/oldwidth)+160;"
         "}"
         "}"
         "}\";"
         "document.getElementsByTagName('head')[0].appendChild(script);"];
        
        [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    }   
     [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
