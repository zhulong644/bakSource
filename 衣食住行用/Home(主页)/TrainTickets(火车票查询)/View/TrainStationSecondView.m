//
//  TrainStationSecondView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainStationSecondView.h"
#import "MJExtension.h"
#import "Price.h"
@interface TrainStationSecondView ()

@end

@implementation TrainStationSecondView

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = self.trainNumber.train_no;
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        //不可点击
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //去掉箭头
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    NSArray *priceArr = [Price objectArrayWithKeyValuesArray:self.trainNumber.price_list];
    NSString *textLabel = nil;
    NSString *detailTextLabel = nil;
    
    if (indexPath.row == 0) {
        textLabel = @"始发站: ";
        detailTextLabel = self.trainNumber.start_station;
    } else if (indexPath.row == 1) {
        textLabel = @"终点站: ";
        detailTextLabel = self.trainNumber.end_station;
    } else if (indexPath.row == 2) {
        textLabel = @"出发时间: ";
        detailTextLabel = self.trainNumber.start_time;
    } else if (indexPath.row == 3) {
        textLabel = @"到达时间: ";
        detailTextLabel = self.trainNumber.end_time;
    } else if (indexPath.row == 4) {
        textLabel = @"全程时间: ";
        detailTextLabel = self.trainNumber.run_time;
    } else if (indexPath.row == 5) {
        Price *price = priceArr[0];
        NSString *priceInfo = [NSString stringWithFormat:@"%@: ", price.price_type];
        textLabel = priceInfo;
        NSString *pricePrice = [NSString stringWithFormat:@"%@元", price.price];
        detailTextLabel = pricePrice;
    } else if (indexPath.row == 6) {
        Price *price = priceArr[1];
        NSString *priceInfo = [NSString stringWithFormat:@"%@: ", price.price_type];
        textLabel = priceInfo;
        NSString *pricePrice = [NSString stringWithFormat:@"%@元", price.price];
        detailTextLabel = pricePrice;
    }
    cell.textLabel.text = textLabel;
    cell.detailTextLabel.text = detailTextLabel;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    
    return cell;
}

@end
