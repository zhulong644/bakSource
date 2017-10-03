//
//  BusSelectTableView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/7.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "BusSelectTableView.h"
#import "BusLineView.h"
#import "BusStationView.h"

@interface BusSelectTableView ()

@end

@implementation BusSelectTableView

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
        text = @"公交路线查询";
    } else {
        text = @"公交站台查询";
    }
    cell.textLabel.text = text;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        [self busLineSearchClick];
    } else if (indexPath.row == 1) {
        [self busStationSearchClick];
    }
}
#pragma mark - 公交路线点击方法
- (void)busLineSearchClick
{
    BusLineView *bus = [[BusLineView alloc] initWithNibName:@"BusLineView" bundle:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bus animated:YES];
}
#pragma mark - 公交站点击方法
- (void)busStationSearchClick
{
    BusStationView *bus = [[BusStationView alloc] initWithNibName:@"BusStationView" bundle:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bus animated:YES];
}



@end
