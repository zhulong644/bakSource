//
//  OTViewController.m
//  OTPageScrollView
//
//  Created by akron on 7/22/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import "OTViewController.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "TodayTomorrow.h"
#import "MJExtension.h"

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface OTViewController ()
/** 详细列表 */
//@property (nonatomic, strong) ConstellationDetailedView *conView;
@end

@implementation OTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
  
    }
    return self;
}
//- (ConstellationDetailedView *)conView
//{
//    if (!_conView) {
//        ConstellationDetailedView *conView = [[ConstellationDetailedView alloc] initWithNibName:@"ConstellationDetailedView" bundle:nil];
//        self.conView = conView;
//        
//    }
//    return _conView;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.today.name;
//    self.conView.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//     self.conView.today = self.today;
//    [self.view addSubview:self.conView.view];
//    [self addChildViewController:self.conView];

}
@end

