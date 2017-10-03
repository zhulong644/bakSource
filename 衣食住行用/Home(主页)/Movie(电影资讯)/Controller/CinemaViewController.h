//
//  CinemaViewController.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/17.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"

@interface CinemaViewController : UITableViewController
/** 电影院模型 */
@property (nonatomic, strong) NSArray *cinemas;
@end
