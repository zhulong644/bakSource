//
//  MovieInfo.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/16.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject
/** 电影标题 */
@property (nonatomic, copy) NSString *title;
/** 电影图片 */
@property (nonatomic, copy) NSString *poster;
/** 电影评分 */
@property (nonatomic, copy) NSString *rating;
/** 电影国家 */
@property (nonatomic, copy) NSString *film_locations;
/** 电影语言 */
@property (nonatomic, copy) NSString *language;
/** 电影类型 */
@property (nonatomic, copy) NSString *genres;
/** 上映时间 */
@property (nonatomic, copy) NSString *release_date;
/** 电影片长 */
@property (nonatomic, copy) NSString *runtime;
/** 电影导演 */
@property (nonatomic, copy) NSString *directors;
/** 电影编剧 */
@property (nonatomic, copy) NSString *writers;
/** 电影主演 */
@property (nonatomic, copy) NSString *actors;

@property (nonatomic, copy) NSString *plot_simple;
@end
