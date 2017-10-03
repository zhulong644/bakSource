//
//  lifeTableViewController.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/13.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "lifeTableViewController.h"
#import "LInfo.h"
#import "Life.h"

@interface lifeTableViewController ()


@end

@implementation lifeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return @"黎明天气情况";
    
    if (section == 1) return @"白天天气情况";
    
    if (section == 2) return @"夜间天气情况";

    return @"生活指数";
}
#pragma mark - 数据源方法
#pragma mark 一共有多少组（section == 区域\组）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer.textLabel setTextColor:[UIColor blueColor]];
}
#pragma mark 第section组一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.weather.info.dawn.count == 0) {
            return 1;
        }
        return self.weather.info.dawn.count - 1;
    } else if (section == 1) {
        return self.weather.info.day.count - 1;
    } else if (section == 2) {
        return self.weather.info.night.count - 1;
    } else {
        return 6;
    }
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
       return 100;
    }
    return 50;
}
#pragma mark 返回每一行显示的内容(每一行显示怎样的cell)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ID];
        cell.selectionStyle = YES;
    }
    //设置选中样式
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 设置cell显示的文字
    NSString *text = nil;
    NSString *detailText = nil;
    if (indexPath.section == 0) {
        if (self.weather.info.dawn.count != 0) {
            if (indexPath.row == 0) {
                text = @"天气:";
                detailText = self.weather.info.dawn[1];
            } else if (indexPath.row == 1) {
                text = @"温度:";
                detailText = self.weather.info.dawn[2];
            } else if (indexPath.row == 2) {
                text = @"风向:";
                detailText = self.weather.info.dawn[3];
            } else if (indexPath.row == 3) {
                text = @"风力:";
                detailText = self.weather.info.dawn[4];
            } else if (indexPath.row == 4) {
                text = @"实时:";
                detailText = self.weather.info.dawn[5];
            }
        } else {
            text = @"黎明已过";
        }
     
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            text = @"天气:";
            detailText = self.weather.info.day[1];
        } else if (indexPath.row == 1) {
            text = @"温度:";
            detailText = self.weather.info.day[2];
        } else if (indexPath.row == 2) {
            if ([self.weather.info.day[3]  isEqual: @""]) {
                text = @"风向:";
                detailText = @"无";
            } else {
                text = @"风向:";
                detailText = self.weather.info.day[3];
            }
        } else if (indexPath.row == 3) {
            text = @"风力:";
            detailText = self.weather.info.day[4];
        } else if (indexPath.row == 4) {
            text = @"实时:";
            detailText = self.weather.info.day[5];
        }
        
    } else  if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            text = @"天气:";
            detailText = self.weather.info.night[1];
        } else if (indexPath.row == 1) {
            text = @"温度:";
            detailText = self.weather.info.night[2];
        } else if (indexPath.row == 2) {
            if ([self.weather.info.night[3]  isEqual: @""]) {
                text = @"风向:";
                detailText = @"无";
            } else {
                text = @"风向:";
                detailText = self.weather.info.night[3];
            }

        } else if (indexPath.row == 3) {
            text = @"风力:";
            detailText = self.weather.info.night[4];
        } else if (indexPath.row == 4) {
            text = @"实时:";
            detailText = self.weather.info.night[5];
        }
    } else {
        
        if (indexPath.row == 0) {
            text = @"穿衣指数:";
            NSString *chuanyi = [NSString stringWithFormat:@"%@,%@", self.life.info.chuanyi[0], self.life.info.chuanyi[1]];
            detailText = chuanyi;
        } else if (indexPath.row == 1) {
            text = @"感冒指数:";
            NSString *ganmao = [NSString stringWithFormat:@"%@,%@", self.life.info.ganmao[0], self.life.info.ganmao[1]];
            detailText = ganmao;
        } else if (indexPath.row == 2) {
            text = @"空调指数:";
            NSString *kongtiao = [NSString stringWithFormat:@"%@,%@", self.life.info.kongtiao[0], self.life.info.kongtiao[1]];
            detailText = kongtiao;
        } else if (indexPath.row == 3) {
            text = @"洗车指数:";
            NSString *xiche = [NSString stringWithFormat:@"%@,%@", self.life.info.xiche[0], self.life.info.xiche[1]];
            detailText = xiche;
        }  else if (indexPath.row == 4) {
            text = @"运动指数:";
            NSString *yundong = [NSString stringWithFormat:@"%@,%@", self.life.info.yundong[0], self.life.info.yundong[1]];
            detailText = yundong;
        } else {
            text = @"紫外线指数:";
            NSString *ziwaixian = [NSString stringWithFormat:@"%@,%@", self.life.info.ziwaixian[0], self.life.info.ziwaixian[1]];
            detailText = ziwaixian;
        }

    }
    
    cell.textLabel.text = text;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = detailText;
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}
@end
