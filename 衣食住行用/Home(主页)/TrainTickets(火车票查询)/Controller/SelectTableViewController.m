//
//  SelectTableViewController.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/7.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "SelectTableViewController.h"
#import "TrainStationView.h"
#import "TrainNumberView.h"
#import "TrainTicketView.h"

@interface SelectTableViewController ()

@end

@implementation SelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"查询项目"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    // 设置cell显示的文字
    NSString *text = nil;
    if (indexPath.row == 0) {
        text = @"站到站查询";
    } else if (indexPath.row == 1) {
        text = @"列车车次查询";
    }
    cell.textLabel.text = text;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  self.hidesBottomBarWhenPushed = YES;
    if (indexPath.row == 0) {
        [self trainStationSearchButtonClick];
    } else if (indexPath.row == 1) {
        [self trainNumberSearchButtonClick];
    }
}
#pragma mark - 站到站点击方法
- (void)trainStationSearchButtonClick
{
    TrainStationView *train = [[TrainStationView alloc] initWithNibName:@"TrainStationView" bundle:nil];
    [self.navigationController pushViewController:train animated:YES];
}
#pragma mark - 车次击方法
- (void)trainNumberSearchButtonClick
{
    TrainNumberView *train = [[TrainNumberView alloc] initWithNibName:@"TrainNumberView" bundle:nil];
    [self.navigationController pushViewController:train animated:YES];
}
#pragma mark - 实时余票点击方法
//- (void)trainTicketSearchButtonClick
//{
//    TrainTicketView *train = [[TrainTicketView alloc] initWithNibName:@"TrainTicketView" bundle:nil];
//    [self.navigationController pushViewController:train animated:YES];
//}


@end
