//
//  GuaranteeTableView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guarantee.h"

@interface GuaranteeTableView : UITableViewController
/** 保修信息 */
@property (nonatomic, strong) Guarantee *guarantee;
@end
