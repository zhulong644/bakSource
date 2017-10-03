//
//  TapeTwoCell.m
//  便利小助手
//
//  Created by 朱龙 on 16/1/1.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "TapeTwoCell.h"

@implementation TapeTwoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TapeTwoCell";
    TapeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TapeTwoCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
