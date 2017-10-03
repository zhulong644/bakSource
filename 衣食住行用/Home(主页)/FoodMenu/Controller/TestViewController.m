//
//  TestViewController.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/30.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TestViewController.h"
#import "PJRPageScrollingView.h"
#import "PJRItems.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Places" ofType:@"plist"];
    
    NSMutableArray *placeArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i =0 ; i < [placeArray count] ; i++){
        
        NSDictionary *dict = [placeArray objectAtIndex:i];
        PJRItems *item = [[PJRItems alloc] init];
        item.itemTitle = [dict objectForKey:@"placeName"];
        item.itemDesc = [dict objectForKey:@"placeDesc"];
        item.itemImage = [dict objectForKey:@"placeImage"];
        [array addObject:item];
    }
    
    PJRPageScrollingView *pagScrollView = [[PJRPageScrollingView alloc] initWithFrame:self.view.bounds withNumberOfItems:array];
    pagScrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pagScrollView];
    
}

@end
