//
//  CinemaViewController.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/17.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "CinemaViewController.h"
#import "Cinema.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "CinemaInfo.h"
#import "MovieList.h"
#import "Broadcast.h"
#import "MJExtension.h"
#import "MovieCinemaInfosView.h"
#import "MBProgressHUD.h"
#import "MTConst.h"
#import "AFNetworking.h"

@interface CinemaViewController ()

@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉分隔线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"影院列表"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    return self.cinemas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Cinema *cinema = self.cinemas[indexPath.row];
    cell.textLabel.text = cinema.cinemaName;
    cell.detailTextLabel.text = cinema.address;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    Cinema *cinema = self.cinemas[indexPath.row];
    NSString *Id = cinema.cinemaId;
    //replace
    NSString *path = @"http://v.juhe.cn/movie/cinemas.movies";
    
    NSDictionary *params = @{@"cinemaid": Id,@"key":@"48792b8578139ef988b9b5a2a3c63907"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            CinemaInfo *cinemaInfo = [CinemaInfo objectWithKeyValues:responseObject[@"result"][@"cinema_info"]];
            NSArray *movieList = [MovieList objectArrayWithKeyValuesArray:responseObject[@"result"][@"lists"]];
            MovieCinemaInfosView *movieCinemaInfosView = [[MovieCinemaInfosView alloc] initWithNibName:@"MovieCinemaInfosView" bundle:nil];
            movieCinemaInfosView.cinemaInfo = cinemaInfo;
            movieCinemaInfosView.movieInfoList = movieList;
            [self.navigationController pushViewController:movieCinemaInfosView animated:YES];
            self.hidesBottomBarWhenPushed = YES;
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
//    NSString *path = @"http://v.juhe.cn/movie/cinemas.movies";
//    NSString *api_id = @"42";
//    NSString *method = @"GET";
//    NSString *cinemaId = Id;
//    NSDictionary *param = @{@"cinemaid": cinemaId};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];        
//                            if (!error_code) {
//                                CinemaInfo *cinemaInfo = [CinemaInfo objectWithKeyValues:responseObject[@"result"][@"cinema_info"]];
//                                NSArray *movieList = [MovieList objectArrayWithKeyValuesArray:responseObject[@"result"][@"lists"]];
//                                MovieCinemaInfosView *movieCinemaInfosView = [[MovieCinemaInfosView alloc] initWithNibName:@"MovieCinemaInfosView" bundle:nil];
//                                movieCinemaInfosView.cinemaInfo = cinemaInfo;
//                                movieCinemaInfosView.movieInfoList = movieList;
//                                [self.navigationController pushViewController:movieCinemaInfosView animated:YES];
//                                self.hidesBottomBarWhenPushed = YES;
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
//
//                            
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}
@end
