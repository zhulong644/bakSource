//
//  MainFoodTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainFoodTableViewCell.h"

@implementation MainFoodTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MainFoodTableViewCell";
    MainFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainFoodTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
@end
