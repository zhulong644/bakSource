//
//  BusStationDetailedView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/25.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "BusStationDetailedView.h"
#import "Station.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "BusLine.h"
#import "MJExtension.h"
#import "BusLineDetailedView.h"

#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH_4s 320.0f
#define CELL_CONTENT_WIDTH_6 375.0f
#define CELL_CONTENT_WIDTH_6p 414.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface BusStationDetailedView ()
@property (nonatomic, strong) NSArray *busStations;
@end

@implementation BusStationDetailedView

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉分隔线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"公交一览"];
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

- (void)setBusStation:(NSArray *)busStation
{
    self.busStations = busStation;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 

    return self.busStations.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *detailText = nil;
    if (indexPath.section == 0) {
       Station *station = self.busStations[indexPath.row];
        detailText = station.name;
    }

    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), 20000.0f);
    
    if (width == 320) {
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), 20000.0f);
    } else if (width == 375) {
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_6 - (CELL_CONTENT_MARGIN *2), 20000.0f);
    } else if (width == 414){
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_6p - (CELL_CONTENT_MARGIN *2), 20000.0f);
    }
    
    CGSize size = [detailText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height =MAX(size.height, 44.0f);
    return height + (CELL_CONTENT_MARGIN *2);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UILabel *label =nil;
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = YES;
        //不可点击
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:FONT_SIZE];
        [label setNumberOfLines:0];
        label.textColor = [UIColor blackColor];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setTag:1];
        //去掉边框
        //        [[label layer]setBorderWidth:2.0f];
        [[cell contentView]addSubview:label];
    }
    // 设置cell显示的文字
    NSString *detailText = nil;
    if (indexPath.section == 0) {
        Station *station = self.busStations[indexPath.row];
        detailText = station.name;
    }
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), 20000.0f);
    
    if (width == 320) {
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), 20000.0f);
    } else if (width == 375) {
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_6 - (CELL_CONTENT_MARGIN *2), 20000.0f);
    } else if (width == 414){
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_6p - (CELL_CONTENT_MARGIN *2), 20000.0f);
    }
    
    CGSize size = [detailText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    [label setText:detailText];
    if (width == 320) {
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), MAX(size.height, 44.0f))];
    } else if (width == 375) {
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH_6 - (CELL_CONTENT_MARGIN *2), MAX(size.height, 44.0f))];
    } else if (width == 414){
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH_6p - (CELL_CONTENT_MARGIN *2), MAX(size.height, 44.0f))];
    }
    return cell;
}


@end

