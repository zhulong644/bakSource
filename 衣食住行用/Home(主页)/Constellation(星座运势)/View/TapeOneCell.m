//
//  TapeOneCell.m
//  便利小助手
//
//  Created by 朱龙 on 16/1/1.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "TapeOneCell.h"

@implementation TapeOneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TapeOneCell";
    TapeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TapeOneCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
