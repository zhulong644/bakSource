//
//  JuheTool.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/20.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JuheTool : NSObject
+ (id)responseObjectWithPath:(NSString *)path api_id:(NSString *)api_id method:(NSString *)method param:(NSDictionary *)param;
@end
