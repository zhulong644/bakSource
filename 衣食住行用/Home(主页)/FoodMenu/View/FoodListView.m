//
//  FoodListView.m
//  衣食住行用
//
//  Created by 朱龙 on 15/9/30.
//  Copyright (c) 2015年 朱龙. All rights reserved.
//

#import "FoodListView.h"
#import "UIView+Extension.h"

@implementation FoodListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setContent:(UIView *)content
{
    _content = content;
    self.content.x = 0;
    self.content.y = 0;
    [self addSubview:content];
}
- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
    
}


@end
