//
//  TapeTwoCell.h
//  便利小助手
//
//  Created by 朱龙 on 16/1/1.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapeTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TwoTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *TwoContentLable;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
