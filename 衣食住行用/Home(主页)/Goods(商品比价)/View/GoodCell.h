//
//  GoodCell.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/7.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodInfo.h"

@interface GoodCell : UITableViewCell

@property (nonatomic, strong) GoodInfo *goodInfo;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
