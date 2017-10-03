//
//  BusAllLineDetailedView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/25.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusLine.h"

@interface BusAllLineDetailedView : UITableViewController
/** 公交信息 */
@property (nonatomic, strong) BusLine *busLine;
@end
