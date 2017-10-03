//
//  CollectionDetailViewController.h
//  YSLTransitionAnimatorDemo
//
//  Created by yamaguchi on 2015/05/20.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodList.h"

@interface CollectionDetailViewController : UIViewController
/**菜谱详细*/
@property (nonatomic, strong) FoodList *foodList;
@end
