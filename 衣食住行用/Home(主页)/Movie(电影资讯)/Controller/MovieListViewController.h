//
//  MovieListViewController.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/18.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface MovieListViewController : UIViewController
/** 电影详细模型 */
@property (nonatomic, strong) MovieInfo *movieInfo;
/** 电影Id */
@property (nonatomic, strong) NSString *movieId;
/** 城市Id */
@property (nonatomic, strong) NSString *cityId;
@end
