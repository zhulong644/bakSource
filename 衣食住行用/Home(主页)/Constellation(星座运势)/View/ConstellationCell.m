//
//  ConstellationCell.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/8.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "ConstellationCell.h"

@implementation ConstellationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ConstellationCell";
    ConstellationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConstellationCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
