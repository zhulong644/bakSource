//
//  GoodInfo.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/28.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodInfo : NSObject
/** 商品所属商城名称 */
@property (nonatomic, strong) NSString *siteName;
/** 商品图片地址 */
@property (nonatomic, strong) NSString *sppic;
/** 商品地址 */
@property (nonatomic, strong) NSString *spurl;
/** 商品名称 */
@property (nonatomic, strong) NSString *spname;
/** 商品价格 */
@property (nonatomic, strong) NSString *spprice;
@end
