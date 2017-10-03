//
//  ExComSelectView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "ExComSelectView.h"
#import "Express.h"
#import "MTConst.h"
#import "ExpressCell.h"

@interface ExComSelectView ()

@end

@implementation ExComSelectView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"承运公司"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    //     1.设置左右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:0 target:self action:@selector(rightMenu)];
    [self setExtraCellLineHidden:self.tableView];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
- (void)rightMenu
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.expressComs.count;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpressCell *cell = [ExpressCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    Express *express = self.expressComs[indexPath.row];
    if (indexPath.row == 0) {
        cell.expressImageView.image = [UIImage imageNamed:@"sf"];
    } else if (indexPath.row == 1) {
        cell.expressImageView.image = [UIImage imageNamed:@"shentong"];
    } else if (indexPath.row == 2) {
        cell.expressImageView.image = [UIImage imageNamed:@"yuantong"];
    } else if (indexPath.row == 3) {
        cell.expressImageView.image = [UIImage imageNamed:@"yunda"];
    } else if (indexPath.row == 4) {
        cell.expressImageView.image = [UIImage imageNamed:@"tiantian"];
    } else if (indexPath.row == 5) {
        cell.expressImageView.image = [UIImage imageNamed:@"ems"];
    } else if (indexPath.row == 6) {
        cell.expressImageView.image = [UIImage imageNamed:@"zhongtong"];
    } else if (indexPath.row == 7) {
        cell.expressImageView.image = [UIImage imageNamed:@"huitong"];
    } else if (indexPath.row == 8) {
        cell.expressImageView.image = [UIImage imageNamed:@"quanfeng"];
    } else if (indexPath.row == 9) {
        cell.expressImageView.image = [UIImage imageNamed:@"bangde"];
    }
    cell.expressTitleLabel.text = express.com;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Express *express = self.expressComs[indexPath.row];
    // 发出通知
    [MTNotificationCenter postNotificationName:MTCityDidChangeNotification object:nil userInfo:@{MTSelectExpress : express.com, MTSelectExpressNo : express.no}];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
