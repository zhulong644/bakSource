//
//  MainIntefaceTableViewController.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainIntefaceTableViewController.h"
#import "Reachability.h"
#import "MainWeatherTableViewCell.h"
#import "MainDateTableViewCell.h"
#import "MainConstellationTableViewCell.h"
#import "MainFoodTableViewCell.h"
#import "MainMovieTableViewCell.h"
#import "DefaultCalendarViewController.h"
#import "SDCycleScrollView.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"
#import "MovieList.h"
#import "FoodList.h"
#import "CollectionDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MJExtension.h"
#import "MTConst.h"
#import "WeekNextWeek.h"
#import "ConstellationViewController.h"
#import "MovieInfo.h"
#import "MovieListViewController.h"
#import "MBProgressHUD.h"
#import "FoodType.h"
#import "ExpandTableViewController.h"
#import "ConstellationSelectedView.h"
#import "MovieViewController.h"
#import "AFNetworking.h"
#import "WeatherNewViewController.h"
@interface MainIntefaceTableViewController ()<SDCycleScrollViewDelegate,OTPageScrollViewDataSource,OTPageScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) OTPageView *myOTPageView;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) MainFoodTableViewCell *foodCell;
@property (nonatomic, strong) MainConstellationTableViewCell *conCell;
@property (nonatomic, strong) MainWeatherTableViewCell *weatherCell;
@property (nonatomic, strong) MainDateTableViewCell *dateCell;
@property (nonatomic, strong) MainMovieTableViewCell *movieCell;

@property (nonatomic, strong) TodayTomorrow *today;
@property (nonatomic, strong) TodayTomorrow *tomorrow;
@property (nonatomic, strong) WeekNextWeek *week;
@property (nonatomic, strong) WeekNextWeek *nextWeek;
/**蒙版*/
@property (nonatomic, strong) UIView *barBoard;
@end

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@implementation MainIntefaceTableViewController

- (UIView *)barBoard
{
    if (!_barBoard) {
        self.barBoard = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
        self.barBoard.backgroundColor = [UIColor darkGrayColor];
        self.barBoard.alpha = 0.0;
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        [window addSubview:self.barBoard];
    }
    return _barBoard;
}

- (MainMovieTableViewCell *)movieCell
{
    if (!_movieCell) {
        MainMovieTableViewCell *movieCell = [MainMovieTableViewCell cellWithTableView:self.myTableView];
        [movieCell.mainMovieView addSubview:self.myOTPageView];
        self.movieCell = movieCell;
    }
    return _movieCell;
}
- (MainDateTableViewCell *)dateCell
{
    if (!_dateCell) {
        MainDateTableViewCell *dateCell = [MainDateTableViewCell cellWithTableView:self.myTableView];
        dateCell.huangli = self.huangli;
        self.dateCell = dateCell;
    }
    return _dateCell;
}
- (MainWeatherTableViewCell *)weatherCell
{
    if (!_weatherCell) {
        MainWeatherTableViewCell *cell = [MainWeatherTableViewCell cellWithTableView:self.myTableView];
        Realtime *realtime = self.realtime;
        cell.realtime = realtime;
        self.weatherCell = cell;
    }
    return _weatherCell;
}
- (MainFoodTableViewCell *)foodCell
{
    if (!_foodCell) {
        MainFoodTableViewCell *cell = [MainFoodTableViewCell cellWithTableView:self.myTableView];
        
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 414, 280)delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cell.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        [cell.mainScrollView addSubview:cycleScrollView];
        
        NSArray *imageGroup = [self.imageArray copy];
        cycleScrollView.imageURLStringsGroup = imageGroup;
        NSArray *titleGroup = [self.titleArray copy];
        cycleScrollView.titlesGroup = titleGroup;
        self.foodCell = cell;
    }
    return _foodCell;
}
- (MainConstellationTableViewCell *)conCell
{
    if (!_conCell) {
        MainConstellationTableViewCell *conCell = [MainConstellationTableViewCell cellWithTableView:self.myTableView];
        conCell.today = self.conToday;
        self.conCell = conCell;
    }
    return  _conCell;
}
- (OTPageView *)myOTPageView
{
    if (!_myOTPageView) {
        CGRect pScrollViewRect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 160);
        OTPageView *PScrollView = [[OTPageView alloc] initWithFrame: pScrollViewRect];
        PScrollView.pageScrollView.dataSource = self;
        PScrollView.pageScrollView.delegate = self;
        PScrollView.pageScrollView.padding = 50;
        PScrollView.pageScrollView.leftRightOffset = 0;
        PScrollView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -150)/2, 30, 150, 100);
        PScrollView.backgroundColor = [UIColor whiteColor];
        
        [PScrollView.pageScrollView reloadData];
        
        self.myOTPageView = PScrollView;
    }
    
    return _myOTPageView;
}
- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        self.imageArray = arr;
    }
    return _imageArray;
}
- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        self.titleArray = arr;
    }
    return _titleArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"首页"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;

    for (FoodList *list in self.foodList) {
        NSArray *imgArray = list.albums;
        NSString *imageURL = imgArray[0];
        [self.imageArray addObject:imageURL];
        [self.titleArray addObject:list.title];
    }
    

}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CollectionDetailViewController *vc = [[CollectionDetailViewController alloc]init];
    vc.foodList = self.foodList[index];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - Table view data source
