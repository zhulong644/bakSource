//
//  Express.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Express : NSObject
/** 快递公司 */
@property (nonatomic, copy) NSString *com;
/** 快递公司编号 */
@property (nonatomic, copy) NSString *no;
@end
