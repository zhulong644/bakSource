//
//  MovieViewController.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/15.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "MovieViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "CityList.h"
#import "MovieCell.h"
#import "Movie.h"
#import "MovieInfo.h"
#import "MovieListViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "City.h"
#import "MTConst.h"
#import "CitySelectedView.h"
#import "MTConst.h"
#import "AFNetworking.h"
#define ScreenWidth self.collectionView.bounds.size.width
#define ScreenHeight self.collectionView.bounds.size.height

@interface MovieViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** 城市Id */
@property (nonatomic, strong) NSString *cityId;

@end

@implementation MovieViewController

static NSString * const reuseIdentifier = @"movie";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的大小
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat inset = 0;
    if (width == 320) {
        layout.itemSize =  CGSizeMake(90,120);
        inset = ([UIScreen mainScreen].bounds.size.width-270) / 4;
        
    } else if (width == 375) {
        layout.itemSize =  CGSizeMake(105,140);
        inset = ([UIScreen mainScreen].bounds.size.width-315) / 4;
        
    } else {
        layout.itemSize =  CGSizeMake(120,160);
        inset = ([UIScreen mainScreen].bounds.size.width-360) / 4;
    }

    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
         layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);//设置其边界

    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"正在上映"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
//     1.设置左右按钮
    NSString *cityText = @"北京";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:cityText style:0 target:self action:@selector(rightMenu)];
    //collection相关
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MovieCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // 监听城市改变
    [MTNotificationCenter addObserver:self selector:@selector(cityDidChange:) name:MTCityDidChangeNotification object:nil];
}
#pragma mark - 监听通知
- (void)cityDidChange:(NSNotification *)notification
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *cityId = notification.userInfo[MTSelectCityId];
    NSString *cityName = notification.userInfo[MTSelectCityName];
    self.cityId = cityId;
    // 1.更换顶部区域item的文字
    self.navigationItem.rightBarButtonItem.title = cityName;
    // 2.刷新表格数据
    //replace
    NSString *path = @"http://v.juhe.cn/movie/movies.cinemas";
    
    NSDictionary *params = @{@"cityid":cityId,@"key":@"48792b8578139ef988b9b5a2a3c63907"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *movies = [Movie objectArrayWithKeyValuesArray:responseObject[@"result"]];
        self.movies = movies;
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    NSString *path = @"http://v.juhe.cn/movie/movies.today";
//    NSString *api_id = @"42";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"cityid":cityId};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            NSArray *movies = [Movie objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                            self.movies = movies;
//                            [self.collectionView reloadData];
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

    
}
- (void)rightMenu
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //replace
    NSString *path = @"http://v.juhe.cn/movie/citys";
    
    NSDictionary *params = @{@"key":@"48792b8578139ef988b9b5a2a3c63907"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *citys = [City objectArrayWithKeyValuesArray:responseObject[@"result"]];
        CitySelectedView *citysView = [[CitySelectedView alloc] init];
        citysView.citys = citys;
        UINavigationController *ui = [[UINavigationController alloc] initWithRootViewController:citysView];
        [self presentViewController:ui animated: YES completion:nil];
        [MBProgressHUD hideHUDForView:self.view animated:YES];    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    
    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    NSString *path = @"http://v.juhe.cn/movie/citys";
//    NSString *api_id = @"42";
//    NSString *method = @"GET";
//    NSDictionary *param = nil;
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            NSArray *citys = [City objectArrayWithKeyValuesArray:responseObject[@"result"]];
//
//                            CitySelectedView *citysView = [[CitySelectedView alloc] init];
//                            citysView.citys = citys;
//                            UINavigationController *ui = [[UINavigationController alloc] initWithRootViewController:citysView];
//                            [self presentViewController:ui animated: YES completion:nil];
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Movie *movie = self.movies[indexPath.item];
    cell.movie = movie;
 
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //小菊花
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    Movie *movie = self.movies[indexPath.item];
    NSString *movieName = movie.movieName;
    NSString *movieId = movie.movieId;
    //replace
    NSString *path = @"http://v.juhe.cn/movie/index";
    
    NSDictionary *params = @{@"title":movieName,@"key":@"48792b8578139ef988b9b5a2a3c63907"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            //获得返回的对象数组
            NSArray *movieInfo = [MovieInfo objectArrayWithKeyValuesArray:responseObject[@"result"]];
            MovieListViewController *movieInfoMneu = [[MovieListViewController alloc] initWithNibName:@"MovieListViewController" bundle:nil];
            movieInfoMneu.movieInfo = movieInfo[0];
            movieInfoMneu.movieId = movieId;
            if (self.cityId == NULL) {
                movieInfoMneu.cityId = @"2";
            } else {
                movieInfoMneu.cityId = self.cityId;
            }
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:movieInfoMneu animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
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
//                                if (self.cityId == NULL) {
//                                    movieInfoMneu.cityId = @"2";
//                                } else {
//                                    movieInfoMneu.cityId = self.cityId;
//                                }
//                                self.hidesBottomBarWhenPushed = YES;
//                                [self.navigationController pushViewController:movieInfoMneu animated:YES];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
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
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            }
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}

@end
