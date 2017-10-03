//
//  WeatherDetailedViewController.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/12.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "WeatherDetailedViewController.h"
#import "FWeather.h"
#import "lifeTableViewController.h"

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface WeatherDetailedViewController ()
/** 详细列表 */
@property (nonatomic, strong) lifeTableViewController *lifeTableView;
@end

@implementation WeatherDetailedViewController

//详细列表
- (lifeTableViewController *)lifeTableView
{
    if (!_lifeTableView) {
        lifeTableViewController *life = [[lifeTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        life.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        
        [self.view addSubview:life.view];
        [self addChildViewController:life];
        self.lifeTableView = life;
        
    }
    return _lifeTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"生活指数"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    [self lifeTableView];

}
- (void)setWeather:(FWeather *)weather
{
    self.lifeTableView.weather = weather;
}
- (void)setLife:(Life *)life
{
    self.lifeTableView.life = life;
}
@end
