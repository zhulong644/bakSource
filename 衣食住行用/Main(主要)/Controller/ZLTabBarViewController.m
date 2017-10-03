//
//  ZLTabBarViewController.m
//  FJCIT
//
//  Created by 朱龙 on 15/8/27.
//  Copyright (c) 2015年 朱龙. All rights reserved.
//

#import "ZLTabBarViewController.h"
#import "ZLNavigationController.h"

@interface ZLTabBarViewController ()

@end

@implementation ZLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
//    FoodViewController *food = [[FoodViewController alloc] init];
//    [self addChildVc:food title:@"食" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    UITabBarController *use = [[UITabBarController alloc] init];
    [self addChildVc:use title:@"用" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    UITabBarController *clothe = [[UITabBarController alloc] init];
    [self addChildVc:clothe title:@"衣" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    UITabBarController *live = [[UITabBarController alloc] init];
    [self addChildVc:live title:@"住" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    UITabBarController *walk = [[UITabBarController alloc] init];
    [self addChildVc:walk title:@"行" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置子控制器的文字和图片
    //    childVc.tabBarItem.title = title;
    //    childVc.navigationItem.title = title;
    
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    childVc.view.backgroundColor = [UIColor whiteColor];
    
    //先给外面传进来的小控制器包装成一个导航控制器
    ZLNavigationController *nav = [[ZLNavigationController alloc] initWithRootViewController:childVc];
//    [nav.navigationBar.b lt_setBackgroundColor:[UIColor redColor]];
    //添加子控制器
    [self addChildViewController:nav];
}


@end
