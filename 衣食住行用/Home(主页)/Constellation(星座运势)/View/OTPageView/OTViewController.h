//
//  OTViewController.h
//  OTPageScrollView
//
//  Created by yechunxiao on 7/22/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayTomorrow.h"

@interface OTViewController : UIViewController
/** 星座名称 */
@property (nonatomic, strong) NSString *name;
/** 今天模型 */
@property (nonatomic, strong) TodayTomorrow *today;
@end

