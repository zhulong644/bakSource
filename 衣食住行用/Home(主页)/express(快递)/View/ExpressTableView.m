//
//  ExpressTableView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "ExpressTableView.h"
#import "ExpressInfo.h"

@interface ExpressTableView ()

@end

@implementation ExpressTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"物流详情"];
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
    return self.expressInfos.count;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = YES;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ExpressInfo *express = self.expressInfos[indexPath.row];
    cell.textLabel.text = express.datetime;
    cell.detailTextLabel.text = express.remark;
    cell.textLabel.textColor = [UIColor brownColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

@end
