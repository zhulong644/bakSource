//
//  MovieList.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/15.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieList : NSObject
/** 电影ID */
@property (nonatomic, copy) NSString *movieId;
/** 电影名字 */
@property (nonatomic, copy) NSString *movieName;
/** 电影图片url */
@property (nonatomic, copy) NSString *pic_url;
/** 电影放映厅 */
@property (nonatomic, strong) NSArray *broadcast;
@end
