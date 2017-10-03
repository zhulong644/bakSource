//
//  GoodFirstView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/28.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "GoodFirstView.h"
#import "GoodInfo.h"
#import "UIImageView+WebCache.h"
#import "GoodCell.h"
#import "GoodsInfoView.h"

@interface GoodFirstView ()

@end

@implementation GoodFirstView

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"价格一览"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //去掉分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.goodLists.count;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GoodCell *cell = [GoodCell cellWithTableView:tableView];
    GoodInfo *goodInfo = self.goodLists[indexPath.row];
    cell.goodInfo = goodInfo;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodInfo *goodInfo = self.goodLists[indexPath.row];
    GoodsInfoView *goodsInfoView = [[GoodsInfoView alloc] initWithNibName:@"GoodsInfoView" bundle:nil];
    goodsInfoView.goodInfo = goodInfo;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodsInfoView animated:YES];
}
@end
