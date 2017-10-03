//
//  AboutViewController.m
//  便利小助手
//
//  Created by 朱龙 on 15/11/12.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "AboutViewController.h"
#import "IntroductionViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *verLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"关于"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    NSString *text = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    NSString *version = [NSString stringWithFormat:@"便利小助手 版本 %@.0", text];
    self.verLabel.text = version;
    self.myTableView.scrollEnabled =NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    NSString *textLabel = nil;
    NSString *detailTextLabel = nil;
    
    if (indexPath.row == 0) {
        textLabel = @"去评分";

    } else if (indexPath.row == 1) {
        textLabel = @"功能介绍";
    }
    cell.textLabel.text = textLabel;
    cell.detailTextLabel.text = detailTextLabel;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString  * nsStringToOpen = [NSString  stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1058189851&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];

    } else if (indexPath.row == 1) {
        IntroductionViewController *introductionViewController = [[IntroductionViewController alloc] init];
        [self.navigationController pushViewController:introductionViewController animated:YES];
    }
}

@end
