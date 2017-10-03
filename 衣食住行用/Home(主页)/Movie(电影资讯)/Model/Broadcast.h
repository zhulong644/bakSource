//
//  Broadcast.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/15.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Broadcast : NSObject
/** 厅号 */
@property (nonatomic, copy) NSString *hall;
/** 语言 */
@property (nonatomic, copy) NSString *language;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** ticket_url */
@property (nonatomic, copy) NSString *ticket_url;
/** 时间 */
@property (nonatomic, copy) NSString *time;
/** 类型 */
@property (nonatomic, copy) NSString *type;
@end
