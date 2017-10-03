//
//  Exchange.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/07/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exchange : NSObject
 /*货币名称*/
@property (nonatomic, strong) NSString *name;
/*现汇买入价*/
@property (nonatomic, strong) NSString *fBuyPri;
 /*现钞买入价*/
@property (nonatomic, strong) NSString *mBuyPri;
 /*现汇卖出价*/
@property (nonatomic, strong) NSString *fSellPri;
 /*现钞卖出价*/
@property (nonatomic, strong) NSString *mSellPri;
/*银行折算价/中间价*/
@property (nonatomic, strong) NSString *bankConversionPri;
/*发布日期*/
@property (nonatomic, strong) NSString *date;
 /*发布时间*/
@property (nonatomic, strong) NSString *time;
@end
