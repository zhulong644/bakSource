//
//  ExpressCell.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/8.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "ExpressCell.h"

@implementation ExpressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ExpressCell";
    ExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExpressCell" owner:self options:nil] lastObject];
    }
    return cell;
}
@end
