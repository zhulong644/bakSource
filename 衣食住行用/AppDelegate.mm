//
//  AppDelegate.m
//  衣食住行用
//
//  Created by 朱龙 on 15/9/29.
//  Copyright (c) 2015年 朱龙. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLTabBarViewController.h"
#import "ZLNavigationController.h"
#import "LoadViewViewController.h"
#import "MainIntefaceTableViewController.h"
#import "AboutViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MTConst.h"
#import "FoodList.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "Realtime.h"
#import "FWeather.h"
#import "Life.h"
#import "LInfo.h"
#import "MTConst.h"
#import "Huang.h"
#import "TodayTomorrow.h"
#import "Movie.h"
#import "MainTableViewController.h"
#import "AFNetworking.h"

@interface AppDelegate ()
/** 美食列表 */
@property (nonatomic, strong) NSArray *foodList;

/** 实时情况 */
@property (nonatomic, strong) Realtime *realtime;
/** 天气情况 */
@property (nonatomic, strong) NSArray *weather;
/** 生活指数 */
@property (nonatomic, strong) Life *life;

/** 日历 */
@property (nonatomic, strong) Huang *huangli;
/** 星座 */
@property (nonatomic, strong) TodayTomorrow *conToday;
/** 电影列表 */
@property (nonatomic, strong) NSArray *movieList;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self foodTest];
//    [self weatherTest];
//    [self movieTest];
//    [self constellationTest];
    LoadViewViewController *ui = [[LoadViewViewController alloc] init];
    [self.window setRootViewController:ui];
    [self.window makeKeyAndVisible];
    
    return YES;
}
#pragma mark - 美食数据加载

- (void)foodTest
{
    int number = (int)(1 + (arc4random() % 50));

    NSString *cid = [NSString stringWithFormat:@"%d",number];
    
    NSString *path = @"http://apis.juhe.cn/cook/index";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"cid":cid,@"key":@"5ea5902a623b185ee961c59bdb082f91"};
    
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        NSLog(@"%d",error_code);
        if (!error_code) {
            NSArray *foodListArr = [FoodList objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
            NSArray *smallArray = [foodListArr subarrayWithRange:NSMakeRange(0, 4)];
            self.foodList = smallArray;
            [self weatherTest];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    
}
#pragma mark - 天气数据加载
- (void)weatherTest
{
    NSString *path = @"http://op.juhe.cn/onebox/weather/query";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSDictionary *parameters = @{@"cityname":@"北京",@"key":@"d7535a64b6a89f259762b17766e0acac"};
    
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        NSLog(@"%d",error_code);
        if (!error_code) {
            
            Realtime *realtime = [Realtime objectWithKeyValues:responseObject[@"result"][@"data"][@"realtime"]];
            NSArray *fWeather = [FWeather objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"][@"weather"]];
            Life *life = [Life objectWithKeyValues:responseObject[@"result"][@"data"][@"life"]];
            self.realtime = realtime;
            self.life = life;
            self.weather = fWeather;
            
            [self dateTest];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    
}
#pragma mark - 黄历数据加载
- (void)dateTest
{
    //初始化日期
    NSDate *date = [NSDate date];//获取当前的时间
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeString= [formatter stringFromDate:date];
     NSString *path = @"http://v.juhe.cn/laohuangli/d";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"date":timeString,@"key":@"0cff2ec19c9fdcde10e5b3e0683db4f0"};
    
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        NSLog(@"%d",error_code);
        if (!error_code) {
            
            Huang *huang = [Huang objectWithKeyValues:responseObject[@"result"]];
            self.huangli = huang;
            [self constellationTest];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];

    

}
#pragma mark - 星座数据加载
- (void)constellationTest
{
    NSString *path = @"http://web.juhe.cn:8080/constellation/getAll";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *parameters = @{@"consName":@"处女座", @"type":@"today",@"key":@"0e093949b2f515063fad11e430add1b3"};
    
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        NSLog(@"返回的code为===%d",error_code);
        if (!error_code) {

            TodayTomorrow *today = [TodayTomorrow objectWithKeyValues:responseObject];
            self.conToday = today;
            [self movieTest];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];

}
#pragma mark - 电影测试
- (void)movieTest
{

    NSString *path = @"http://v.juhe.cn/movie/movies.today";

    NSDictionary *params = @{@"cityid":@"2",@"key":@"48792b8578139ef988b9b5a2a3c63907"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        NSLog(@"%d",error_code);
        if (!error_code) {
            NSArray *movies = [Movie objectArrayWithKeyValuesArray:responseObject[@"result"]];
            NSArray *smallArray = [movies subarrayWithRange:NSMakeRange(0, 7)];
            self.movieList = smallArray;
            NSLog(@"movieTest成功");
            [self secondStyle];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];


}
#pragma mark - 第二种样式
- (void)secondStyle
{
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    //第一个控制器
    MainIntefaceTableViewController *mainInterface = [[MainIntefaceTableViewController alloc] init];
    mainInterface.foodList = _foodList;
    mainInterface.realtime = _realtime;
    mainInterface.life = _life;
    mainInterface.weather = _weather;
    mainInterface.huangli = _huangli;
    mainInterface.conToday = _conToday;
    mainInterface.movieList = _movieList;
    
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:mainInterface];
    UIImage *unsel = [[UIImage imageNamed:@"ic_account_balance_white_36pt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *testimg = [UIImage imageNamed:@"ic_account_balance_36pt"];
    
    
    UIImage *sel = [testimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tb0=[[UITabBarItem alloc]initWithTitle:@"首页" image:unsel selectedImage:sel];
    navvc1.tabBarItem = tb0;
    //第二个控制器
//    MainListCollectionViewController *vc2 = [[MainListCollectionViewController alloc] init];
    MainTableViewController *vc2 = [[MainTableViewController alloc] initWithNibName:@"MainTableViewController" bundle:nil];
    UINavigationController *navvc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UIImage *unsel2 = [[UIImage imageNamed:@"ic_list_white_36pt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sel2 = [[UIImage imageNamed:@"ic_list_36pt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tb1 = [[UITabBarItem alloc]initWithTitle:@"功能表" image:unsel2 selectedImage:sel2];
    navvc2.tabBarItem = tb1;
    //第三个控制器
    AboutViewController *search = [[AboutViewController alloc] init];
    UINavigationController *navvc3 = [[UINavigationController alloc] initWithRootViewController:search];
    UIImage *unsel3 = [[UIImage imageNamed:@"ic_person_white_36pt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sel3 = [[UIImage imageNamed:@"ic_person_36pt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tb2 = [[UITabBarItem alloc]initWithTitle:@"关于" image:unsel3 selectedImage:sel3];
    navvc3.tabBarItem = tb2;
    
    UIColor *titleHighlightedColor = [UIColor colorWithRed:0/255.0 green:151/255.0 blue:137/255.0 alpha:1.0];
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    UINavigationBar *bar = [UINavigationBar appearance];//设置导航栏
    
    bar.translucent = NO;//防止导航栏遮挡下面的内容
    
        bar.barTintColor = titleHighlightedColor; //设置显示的颜色
    
    bar.tintColor = [UIColor whiteColor];  //设置字体颜色
    
    //    [bar setBarTintColor:titleHighlightedColor];
    
    NSArray *array = [NSArray arrayWithObjects:navvc1, navvc2, navvc3, nil];
    
    tab.viewControllers = array;
    
    [self.window setRootViewController:tab];
    [self.window makeKeyAndVisible];
   
    [NSThread sleepForTimeInterval:2.0];//设置启动页面时间
}
//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
       return UIInterfaceOrientationMaskPortrait;
}
@end
