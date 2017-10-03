//
//  MainTableTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/24.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainTableTableViewCell.h"

@implementation MainTableTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MainTableTableViewCell";
    MainTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainTableTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
