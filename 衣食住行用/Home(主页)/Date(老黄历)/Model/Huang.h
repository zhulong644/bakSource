//
//  Huang.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/23.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Huang : NSObject
/** 阳历 */
@property (nonatomic, copy) NSString *yangli;
/** 阴历 */
@property (nonatomic, copy) NSString *yinli;
/** 五行 */
@property (nonatomic, copy) NSString *wuxing;
/** 冲煞 */
@property (nonatomic, copy) NSString *chongsha;
/** 拜祭 */
@property (nonatomic, copy) NSString *baiji;
/** 祭神 */
@property (nonatomic, copy) NSString *jishen;
/** 宜 */
@property (nonatomic, copy) NSString *yi;
/** 凶神 */
@property (nonatomic, copy) NSString *xiongshen;
/** 忌 */
@property (nonatomic, copy) NSString *ji;
@end
