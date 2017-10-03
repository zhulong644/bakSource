//
//  GuaranteeTableView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "GuaranteeTableView.h"

@interface GuaranteeTableView ()

@end

@implementation GuaranteeTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设备详情";
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
    return 13;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ID];
        cell.selectionStyle = YES;
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *text = nil;
    NSString *detailText = nil;
    if (indexPath.row == 0) {
        text = @"设备型号:";
        detailText = self.guarantee.phone_model;
    } else if (indexPath.row == 1) {
        text = @"设备序列号:";
        detailText = self.guarantee.serial_number;
    } else if (indexPath.row == 2) {
        text = @"IMEI号:";
        detailText = self.guarantee.imei_number;
    } else if (indexPath.row == 3) {
        text = @"激活状态:";
        detailText = self.guarantee.active;
    } else if (indexPath.row == 4) {
        text = @"保修状态:";
        detailText = self.guarantee.warranty_status;
    } else if (indexPath.row == 5) {
        text = @"保修到期:";
        detailText = self.guarantee.warranty;
    } else if (indexPath.row == 6) {
        text = @"电话支持到期:";
        detailText = self.guarantee.tele_support;
    } else if (indexPath.row == 7) {
        text = @"电话支持状态:";
        detailText = self.guarantee.tele_support_status;
    } else if (indexPath.row == 8) {
        text = @"生产工厂:";
        detailText = self.guarantee.made_area;
    } else if (indexPath.row == 9) {
        text = @"生产时间开始:";
        detailText = self.guarantee.start_date;
    } else if (indexPath.row == 10) {
        text = @"生产时间结束:";
        detailText = self.guarantee.end_date;
    } else if (indexPath.row == 11) {
        text = @"设备颜色:";
        detailText = self.guarantee.color;
    } else if (indexPath.row == 12) {
        text = @"设备规格:";
        detailText = self.guarantee.size;
    }
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    return cell;
}

@end
