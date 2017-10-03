//
//  MainMovieTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainMovieView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 电影列表 */
@property (nonatomic, strong) NSArray *movieList;

@end
