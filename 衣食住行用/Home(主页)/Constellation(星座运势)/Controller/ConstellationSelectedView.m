//
//  ConstellationSelectedView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/3.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "ConstellationSelectedView.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "TodayTomorrow.h"
#import "WeekNextWeek.h"
#import "MJExtension.h"
#import "ConstellationCell.h"
#import "MBProgressHUD.h"
#import "MTConst.h"
#import "ConstellationViewController.h"
#import "AFNetworking.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ConstellationSelectedView ()
@property (nonatomic, strong) TodayTomorrow *today;
@property (nonatomic, strong) TodayTomorrow *tomorrow;
@property (nonatomic, strong) WeekNextWeek *week;
@property (nonatomic, strong) WeekNextWeek *nextWeek;
/**蒙版*/
@property (nonatomic, strong) UIView *barBoard;
@end

@implementation ConstellationSelectedView

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"选择星座"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //去掉分隔线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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

    return 12;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConstellationCell *cell = [ConstellationCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if (indexPath.row == 0) {
       cell.costellationTitle.text = @"水瓶座";
       cell.constellationLabel.text = @"1.20 - 2.18";
       cell.constellationImageView.image = [UIImage imageNamed:@"shuiping"];
    } else if (indexPath.row == 1) {
        cell.costellationTitle.text = @"双鱼座";
        cell.constellationLabel.text = @"2.19 - 3.20";
        cell.constellationImageView.image = [UIImage imageNamed:@"shuangyu"];
    } else if (indexPath.row == 2) {
        cell.costellationTitle.text = @"白羊座";
        cell.constellationLabel.text = @"3.21 - 4.19";
        cell.constellationImageView.image = [UIImage imageNamed:@"baiyang"];
    } else if (indexPath.row == 3) {
        cell.costellationTitle.text = @"金牛座";
        cell.constellationLabel.text = @"4.20 - 5.20";
        cell.constellationImageView.image = [UIImage imageNamed:@"jinniu"];
    } else if (indexPath.row == 4) {
        cell.costellationTitle.text = @"双子座";
        cell.constellationLabel.text = @"5.21 - 6.21";
        cell.constellationImageView.image = [UIImage imageNamed:@"shuangzi"];
    } else if (indexPath.row == 5) {
        cell.costellationTitle.text = @"巨蟹座 ";
        cell.constellationLabel.text = @"6.22 - 7.22";
        cell.constellationImageView.image = [UIImage imageNamed:@"juxie"];
    } else if (indexPath.row == 6) {
        cell.costellationTitle.text = @"狮子座";
        cell.constellationLabel.text = @"7.23 - 8.22";
        cell.constellationImageView.image = [UIImage imageNamed:@"shizi"];
    } else if (indexPath.row == 7) {
        cell.costellationTitle.text = @"处女座";
        cell.constellationLabel.text = @"8.23 - 9.22";
        cell.constellationImageView.image = [UIImage imageNamed:@"chunv"];
    } else if (indexPath.row == 8) {
        cell.costellationTitle.text = @"天秤座";
        cell.constellationLabel.text = @"9.23 - 10.22";
        cell.constellationImageView.image = [UIImage imageNamed:@"tiancheng"];
    } else if (indexPath.row == 9) {
        cell.costellationTitle.text = @"天蝎座";
        cell.constellationLabel.text = @"10.24 - 11.22";
        cell.constellationImageView.image = [UIImage imageNamed:@"tianxie"];
    } else if (indexPath.row == 10) {
        cell.costellationTitle.text = @"射手座";
        cell.constellationLabel.text = @"11.23 - 12.21";
        cell.constellationImageView.image = [UIImage imageNamed:@"sheshou"];
    } else if (indexPath.row == 11) {
        cell.costellationTitle.text = @"摩羯座";
        cell.constellationLabel.text = @"12.22 - 1.19";
        cell.constellationImageView.image = [UIImage imageNamed:@"mojie"];
    }
     cell.constellationLabel.textColor = [UIColor lightGrayColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ConstellationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *name = cell.costellationTitle.text;
   
    //replace
    NSString *path = @"http://web.juhe.cn:8080/constellation/getAll";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *parameters = @{@"consName":name, @"type":@"today",@"key":@"0e093949b2f515063fad11e430add1b3"};
    //今天
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        TodayTomorrow *today = [TodayTomorrow objectWithKeyValues:responseObject];
        self.today = today;
        NSString *path2 = @"http://web.juhe.cn:8080/constellation/getAll";
        NSDictionary *parameters2 = @{@"consName":name, @"type":@"tomorrow",@"key":@"0e093949b2f515063fad11e430add1b3"};
        //明天
        [manager GET:path2 parameters:parameters2 success:^(NSURLSessionDataTask *task, id responseObject) {
            TodayTomorrow *tomorrow = [TodayTomorrow objectWithKeyValues:responseObject];
            self.tomorrow = tomorrow;
            //本周
            NSString *path3 = @"http://web.juhe.cn:8080/constellation/getAll";
            NSDictionary *parameters3 = @{@"consName":name, @"type":@"week",@"key":@"0e093949b2f515063fad11e430add1b3"};
            
            [manager GET:path3 parameters:parameters3 success:^(NSURLSessionDataTask *task, id responseObject) {
                WeekNextWeek *week = [WeekNextWeek objectWithKeyValues:responseObject];
                self.week = week;
                //下周
                NSString *path4 = @"http://web.juhe.cn:8080/constellation/getAll";
                
                NSDictionary *parameters4 = @{@"consName":name, @"type":@"nextweek",@"key":@"0e093949b2f515063fad11e430add1b3"};
                
                [manager GET:path4 parameters:parameters4 success:^(NSURLSessionDataTask *task, id responseObject) {
                    WeekNextWeek *nextWeek = [WeekNextWeek objectWithKeyValues:responseObject];
                    self.nextWeek = nextWeek;
                    
                    ConstellationViewController *contell = [[ConstellationViewController alloc] init];
                    contell.today = self.today;
                    contell.tomorrow = self.tomorrow;
                    contell.week = self.week;
                    contell.nextWeek = self.nextWeek;
                    contell.name = name;
                    
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:contell animated:YES];
//                    self.hidesBottomBarWhenPushed = NO;
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
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

@end
