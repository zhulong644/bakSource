//
//  ExchangeTableViewController.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/07/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "ExchangeTableViewController.h"
#import "ExchangeCellTableViewCell.h"

@interface ExchangeTableViewController ()

@end

@implementation ExchangeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"人民币牌价"];
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
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 161;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return @"美元";
    
    if (section == 1) return @"欧元";
    
    if (section == 2) return @"港币";
    
    if (section == 3) return @"日元";
    
    if (section == 4) return @"英镑";
    
    if (section == 5) return @"澳大利亚元";
    
    if (section == 6) return @"加拿大元";
    
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExchangeCellTableViewCell *cell = [ExchangeCellTableViewCell cellWithTableView:tableView];
    
    cell.exchange = self.exchangeArray[indexPath.section];
    if (indexPath.section == 0) {
        cell.exImage.image = [UIImage imageNamed:@"usa"];
    } else if (indexPath.section == 1) {
        cell.exImage.image = [UIImage imageNamed:@"EU.jpg"];
    } else if (indexPath.section == 2) {
        cell.exImage.image = [UIImage imageNamed:@"hongkong"];
    } else if (indexPath.section == 3) {
        cell.exImage.image = [UIImage imageNamed:@"japan"];
    } else if (indexPath.section == 4) {
        cell.exImage.image = [UIImage imageNamed:@"uk"];
    } else if (indexPath.section == 5) {
        cell.exImage.image = [UIImage imageNamed:@"australia"];
    } else if (indexPath.section == 6) {
        cell.exImage.image = [UIImage imageNamed:@"canada"];
    }
    return cell;
}


@end

