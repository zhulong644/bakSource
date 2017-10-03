//
//  MainFoodTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainFoodTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *titleArray;

@end
