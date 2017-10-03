//
//  CinemaInfo.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/15.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinemaInfo : NSObject
/** 电影院ID */
@property (nonatomic, copy) NSString *id;
/** 电影院名字 */
@property (nonatomic, copy) NSString *name;
/** 电影院所在城市 */
@property (nonatomic, copy) NSString *city;
/** 电影院电话 */
@property (nonatomic, copy) NSString *telephone;
/** 电影院地址 */
@property (nonatomic, copy) NSString *address;
@end
