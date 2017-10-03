//
//  ExchangeCellTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/07/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exchange.h"

@interface ExchangeCellTableViewCell : UITableViewCell

@property (nonatomic, strong) Exchange *exchange;

@property (weak, nonatomic) IBOutlet UIImageView *exImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
