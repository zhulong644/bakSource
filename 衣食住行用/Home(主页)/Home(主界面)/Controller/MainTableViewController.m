//
//  MainTableViewController.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/24.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableTableViewCell.h"
#import "Reachability.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MTConst.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "ExSelectViewController.h"
#import "Movie.h"
#import "MovieViewController.h"
#import "FWeather.h"
#import "Life.h"
#import "BusSelectTableView.h"
#import "ConstellationSelectedView.h"
#import "DefaultCalendarViewController.h"
#import "SelectTableViewController.h"
#import "GoodSearchView.h"
#import "ExpandTableViewController.h"
#import "FoodType.h"
#import "WeatherNewViewController.h"
#import "Exchange.h"
#import "ExchangeTableViewController.h"
#import "AFNetworking.h"

@interface MainTableViewController ()
@property (nonatomic, strong) NSArray *movies;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"功能列表"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    //去掉分隔线
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setExtraCellLineHidden:self.tableView];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainTableTableViewCell *cell = [MainTableTableViewCell cellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        cell.myImageView.image = [UIImage imageNamed:@"date"];
        cell.myLabel.text = @"老皇历";
    } else if (indexPath.row == 1) {
        cell.myImageView.image = [UIImage imageNamed:@"start"];
        cell.myLabel.text = @"星座运势";
    } else if (indexPath.row == 2) {
        cell.myImageView.image = [UIImage imageNamed:@"weather"];
        cell.myLabel.text = @"天气预报";
    } else if (indexPath.row == 3) {
        cell.myImageView.image = [UIImage imageNamed:@"food"];
        cell.myLabel.text = @"美食宝典";
    } else if (indexPath.row == 4) {
        cell.myImageView.image = [UIImage imageNamed:@"goods"];
        cell.myLabel.text = @"商品比价";
    } else if (indexPath.row == 5) {
        cell.myImageView.image = [UIImage imageNamed:@"bus"];
        cell.myLabel.text = @"公交信息";
    } else if (indexPath.row == 6) {
        cell.myImageView.image = [UIImage imageNamed:@"train"];
        cell.myLabel.text = @"火车查询";
    } else if (indexPath.row == 7) {
        cell.myImageView.image = [UIImage imageNamed:@"movie"];
        cell.myLabel.text = @"电影查询";
    } else if (indexPath.row == 8) {
        cell.myImageView.image = [UIImage imageNamed:@"exress"];
        cell.myLabel.text = @"快递查询";
    } else if (indexPath.row == 9) {
        cell.myImageView.image = [UIImage imageNamed:@"exchange"];
        cell.myLabel.text = @"货币汇率";
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self dateClick]; //老皇历
    } else if (indexPath.row == 1) {
        [self constellationClick];//星座运势
    } else if (indexPath.row == 2) {
        [self weatherClick];//天气预报
    } else if (indexPath.row == 3) {
        [self foodList]; //美食宝典
    } else if (indexPath.row == 4) {
        [self goodsClick];//商品比价
    } else if (indexPath.row == 5) {
        [self busSearchClick];//公交信息
    } else if (indexPath.row == 6) {
        [self trainMenuClick];//火车查询
    } else if (indexPath.row == 7) {
        [self movie];//电影查询
    } else if (indexPath.row == 8) {
        [self expressClick];//快递查询
    }else if (indexPath.row == 9) {
        [self exchangeClick];//货币汇率
    }

}
- (void)alert
{
    NSString *title = NSLocalizedString(@"无网络连接", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark - 快递点击方法
- (void)expressClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        ExSelectViewController *ex = [[ExSelectViewController alloc] initWithNibName:@"ExSelectViewController" bundle:nil];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ex animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [self alert];
    }
}
#pragma mark - 电影资讯点击方法
- (void)movie
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //replace
        NSString *path = @"http://v.juhe.cn/movie/movies.today";
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *parameters = @{@"cityid":@"2",@"key":@"48792b8578139ef988b9b5a2a3c63907"};
        
        [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
            NSLog(@"%d",error_code);
            if (!error_code) {
                
                NSArray *movies = [Movie objectArrayWithKeyValuesArray:responseObject[@"result"]];
                self.movies = movies;
                MovieViewController *movieMneu = [[MovieViewController alloc] init];
                movieMneu.movies = self.movies;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:movieMneu animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            } else {
                NSString *title = NSLocalizedString(@"系统维护中请稍后再试。", nil);
                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error:   %@",error.description);
        }];

    } else {
        [self alert];
    }
}
#pragma mark - 菜谱点击方法
- (void)foodList
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //replace
        NSString *path = @"http://apis.juhe.cn/cook/category";
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *parameters = @{@"key":@"5ea5902a623b185ee961c59bdb082f91"};
        
        [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {

            NSArray *foodTypes = [FoodType objectArrayWithKeyValuesArray:responseObject[@"result"]];
            ExpandTableViewController *foodMneu = [[ExpandTableViewController alloc] init];
            foodMneu.foodTypes = foodTypes;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:foodMneu animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error:   %@",error.description);
        }];
        
    } else {
        [self alert];
    }
}
#pragma mark - 货币汇率点击方法
- (void)exchangeClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //replace
        NSString *path = @"http://web.juhe.cn:8080/finance/exchange/rmbquot";
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *parameters = @{@"key":@"0762e5c1ab5c8ec1eac77ad22314363b"};
        
        [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSMutableArray *exchangeInfoArr = [[NSMutableArray alloc] init];
            
            Exchange *exchangeInfo1 = [Exchange
                                       objectWithKeyValues:responseObject[@"result"][0][@"data1"]];
            [exchangeInfoArr addObject:exchangeInfo1];//美元
            
            Exchange *exchangeInfo2 = [Exchange
                                       objectWithKeyValues:responseObject[@"result"][0][@"data2"]];
            [exchangeInfoArr addObject:exchangeInfo2];//欧元
            
            Exchange *exchangeInfo3 = [Exchange
                                       objectWithKeyValues:responseObject[@"result"][0][@"data3"]];
            [exchangeInfoArr addObject:exchangeInfo3];//港币
            
            Exchange *exchangeInfo4 = [Exchange
                                       objectWithKeyValues:responseObject[@"result"][0][@"data4"]];
            [exchangeInfoArr addObject:exchangeInfo4];//日元
            
            Exchange *exchangeInfo5 = [Exchange
                                       objectWithKeyValues:responseObject[@"result"][0][@"data5"]];
            [exchangeInfoArr addObject:exchangeInfo5];//英镑
            
            Exchange *exchangeInfo6 = [Exchange
                                       objectWithKeyValues:responseObject[@"result"][0][@"data6"]];
            [exchangeInfoArr addObject:exchangeInfo6];//澳大利亚元
            
            Exchange *exchangeInfo7 = [Exchange
                                       objectWithKeyValues:responseObject[@"result"][0][@"data7"]];
            [exchangeInfoArr addObject:exchangeInfo7];//加拿大元
            
            ExchangeTableViewController *exMneu = [[ExchangeTableViewController alloc] init];
            exMneu.exchangeArray = exchangeInfoArr;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:exMneu animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            

            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error:   %@",error.description);
        }];
        
    } else {
        [self alert];
    }
}
#pragma mark - 天气状况点击方法
- (void)weatherClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //replace
        NSString *path = @"http://op.juhe.cn/onebox/weather/query";
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *parameters = @{@"cityname":@"北京",@"key":@"d7535a64b6a89f259762b17766e0acac"};
        
        [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
            if (!error_code) {
                Realtime *realtime = [Realtime objectWithKeyValues:responseObject[@"result"][@"data"][@"realtime"]];
                NSArray *fWeather = [FWeather objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"][@"weather"]];
                Life *life = [Life objectWithKeyValues:responseObject[@"result"][@"data"][@"life"]];
                WeatherNewViewController *weatherMneu = [[WeatherNewViewController alloc] initWithNibName:@"WeatherNewViewController" bundle:nil];
                //传递数组模型
                weatherMneu.realtime = realtime;
                weatherMneu.weather = fWeather;
                weatherMneu.life = life;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:weatherMneu animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }else{
                NSString *title = NSLocalizedString(@"没有找到结果", nil);
                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error:   %@",error.description);
        }];
    } else {
        [self alert];
    }
}
#pragma mark - 星座运势点击方法
- (void)constellationClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        ConstellationSelectedView *select = [[ConstellationSelectedView alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:select animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [self alert];
    }
    
}
#pragma mark - 公交查询点击方法
- (void)busSearchClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        BusSelectTableView *select = [[BusSelectTableView alloc] init];
       
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:select animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [self alert];
    }
}
#pragma mark - 黄历点击方法
- (void)dateClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        DefaultCalendarViewController *date = [[DefaultCalendarViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:date animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [self alert];
    }
}
#pragma mark - 火车票查询点击方法
- (void)trainMenuClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        SelectTableViewController *train = [[SelectTableViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:train animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [self alert];
    }
}
#pragma mark - 商品点击方法
- (void)goodsClick
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if (([wifi currentReachabilityStatus] != NotReachable) || ([conn currentReachabilityStatus] != NotReachable))
    {
        GoodSearchView *good = [[GoodSearchView alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:good animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [self alert];
    }
}

@end
