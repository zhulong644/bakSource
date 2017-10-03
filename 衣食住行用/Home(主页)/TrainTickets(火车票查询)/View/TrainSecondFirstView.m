//
//  TrainSecondFirstView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainSecondFirstView.h"

@interface TrainSecondFirstView ()

@end

@implementation TrainSecondFirstView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:self.trainTicket.train_no];
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
    return 20;
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
        textLabel = @"车次始发:";
        detailTextLabel = self.trainTicket.start_station_name;
        
    } else if (indexPath.row == 1) {
        textLabel = @"车次终点:";
        detailTextLabel = self.trainTicket.end_station_name;
        
    } else if (indexPath.row == 2) {
        textLabel = @"出发站:";
        detailTextLabel = self.trainTicket.from_station_name;
        
    } else if (indexPath.row == 3) {
        textLabel = @"到达站:";
        detailTextLabel = self.trainTicket.to_station_name;
        
    } else if (indexPath.row == 4) {
        textLabel = @"出发时间:";
        detailTextLabel = self.trainTicket.start_time;
        
    } else if (indexPath.row == 5) {
        textLabel = @"到达时间:";
        detailTextLabel = self.trainTicket.arrive_time;
        
    } else if (indexPath.row == 6) {
        textLabel = @"车次类型:";
        detailTextLabel = self.trainTicket.train_class_name;
        
    } else if (indexPath.row == 7) {
        textLabel = @"历时天数:";
        detailTextLabel = self.trainTicket.day_difference;
        
    } else if (indexPath.row == 8) {
        textLabel = @"总历时:";
        detailTextLabel = self.trainTicket.lishi;
        
    } else if (indexPath.row == 9) {
        textLabel = @"高级软卧:";
        detailTextLabel = self.trainTicket.gr_num;
        
    } else if (indexPath.row == 10) {
        textLabel = @"其他:";
        detailTextLabel = self.trainTicket.qt_num;
        
    } else if (indexPath.row == 11) {
        textLabel = @"软卧:";
        detailTextLabel = self.trainTicket.rw_num;
        
    } else if (indexPath.row == 12) {
        textLabel = @"软座";
        detailTextLabel = self.trainTicket.rz_num;
        
    }  else if (indexPath.row == 13) {
        textLabel = @"特等座:";
        detailTextLabel = self.trainTicket.tz_num;
        
    }  else if (indexPath.row == 14) {
        textLabel = @"无座:";
        detailTextLabel = self.trainTicket.wz_num;
        
    } else if (indexPath.row == 15) {
        textLabel = @"硬卧:";
        detailTextLabel = self.trainTicket.yw_num;
        
    } else if (indexPath.row == 16) {
        textLabel = @"硬座:";
        detailTextLabel = self.trainTicket.yz_num;
        
    }  else if (indexPath.row == 17) {
        textLabel = @"二等座:";
        detailTextLabel = self.trainTicket.ze_num;
        
    } else if (indexPath.row == 18) {
        textLabel = @"一等座:";
        detailTextLabel = self.trainTicket.zy_num;
        
    } else if (indexPath.row == 19) {
        textLabel = @"商务座:";
        detailTextLabel = self.trainTicket.swz_num;
        
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
