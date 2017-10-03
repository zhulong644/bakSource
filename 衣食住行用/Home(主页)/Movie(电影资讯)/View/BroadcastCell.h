//
//  BroadcastCell.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/17.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Broadcast.h"

@interface BroadcastCell : UITableViewCell
/** 排期模型 */
@property (nonatomic, strong) Broadcast *broadcast;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
