//
//  BroadcastCell.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/17.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "BroadcastCell.h"

@interface BroadcastCell ()
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 类型 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
/** 厅号 */
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation BroadcastCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"broadcast";
    BroadcastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BroadcastCell" owner:self options:nil] lastObject];
    }
    return cell;
}
- (void)setBroadcast:(Broadcast *)broadcast
{
    self.timeLabel.text = broadcast.time;
    self.typeLabel.text = broadcast.type;
    self.roomLabel.text = broadcast.hall;
    NSString *price = [NSString stringWithFormat:@"%@￥",broadcast.price];
    self.priceLabel.text = price;
}
@end
