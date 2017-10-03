//
//  WeatherNewViewController.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/27.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "WeatherNewViewController.h"
#import "FWeather.h"
#import "WeatherDetailedViewController.h"
#import "Life.h"
#import "Realtime.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "MTConst.h"
#import "MainWeatherTableViewCell.h"
#import "WeekCellTableViewCell.h"
#import "AFNetworking.h"
#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface WeatherNewViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *citySearch;

@property (weak, nonatomic) IBOutlet UITableView *weekInfoTable;
/**搜索栏蒙版*/
@property (nonatomic, strong) UIImageView *searchFoodBarBoard;
/**搜索的菜字*/
@property (nonatomic, copy) NSString *searchText;

@end

@implementation WeatherNewViewController

- (UIImageView *)searchFoodBarBoard
{
    if (!_searchFoodBarBoard) {
        self.searchFoodBarBoard = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight)];
        self.searchFoodBarBoard.backgroundColor = [UIColor whiteColor];
    }
    return _searchFoodBarBoard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"天气信息"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;

    [self setExtraCellLineHidden:self.weekInfoTable];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark - UISearchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchFoodBarBoard.alpha = 1;
    self.searchFoodBarBoard.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.searchFoodBarBoard addGestureRecognizer:singleTouch];
    [self.view addSubview:self.searchFoodBarBoard];
}
- (void)dismissKeyboard
{
    [self.citySearch resignFirstResponder];
    self.searchFoodBarBoard.alpha = 0;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchText = searchText;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //replace
    NSString *path = @"http://op.juhe.cn/onebox/weather/query";
    
    NSDictionary *params = @{@"cityname":self.searchText,@"key":@"d7535a64b6a89f259762b17766e0acac"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            Realtime *realtime = [Realtime objectWithKeyValues:responseObject[@"result"][@"data"][@"realtime"]];
            NSArray *fWeather = [FWeather objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"][@"weather"]];
            Life *life = [Life objectWithKeyValues:responseObject[@"result"][@"data"][@"life"]];
            
            //传递数组模型
            self.weather = fWeather;
            self.life = life;
            self.realtime = realtime;
            [self.weekInfoTable reloadData];
            self.searchFoodBarBoard.alpha = 0;
            [self.citySearch resignFirstResponder];
            self.citySearch.text = nil;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } else {
            NSString *title = NSLocalizedString(@"没有找到结果", nil);
            NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];

    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    
//    NSString *path = @"http://op.juhe.cn/onebox/weather/query";
//    NSString *api_id = @"73";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"cityname":self.searchText};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                                Realtime *realtime = [Realtime objectWithKeyValues:responseObject[@"result"][@"data"][@"realtime"]];
//                                NSArray *fWeather = [FWeather objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"][@"weather"]];
//                                Life *life = [Life objectWithKeyValues:responseObject[@"result"][@"data"][@"life"]];
//
//                                //传递数组模型
//                                self.weather = fWeather;
//                                self.life = life;
//                                self.realtime = realtime;
//                                [self.weekInfoTable reloadData];
//                                self.searchFoodBarBoard.alpha = 0;
//                                [self.citySearch resignFirstResponder];
//                                self.citySearch.text = nil;
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            } else {
//                                NSString *title = NSLocalizedString(@"没有找到结果", nil);
//                                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//                                
//                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//                                
//                                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                                }];
//                                [alertController addAction:otherAction];
//                                [self presentViewController:alertController animated:YES completion:nil];
//                            }
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weather.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 146;
    }
    
    return 100;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer.textLabel setTextColor:[UIColor blackColor]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MainWeatherTableViewCell *cell = [MainWeatherTableViewCell cellWithTableView:tableView];
        Realtime *realtime = self.realtime;
        cell.realtime = realtime;
        return cell;
    }
    WeekCellTableViewCell *cell = [WeekCellTableViewCell cellWithTableView:tableView];
    cell.weather = self.weather[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FWeather *fWeather = self.weather[indexPath.row];
    WeatherDetailedViewController *wdv = [[WeatherDetailedViewController alloc] init];
    wdv.weather = fWeather;
    wdv.life = self.life;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wdv animated:YES];
}


@end
