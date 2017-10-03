//
//  TapeOneCell.h
//  便利小助手
//
//  Created by 朱龙 on 16/1/1.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapeOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *OneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *OneContentLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
