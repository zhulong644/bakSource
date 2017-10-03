//
//  LInfo.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/13.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LInfo : NSObject
/** 穿衣指数 */
@property (nonatomic, copy) NSArray *chuanyi;
/** 感冒指数 */
@property (nonatomic, copy) NSArray *ganmao;
/** 空调指数 */
@property (nonatomic, copy) NSArray *kongtiao;
/** 污染指数 */
@property (nonatomic, copy) NSArray *wuran;
/** 洗车指数 */
@property (nonatomic, copy) NSArray *xiche;
/** 运动指数 */
@property (nonatomic, copy) NSArray *yundong;
/** 紫外线指数 */
@property (nonatomic, copy) NSArray *ziwaixian;
@end
