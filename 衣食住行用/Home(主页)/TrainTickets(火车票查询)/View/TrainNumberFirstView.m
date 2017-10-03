//
//  TrainNumberFirstView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainNumberFirstView.h"
#import "StationList.h"
#import "TrainNumberSecondView.h"

@interface TrainNumberFirstView ()

@end

@implementation TrainNumberFirstView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:self.trainInfo.name];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //去掉分隔线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 5;
    } else {
        return self.stationList.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
//    }
    NSString *textLabel = nil;
    NSString *detailTextLabel = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            textLabel = @"起点站:";
            detailTextLabel = self.trainInfo.start;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 1) {
            textLabel = @"终点站:";
            detailTextLabel = self.trainInfo.end;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 2) {
            textLabel = @"发车时间:";
            detailTextLabel = self.trainInfo.starttime;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 3) {
            textLabel = @"到达时间:";
            detailTextLabel = self.trainInfo.endtime;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 4) {
            textLabel = @"里程:";
            detailTextLabel = self.trainInfo.mileage;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

    } else if (indexPath.section == 1) {
        StationList *stationList = self.stationList[indexPath.row];
        textLabel = [NSString stringWithFormat:@"第%@站:", stationList.train_id];
        detailTextLabel = stationList.station_name;
    }
    cell.textLabel.text = textLabel;
    cell.detailTextLabel.text = detailTextLabel;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
      return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        StationList *stationList = self.stationList[indexPath.row];
        TrainNumberSecondView *trainNumberSecondView = [[TrainNumberSecondView alloc] init];
        trainNumberSecondView.stationList = stationList;
        trainNumberSecondView.trainInfo = self.trainInfo;
        
        [self.navigationController pushViewController:trainNumberSecondView animated:YES];
    }
}

@end
