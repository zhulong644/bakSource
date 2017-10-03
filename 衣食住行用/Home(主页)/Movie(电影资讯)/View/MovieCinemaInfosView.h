//
//  MovieCinemaInfosView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/31.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaInfo.h"

@interface MovieCinemaInfosView : UIViewController
/** 电影院信息模型 */
@property (nonatomic, strong) CinemaInfo *cinemaInfo;
/** 电影列表模型 */
@property (nonatomic, strong) NSArray *movieInfoList;
@end
