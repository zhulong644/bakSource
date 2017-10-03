//
//  Cinema.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/15.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cinema : NSObject
/** 电影院名字 */
@property (nonatomic, copy) NSString *cinemaName;
/** 电影院ID */
@property (nonatomic, copy) NSString *cinemaId;
/** 电影院地址 */
@property (nonatomic, copy) NSString *address;
/** 电影院纬度 */
@property (nonatomic, copy) NSString *latitude;
/** 电影院经度 */
@property (nonatomic, copy) NSString *longitude;
@end
