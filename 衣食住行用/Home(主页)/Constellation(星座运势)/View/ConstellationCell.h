//
//  ConstellationCell.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/8.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstellationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *constellationImageView;
@property (weak, nonatomic) IBOutlet UILabel *costellationTitle;

@property (weak, nonatomic) IBOutlet UILabel *constellationLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
