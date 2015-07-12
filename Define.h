//
//  Define.h
//  LoveRoadster
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 姚帅. All rights reserved.
//

#ifndef LoveRoadster_Define_h
#define LoveRoadster_Define_h


//开发过程中 调试代码用
//上线的时候 可以

#define __UpLine__ // 上线的时候打开

#ifndef __UpLine__
//如果没有定义上面的宏 NSLog(...) 表示一个变参宏 用后面的代码替换NSLog(__VA_ARGS__) 接收前面的变参

// NSLog(__VA_ARGS__)就是以前的NSLog 函数

#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


//获取 屏幕的大小
#define kScreenSize [UIScreen mainScreen].bounds.size


#import "LZXHelper.h"
#import "MyControl.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ADView.h"

// category对应的字符串为:
#define kMODIFY @"1"        // 改装
#define kCONSERVE @"2"     // 养护
#define kVIDEO @"4"        // 视频
#define kBEAUTY @"3"       // 美图
#define kCITY @"5"         //车讯
// 改装 养护 视频 美图 车讯 接口
#define CONTENTS_URL @"http://data.wanchezhijia.com/data.ashx?action=getparentnewsformobile&CategoryParentID=%@&page=%ld&Size=%ld"



#define DETAIL_URL @"http://data.wanchezhijia.com/data.ashx?action=getwpnewsbyid&ID=%@"

#define SHARAE_URL @"http://www.wanchezhijia.com/%@/%@.html?share=1"


#define SEARCH_URL @"http://data.wanchezhijia.com/data.ashx?action=gethotcarmodels"

#define VIDEO_URL @"http://player.youku.com/embed/%@"

//那个上边的 %@ 就是上级界面的ID


#endif
