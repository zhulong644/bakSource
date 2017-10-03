//
//  MovieListViewController.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/18.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "MovieListViewController.h"
#import "UIImageView+WebCache.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "Cinema.h"
#import "MJExtension.h"
#import "CinemaViewController.h"
#import "MBProgressHUD.h"
#import "MTConst.h"
#import "AFNetworking.h"

@interface MovieListViewController ()
/** 电影标题 */
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
/** 电影图片 */
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
/** 电影评分 */
@property (weak, nonatomic) IBOutlet UILabel *movieRating;
/** 电影国家 */
@property (weak, nonatomic) IBOutlet UILabel *movieCountry;
/** 电影语言 */
@property (weak, nonatomic) IBOutlet UILabel *movieLanguage;
/** 电影类型 */
@property (weak, nonatomic) IBOutlet UILabel *movieType;
/** 上映时间 */
@property (weak, nonatomic) IBOutlet UILabel *movieTime;
/** 电影片长 */
@property (weak, nonatomic) IBOutlet UILabel *movieRunTime;
/** 电影导演 */
@property (weak, nonatomic) IBOutlet UILabel *movieDirector;
/** 电影编剧 */
@property (weak, nonatomic) IBOutlet UILabel *movieWriter;
/** 电影主演 */
@property (weak, nonatomic) IBOutlet UILabel *movieActors;
/** 电影简介 */
@property (weak, nonatomic) IBOutlet UITextView *moviePlot_simple;
/** 买票按钮 */

@property (weak, nonatomic) IBOutlet UIButton *ticketButton;

/** 电影详细模型 */
@property (nonatomic, strong) MovieInfo *movieInfos;
/** 电影Id */
@property (nonatomic, strong) NSString *movieIds;
/** 城市Id */
@property (nonatomic, strong) NSString *cityIds;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //     1.设置左右按钮
    NSString *cityText = @"影院";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:cityText style:0 target:self action:@selector(buttonClick)];
    //设置电影标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:self.movieInfos.title];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    //设置电影海报
    [self.movieImage sd_setImageWithURL:[NSURL URLWithString:self.movieInfos.poster]];
    //设置电影评分
    if ([self.movieInfos.rating  isEqual: @"-1"]) {
        NSString *rating = [NSString stringWithFormat:@"评分: 暂无"];
        self.movieRating.text = rating;
    } else if (self.movieInfos.rating == NULL) {
        NSString *rating = [NSString stringWithFormat:@"评分: 暂无"];
        self.movieRating.text = rating;
    } else {
        NSString *rating = [NSString stringWithFormat:@"评分: %@",self.movieInfos.rating];
        self.movieRating.text = rating;
    }
    //设置电影产地
    NSString *film_locations = [NSString stringWithFormat:@"国家: %@",self.movieInfos.film_locations];
    self.movieCountry.text = film_locations;
    //设置电影语言
    NSString *language = [NSString stringWithFormat:@"语言: %@",self.movieInfos.language];
    self.movieLanguage.text = language;
    //设置电影类型
    NSString *genres = [NSString stringWithFormat:@"类型: %@",self.movieInfos.genres];
    self.movieType.text = genres;
    //设置电影上映时间
    NSString *release_date = [NSString stringWithFormat:@"上映: %@",self.movieInfos.release_date];
    self.movieTime.text = release_date;
    //设置电影时长
    if (self.movieInfos.runtime == NULL) {
        NSString *runtime = [NSString stringWithFormat:@"片长: -"];
        self.movieRunTime.text = runtime;
    } else {
        NSString *runtime = [NSString stringWithFormat:@"片长: %@",self.movieInfos.runtime];
        self.movieRunTime.text = runtime;
    }
    //设置电影导演
    NSString *directors = [NSString stringWithFormat:@"导演: %@",self.movieInfos.directors];
    self.movieDirector.text = directors;
    //设置电影编剧
    NSString *writers = [NSString stringWithFormat:@"编剧: %@",self.movieInfos.writers];
    self.movieWriter.text = writers;
    //设置电影主演
    NSString *actors = [NSString stringWithFormat:@"主演: %@", self.movieInfos.actors];
    self.movieActors.text = actors;
    //设置电影简介
    NSString *plot_simple = [NSString stringWithFormat:@"简介: %@",self.movieInfos.plot_simple];
    self.moviePlot_simple.text = plot_simple;
    //注册点击方法
    [self.ticketButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setMovieInfo:(MovieInfo *)movieInfo
{
    self.movieInfos = movieInfo;
}
- (void)setMovieId:(NSString *)movieId
{
    self.movieIds = movieId;
}
- (void)setCityId:(NSString *)cityId
{
    self.cityIds = cityId;
}
- (void)buttonClick
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //replace
    NSString *path = @"http://v.juhe.cn/movie/movies.cinemas";
    
    NSDictionary *params = @{@"cityid": self.cityIds, @"movieid": self.movieIds,@"key":@"48792b8578139ef988b9b5a2a3c63907"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            NSArray *cinemas = [Cinema objectArrayWithKeyValuesArray:responseObject[@"result"]];
            CinemaViewController *cinemaMneu = [[CinemaViewController alloc] init];
            cinemaMneu.cinemas = cinemas;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cinemaMneu animated:YES];
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
//    NSString *path = @"http://v.juhe.cn/movie/movies.cinemas";
//    NSString *api_id = @"42";
//    NSString *method = @"GET";
//    NSString *moveId = self.movieIds;
//    NSDictionary *param = @{@"cityid": self.cityIds, @"movieid": moveId};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                                NSArray *cinemas = [Cinema objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                                CinemaViewController *cinemaMneu = [[CinemaViewController alloc] init];
//                                cinemaMneu.cinemas = cinemas;
//                                self.hidesBottomBarWhenPushed = YES;
//                                [self.navigationController pushViewController:cinemaMneu animated:YES];
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
