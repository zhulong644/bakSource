//
//  MainConstellationTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainConstellationTableViewCell.h"
#import "LDProgressView.h"

@interface MainConstellationTableViewCell()

@property (nonatomic, strong) TodayTomorrow *myToday;
@property (weak, nonatomic) IBOutlet UILabel *collName;

@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UIView *threeView;

@property (weak, nonatomic) IBOutlet UIView *fourView;

@property (weak, nonatomic) IBOutlet UIView *fiveView;

@property (nonatomic, strong) NSString *Pwidth;

@end
@implementation MainConstellationTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MainConstellationTableViewCell";
    MainConstellationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainConstellationTableViewCell" owner:self options:nil] lastObject];
    }
       return cell;
}

- (void)setToday:(TodayTomorrow *)today
{
    _myToday = today;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    if (width == 320) {
        self.Pwidth = @"229";
    } else if (width == 375) {
        self.Pwidth = @"284";
    } else {
        self.Pwidth = @"323";
    }
    
    self.collName.text = _myToday.name;
    //设置健康进度条
    LDProgressView *progressView2 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth floatValue], 23)];
    progressView2.color = [UIColor colorWithRed:0.10f green:0.73f blue:0.00f alpha:1.00f];
    
    NSString *healty01 = [_myToday.health stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *healty02 = [NSString stringWithFormat:@"0.%@",healty01];
    
    progressView2.progress = [healty02 floatValue];
    
    progressView2.flat = @YES;
    [self.firstView addSubview:progressView2];
    //设置财运进度条
    LDProgressView *progressView3 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth floatValue], 23)];
    progressView3.color = [UIColor colorWithRed:0.73f green:0.73f blue:0.10f alpha:1.00f];
    
    NSString *money01 = [_myToday.money stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *money02 = [NSString stringWithFormat:@"0.%@",money01];
    progressView3.progress = [money02 floatValue];

    
    progressView3.flat = @YES;
    [self.secondView addSubview:progressView3];
    //设置爱情进度条
    LDProgressView *progressView4 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth floatValue], 23)];
    progressView4.color = [UIColor colorWithRed:0.73f green:0.10f blue:0.00f alpha:1.00f];
    
    NSString *love01 = [_myToday.love stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *love02 = [NSString stringWithFormat:@"0.%@",love01];
    progressView4.progress = [love02 floatValue];
    
    progressView4.flat = @YES;
    [self.threeView addSubview:progressView4];
    //设置工作进度条
    LDProgressView *progressView5 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth floatValue], 23)];
    progressView5.color = [UIColor colorWithRed:0.10f green:0.10f blue:0.73f alpha:1.00f];
    
    NSString *work01 = [_myToday.work stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *work02 = [NSString stringWithFormat:@"0.%@",work01];
    progressView5.progress = [work02 floatValue];
    
    progressView5.flat = @YES;
    [self.fourView addSubview:progressView5];
    //设置综合进度条
    LDProgressView *progressView6 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth floatValue], 23)];
    progressView6.color = [UIColor blackColor];
    
    NSString *all01 = [_myToday.all stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *all02 = [NSString stringWithFormat:@"0.%@",all01];
    progressView6.progress = [all02 floatValue];
    
    progressView6.flat = @YES;
    [self.fiveView addSubview:progressView6];
    

}

@end
