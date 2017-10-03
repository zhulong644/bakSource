//
//  TrainNumberSecondView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainNumberSecondView.h"

@interface TrainNumberSecondView ()

@end

@implementation TrainNumberSecondView

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:self.trainInfo.name];
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

    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *textLabel = nil;
    NSString *detailTextLabel = nil;

        if (indexPath.row == 0) {
            textLabel = @"站点名称:";
            detailTextLabel = self.stationList.station_name;

        } else if (indexPath.row == 1) {
            textLabel = @"到达时间:";
            detailTextLabel = self.stationList.arrived_time;
      
        } else if (indexPath.row == 2) {
            textLabel = @"发车时间:";
            detailTextLabel = self.stationList.leave_time;
 
        } else if (indexPath.row == 3) {
            textLabel = @"停留时间:";
            detailTextLabel = self.stationList.stay;

        } else if (indexPath.row == 4) {
            textLabel = @"里程:";
            detailTextLabel = self.stationList.mileage;
            
        } else if (indexPath.row == 5) {
            textLabel = @"二等座:";
            detailTextLabel = self.stationList.ssoftSeat;

        } else if (indexPath.row == 6) {
            textLabel = @"一等座:";
            detailTextLabel = self.stationList.fsoftSeat;
            
        } else if (indexPath.row == 7) {
            textLabel = @"硬座:";
            detailTextLabel = self.stationList.hardSead;
            
        } else if (indexPath.row == 8) {
            textLabel = @"软座:";
            detailTextLabel = self.stationList.softSeat;
            
        } else if (indexPath.row == 9) {
            textLabel = @"硬卧:";
            detailTextLabel = self.stationList.hardSleep;
            
        } else if (indexPath.row == 10) {
            textLabel = @"软卧:";
            detailTextLabel = self.stationList.softSleep;
            
        } else if (indexPath.row == 11) {
            textLabel = @"无座:";
            detailTextLabel = self.stationList.wuzuo;
            
        } else if (indexPath.row == 12) {
            textLabel = @"商务座";
            detailTextLabel = self.stationList.swz;
            
        }  else if (indexPath.row == 13) {
            textLabel = @"特等座:";
            detailTextLabel = self.stationList.tdz;
            
        }  else if (indexPath.row == 14) {
            textLabel = @"高级软卧:";
            detailTextLabel = self.stationList.gjrw;
            
        }
    cell.textLabel.text = textLabel;
    cell.detailTextLabel.text = detailTextLabel;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    return cell;

    
    return cell;
}


@end
