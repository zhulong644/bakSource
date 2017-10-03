//
//  MainMovieTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainMovieTableViewCell.h"

@interface MainMovieTableViewCell()
/** 电影列表 */
@property (nonatomic, strong) NSArray *myMovieList;
@end
@implementation MainMovieTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MainMovieTableViewCell";
    MainMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainMovieTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setMovieList:(NSArray *)movieList
{
    _movieList = movieList;
    

}
@end
