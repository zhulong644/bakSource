//
//  HuangLiTableView.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/23.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Huang.h"
@interface HuangLiTableView : UITableViewController
/** 黄历 */
@property (nonatomic, strong) Huang *huang;
@end