#pragma mark - 设置头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //获得nib视图数组
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"foodHeader" owner:self options:nil];
    if (section == 0) {//得到食物的HeaderView
        UIView *tmpCustomView = [nib objectAtIndex:0];
        UIButton *firstButton = [tmpCustomView viewWithTag:2];
        [firstButton addTarget:self action:@selector(foodClick)  forControlEvents:UIControlEventTouchUpInside];
        return tmpCustomView;
    } else if (section == 1) {//得到天气的HeaderView
        UIView *weatherView = [nib objectAtIndex:1];
        return weatherView;
    } else if (section == 2) {//得到黄历的HeaderView
        UIView *dateView = [nib objectAtIndex:2];
        return dateView;
    } else if (section == 3) {//得到星座的HeaderView
        UIView *collView = [nib objectAtIndex:3];
        UIButton *firstButton = [collView viewWithTag:2];
        [firstButton addTarget:self action:@selector(collClick)  forControlEvents:UIControlEventTouchUpInside];
        return collView;
    } else if (section == 4) {//得到电影的HeaderView
        UIView *movieView = [nib objectAtIndex:4];
        UIButton *firstButton = [movieView viewWithTag:2];
        [firstButton addTarget:self action:@selector(movieClick)  forControlEvents:UIControlEventTouchUpInside];
        return movieView;
    }
  
    return nil;
}
#pragma mark - 更多美食
- (void)foodClick
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

}
#pragma mark - 其他星座
- (void)collClick
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
#pragma mark - 更多影片
- (void)movieClick
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
            if (!error_code) {
                NSArray *movies = [Movie objectArrayWithKeyValuesArray:responseObject[@"result"]];
                MovieViewController *movieMneu = [[MovieViewController alloc] init];
                movieMneu.movies = movies;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:movieMneu animated:YES];
                //                                    self.hidesBottomBarWhenPushed = NO;
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 280;
    } else if (indexPath.section == 1) {
        return 146;
    } else if (indexPath.section == 2) {
        return 166;
    } else if (indexPath.section == 3) {
        return 160;
    }
    return 160;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.foodCell;
    } else if (indexPath.section == 1) {
        return self.weatherCell;
    } else if (indexPath.section == 2) {
        return self.dateCell;
    } else if (indexPath.section == 3) {
        return self.conCell;
    } else if (indexPath.section == 4) {
        return self.movieCell;
    }
    return nil;
}

- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return self.movieList.count;
}
//控件中每个电影宽高的布局
- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 140)];
    cell.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    MovieList *movieList = self.movieList[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:movieList.pic_url]];
