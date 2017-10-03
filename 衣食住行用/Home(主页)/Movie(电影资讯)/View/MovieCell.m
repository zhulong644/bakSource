//
//  MovieCell.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/16.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+WebCache.h"

#define ScreenWidth self.bounds.size.width
#define ScreenHeight self.bounds.size.height

@interface MovieCell()
/** 电影图片 */
@property (nonatomic, strong) UIImageView *movieView;
/** 电影标题 */
@property (nonatomic, strong) UILabel *movieTitle;
@end

@implementation MovieCell

- (UIImageView *)movieView
{
    if (!_movieView) {
        UIImageView *ui = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        ui.backgroundColor = [UIColor grayColor];
        self.movieView = ui;
        [self addSubview:ui];
    }
    return _movieView;
}
- (void)setMovie:(Movie *)movie
{
    [self.movieView sd_setImageWithURL:[NSURL URLWithString:movie.pic_url]];
}

@end
