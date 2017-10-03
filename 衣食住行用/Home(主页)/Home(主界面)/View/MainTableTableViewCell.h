//
//  MainTableTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/24.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