//    imageView.image = [UIImage imageNamed:@"cloudy4"];
    [cell addSubview:imageView];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.barBoard.alpha = 1;
    [MBProgressHUD showHUDAddedTo:self.barBoard animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    #pragma mark - 天气状况点击方法
    if (indexPath.section == 1) {
        WeatherNewViewController *weatherMneu = [[WeatherNewViewController alloc] initWithNibName:@"WeatherNewViewController" bundle:nil];
        //传递数组模型
        weatherMneu.realtime = self.realtime;
        weatherMneu.weather = self.weather;
        weatherMneu.life = self.life;
       
        [self.navigationController pushViewController:weatherMneu animated:YES];
        [MBProgressHUD hideHUDForView:self.barBoard animated:YES];
        self.barBoard.alpha = 0.0;
    #pragma mark - 黄历点击方法
    } else if (indexPath.section == 2) {
        DefaultCalendarViewController *date = [[DefaultCalendarViewController alloc] init];
        [self.navigationController pushViewController:date animated:YES];
        [MBProgressHUD hideHUDForView:self.barBoard animated:YES];
        self.barBoard.alpha = 0.0;
    } else if (indexPath.section == 3) {
        [self didConstellation];
    }
    self.hidesBottomBarWhenPushed = NO;
}
- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return CGSizeMake(100, 140);
}
#pragma mark - 电影资讯点击方法
- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index
{
    self.barBoard.alpha = 1;
    [MBProgressHUD showHUDAddedTo:self.barBoard animated:YES];

    Movie *movie = self.movieList[index];
    NSString *movieName = movie.movieName;
    NSString *movieId = movie.movieId;
    //replace
    NSString *path = @"http://v.juhe.cn/movie/index";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"title":movieName,@"key":@"48792b8578139ef988b9b5a2a3c63907"};
    
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            //获得返回的对象数组
            NSArray *movieInfo = [MovieInfo objectArrayWithKeyValuesArray:responseObject[@"result"]];
            MovieListViewController *movieInfoMneu = [[MovieListViewController alloc] initWithNibName:@"MovieListViewController" bundle:nil];
            movieInfoMneu.movieInfo = movieInfo[0];
            movieInfoMneu.movieId = movieId;
            //                                if (self.cityId == NULL) {
            movieInfoMneu.cityId = @"2";
            //                                } else {
            //                                    movieInfoMneu.cityId = self.cityId;
            //                                }
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:movieInfoMneu animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            [MBProgressHUD hideHUDForView:self.barBoard animated:YES];
            self.barBoard.alpha = 0.0;
        }else{
            NSString *title = NSLocalizedString(@"系统维护中请稍后再试。", nil);
            NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            //                                [MBProgressHUD hideHUDForView:self.view animated:YES];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    
//    //    ***************** LIFE ***************
//    //    /*传递参数*/
//    NSString *path = @"http://v.juhe.cn/movie/index";
//    NSString *api_id = @"42";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"title":movieName};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                                //获得返回的对象数组
//                                NSArray *movieInfo = [MovieInfo objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                                MovieListViewController *movieInfoMneu = [[MovieListViewController alloc] initWithNibName:@"MovieListViewController" bundle:nil];
//                                movieInfoMneu.movieInfo = movieInfo[0];
//                                movieInfoMneu.movieId = movieId;
////                                if (self.cityId == NULL) {
//                                    movieInfoMneu.cityId = @"2";
////                                } else {
////                                    movieInfoMneu.cityId = self.cityId;
////                                }
//                                self.hidesBottomBarWhenPushed = YES;
//                                [self.navigationController pushViewController:movieInfoMneu animated:YES];
//                                self.hidesBottomBarWhenPushed = NO;
//                                 [MBProgressHUD hideHUDForView:self.barBoard animated:YES];
//                                self.barBoard.alpha = 0.0;
//                            }else{
//                                NSString *title = NSLocalizedString(@"系统维护中请稍后再试。", nil);
//                                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//                                
//                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//                                
//                                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                                }];
//                                [alertController addAction:otherAction];
//                                [self presentViewController:alertController animated:YES completion:nil];
////                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            }
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];
}

#pragma mark - 星座运势点击方法
- (void)didConstellation
{
    self.barBoard.alpha = 1;
    [MBProgressHUD showHUDAddedTo:self.barBoard animated:YES];
   
    //replace
    NSString *path = @"http://web.juhe.cn:8080/constellation/getAll";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *parameters = @{@"consName":self.conToday.name, @"type":@"today",@"key":@"0e093949b2f515063fad11e430add1b3"};
    //今天
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        TodayTomorrow *today = [TodayTomorrow objectWithKeyValues:responseObject];
        self.today = today;
        NSString *path2 = @"http://web.juhe.cn:8080/constellation/getAll";
        NSDictionary *parameters2 = @{@"consName":self.conToday.name, @"type":@"tomorrow",@"key":@"0e093949b2f515063fad11e430add1b3"};
        //明天
        [manager GET:path2 parameters:parameters2 success:^(NSURLSessionDataTask *task, id responseObject) {
            TodayTomorrow *tomorrow = [TodayTomorrow objectWithKeyValues:responseObject];
            self.tomorrow = tomorrow;
            //本周
            NSString *path3 = @"http://web.juhe.cn:8080/constellation/getAll";
            NSDictionary *parameters3 = @{@"consName":self.conToday.name, @"type":@"week",@"key":@"0e093949b2f515063fad11e430add1b3"};
            
            [manager GET:path3 parameters:parameters3 success:^(NSURLSessionDataTask *task, id responseObject) {
                WeekNextWeek *week = [WeekNextWeek objectWithKeyValues:responseObject];
                self.week = week;
                //下周
                NSString *path4 = @"http://web.juhe.cn:8080/constellation/getAll";
                
                NSDictionary *parameters4 = @{@"consName":self.conToday.name, @"type":@"nextweek",@"key":@"0e093949b2f515063fad11e430add1b3"};
                
                [manager GET:path4 parameters:parameters4 success:^(NSURLSessionDataTask *task, id responseObject) {
                    WeekNextWeek *nextWeek = [WeekNextWeek objectWithKeyValues:responseObject];
                    self.nextWeek = nextWeek;
                    
                    ConstellationViewController *contell = [[ConstellationViewController alloc] init];
                    contell.today = self.today;
                    contell.tomorrow = self.tomorrow;
                    contell.week = self.week;
                    contell.nextWeek = self.nextWeek;
                    contell.name = self.conToday.name;
                    
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:contell animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    [MBProgressHUD hideHUDForView:self.barBoard animated:YES];
                    self.barBoard.alpha = 0.0;
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"error:   %@",error.description);
                }];
               
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"error:   %@",error.description);
            }];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error:   %@",error.description);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
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
@end
