//
//  TrainStationFirstView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/26.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainStationFirstView.h"
#import "TrainNumber.h"
#import "TrainStationSecondView.h"

@interface TrainStationFirstView ()

@end

@implementation TrainStationFirstView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"列车一览"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //去掉分隔线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.TrainNumberArray.count;
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
    TrainNumber *trainNumber = self.TrainNumberArray[indexPath.row];
    NSString *trainInfo = [NSString stringWithFormat:@"%@ %@ 列车 %@ 发车", trainNumber.train_no, trainNumber.train_type, trainNumber.start_time];
    cell.textLabel.text = trainInfo;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainNumber *trainNumber = self.TrainNumberArray[indexPath.row];
    TrainStationSecondView *trainStationSecondView = [[TrainStationSecondView alloc] init];
    trainStationSecondView.trainNumber = trainNumber;
    
    [self.navigationController pushViewController:trainStationSecondView animated:YES];
    
}

@end
