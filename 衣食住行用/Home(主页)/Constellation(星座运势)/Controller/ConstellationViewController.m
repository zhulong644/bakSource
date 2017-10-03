//
//  ConstellationViewController.m
//  便利小助手
//
//  Created by 朱龙 on 16/1/1.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "ConstellationViewController.h"
#import "ConstellationCell.h"
#import "TapeOneCell.h"
#import "TapeTwoCell.h"
#import "LDProgressView.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface ConstellationViewController ()
/** 今天模型 */
@property (nonatomic, strong) TodayTomorrow *todays;
/** 明天模型 */
@property (nonatomic, strong) TodayTomorrow *tomorrows;
/** 本周模型 */
@property (nonatomic, strong) WeekNextWeek *weeks;
/** 下周模型 */
@property (nonatomic, strong) WeekNextWeek *nextWeeks;

@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSString *Pwidth;
/** 速配星座 */
@property (nonatomic, strong) TapeOneCell *QFriendCell;
/** 速配数字 */
@property (nonatomic, strong) TapeOneCell *numberCell;
/** 速配颜色 */
@property (nonatomic, strong) TapeOneCell *colorCell;
/** 健康指数 */
@property (nonatomic, strong) TapeTwoCell *healthCell;
/** 财运指数 */
@property (nonatomic, strong) TapeTwoCell *moneyCell;
/** 爱情指数 */
@property (nonatomic, strong) TapeTwoCell *loveCell;
/** 工作指数 */
@property (nonatomic, strong) TapeTwoCell *workCell;
/** 综合指数 */
@property (nonatomic, strong) TapeTwoCell *allCell;
/** 综合评价 */
@property (nonatomic, strong) TapeOneCell *summaryCell;

/** 明天速配星座 */
@property (nonatomic, strong) TapeOneCell *tomorrowQFriendCell;
/** 明天速配数字 */
@property (nonatomic, strong) TapeOneCell *tomorrowNumberCell;
/** 明天速配颜色 */
@property (nonatomic, strong) TapeOneCell *tomorrowColorCell;
/** 明天健康指数 */
@property (nonatomic, strong) TapeTwoCell *tomorrowHealthCell;
/** 明天财运指数 */
@property (nonatomic, strong) TapeTwoCell *tomorrowMoneyCell;
/** 明天爱情指数 */
@property (nonatomic, strong) TapeTwoCell *tomorrowLoveCell;
/** 明天工作指数 */
@property (nonatomic, strong) TapeTwoCell *tomorrowWorkCell;
/** 明天综合指数 */
@property (nonatomic, strong) TapeTwoCell *tomorrowAllCell;
/** 明天综合评价 */
@property (nonatomic, strong) TapeOneCell *tomorrowSummaryCell;

/** 本周时间 */
@property (nonatomic, strong) TapeOneCell *weekDate;
/** 本周健康 */
@property (nonatomic, strong) TapeOneCell *weekHealth;
/** 本周求职 */
@property (nonatomic, strong) TapeOneCell *weekJob;
/** 本周恋情 */
@property (nonatomic, strong) TapeOneCell *weekLove;
/** 本周财运 */
@property (nonatomic, strong) TapeOneCell *weekMoney;
/** 本周工作 */
@property (nonatomic, strong) TapeOneCell *weekWork;

/** 下周时间 */
@property (nonatomic, strong) TapeOneCell *nextWeekDate;
/** 下周健康 */
@property (nonatomic, strong) TapeOneCell *nextWeekHealth;
/** 下周求职 */
@property (nonatomic, strong) TapeOneCell *nextWeekJob;
/** 下周恋情 */
@property (nonatomic, strong) TapeOneCell *nextWeekLove;
/** 下周财运 */
@property (nonatomic, strong) TapeOneCell *nextWeekMoney;
/** 下周工作 */
@property (nonatomic, strong) TapeOneCell *nextWeekWork;
@end

@implementation ConstellationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:self.name];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    if (width == 320) {
        self.Pwidth = @"215";
    } else if (width == 375) {
        self.Pwidth = @"270";
    } else {
        self.Pwidth = @"309";
    }
    
}
/** 本周信息 */
- (TapeOneCell *)weekDate
{
    if (!_weekDate) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"时        间:";
        cell1.OneContentLabel.text = self.weeks.date;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.weekDate = cell1;
    }
    return _weekDate;
}
- (TapeOneCell *)weekHealth
{
    if (!_weekHealth) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"健        康:";
        NSString *health = [self.weeks.health substringFromIndex:3];
        cell1.OneContentLabel.text = health;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.weekHealth = cell1;
    }
    return _weekHealth;
}
- (TapeOneCell *)weekWork
{
    if (!_weekWork) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"工        作:";
        NSString *work = [self.weeks.work substringFromIndex:3];
        cell1.OneContentLabel.text = work;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.weekWork = cell1;
    }
    return _weekWork;
}
- (TapeOneCell *)weekLove
{
    if (!_weekLove) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"恋        情:";
        NSString *love = [self.weeks.love substringFromIndex:3];
        cell1.OneContentLabel.text = love;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.weekLove = cell1;
    }
    return _weekLove;
}
- (TapeOneCell *)weekMoney
{
    if (!_weekMoney) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"财        运:";
        NSString *money = [self.weeks.money substringFromIndex:3];
        cell1.OneContentLabel.text = money;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.weekMoney = cell1;
    }
    return _weekMoney;
}
- (TapeOneCell *)weekJob
{
    if (!_weekJob) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"求        职:";
        NSString *job = [self.weeks.job substringFromIndex:3];
        cell1.OneContentLabel.text = job;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.weekJob = cell1;
    }
    return _weekJob;
}
/** 下周信息 */
- (TapeOneCell *)nextWeekDate
{
    if (!_nextWeekDate) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"时        间:";
        cell1.OneContentLabel.text = self.nextWeeks.date;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.nextWeekDate = cell1;
    }
    return _nextWeekDate;
}
- (TapeOneCell *)nextWeekHealth
{
    if (!_nextWeekHealth) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"健        康:";
        NSString *health = [self.nextWeeks.health substringFromIndex:3];
        cell1.OneContentLabel.text = health;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.nextWeekHealth = cell1;
    }
    return _nextWeekHealth;
}
- (TapeOneCell *)nextWeekWork
{
    if (!_nextWeekWork) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"工        作:";
        NSString *work = [self.nextWeeks.work substringFromIndex:3];
        cell1.OneContentLabel.text = work;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.nextWeekWork = cell1;
    }
    return _nextWeekWork;
}
- (TapeOneCell *)nextWeekLove
{
    if (!_nextWeekLove) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"恋        情:";
        NSString *love = [self.nextWeeks.love substringFromIndex:3];
        cell1.OneContentLabel.text = love;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.nextWeekLove = cell1;
    }
    return _nextWeekLove;
}
- (TapeOneCell *)nextWeekMoney
{
    if (!_nextWeekMoney) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"财        运:";
        NSString *money = [self.nextWeeks.money substringFromIndex:3];
        cell1.OneContentLabel.text = money;
        
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        
        self.nextWeekMoney = cell1;
    }
    return _nextWeekMoney;
}
- (TapeOneCell *)nextWeekJob
{
    if (!_nextWeekJob) {
        TapeOneCell *cell1 = [TapeOneCell cellWithTableView:self.myTable];
        cell1.OneTitleLabel.text = @"求        职:";
        NSString *job = [self.nextWeeks.job substringFromIndex:3];
        cell1.OneContentLabel.text = job;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [cell1.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.nextWeekJob = cell1;
    }
    return _nextWeekJob;
}
/** 明日信息 */
- (TapeOneCell *)tomorrowSummaryCell
{
    if (!_tomorrowSummaryCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"综合评价:";
        conCell.OneContentLabel.text = self.todays.summary;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [conCell.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.tomorrowSummaryCell = conCell;
    }
    return _tomorrowSummaryCell;
}
- (TapeTwoCell *)tomorrowAllCell
{
    if (!_tomorrowAllCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        LDProgressView *progressView5 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView5.color = [UIColor blackColor];
        
        NSString *all01 = [self.tomorrows.all stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *all02 = [NSString stringWithFormat:@"0.%@",all01];
        progressView5.progress = [all02 floatValue];
        progressView5.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView5];
        self.tomorrowAllCell = conCell;
    }
    return _tomorrowAllCell;
}
- (TapeTwoCell *)tomorrowWorkCell
{
    if (!_tomorrowWorkCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        conCell.TwoTitleLabel.text = @"工作指数:";
        LDProgressView *progressView4 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView4.color = [UIColor colorWithRed:0.10f green:0.10f blue:0.73f alpha:1.00f];
        
        NSString *work01 = [self.tomorrows.work stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *work02 = [NSString stringWithFormat:@"0.%@",work01];
        progressView4.progress = [work02 floatValue];
        progressView4.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView4];
        self.tomorrowWorkCell = conCell;
    }
    return _tomorrowWorkCell;
}
- (TapeTwoCell *)tomorrowLoveCell
{
    if (!_tomorrowLoveCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        conCell.TwoTitleLabel.text = @"爱情指数:";
        LDProgressView *progressView3 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView3.color = [UIColor colorWithRed:0.73f green:0.10f blue:0.00f alpha:1.00f];
        
        NSString *love01 = [self.tomorrows.love stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *love02 = [NSString stringWithFormat:@"0.%@",love01];
        progressView3.progress = [love02 floatValue];
        
        progressView3.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView3];
        self.tomorrowLoveCell = conCell;
    }
    return _tomorrowLoveCell;
}
- (TapeTwoCell *)tomorrowMoneyCell
{
    if (!_tomorrowMoneyCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        conCell.TwoTitleLabel.text = @"财运指数";
        LDProgressView *progressView2 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView2.color = [UIColor colorWithRed:0.73f green:0.73f blue:0.10f alpha:1.00f];
        
        NSString *money01 = [self.tomorrows.money stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *money02 = [NSString stringWithFormat:@"0.%@",money01];
        progressView2.progress = [money02 floatValue];
        
        progressView2.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView2];
        
        self.tomorrowMoneyCell = conCell;
    }
    return _tomorrowMoneyCell;
}
- (TapeTwoCell *)tomorrowHealthCell
{
    if (!_tomorrowHealthCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        
        conCell.TwoTitleLabel.text = @"健康指数:";
        LDProgressView *progressView1 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView1.color = [UIColor colorWithRed:0.10f green:0.73f blue:0.00f alpha:1.00f];
        
        NSString *health01 = [self.tomorrows.health stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *health02 = [NSString stringWithFormat:@"0.%@",health01];
        progressView1.progress = [health02 floatValue];
        
        progressView1.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView1];
        
        self.tomorrowHealthCell = conCell;
    }
    return _tomorrowHealthCell;
}
- (TapeOneCell *)tomorrowColorCell
{
    if (!_tomorrowColorCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"幸运颜色:";
        conCell.OneContentLabel.text = self.tomorrows.color;
        self.tomorrowColorCell = conCell;
    }
    return _tomorrowColorCell;
}
- (TapeOneCell *)tomorrowQFriendCell
{
    if (!_tomorrowQFriendCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"速配星座:";
        conCell.OneContentLabel.text = self.tomorrows.QFriend;
        self.tomorrowQFriendCell = conCell;
    }
    return  _tomorrowQFriendCell;
}
- (TapeOneCell *)tomorrowNumberCell
{
    if (!_tomorrowNumberCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"幸运数字:";
        conCell.OneContentLabel.text = self.tomorrows.number;
        self.tomorrowNumberCell = conCell;
    }
    return _tomorrowNumberCell;
}

/** 今日信息 */
- (TapeOneCell *)summaryCell
{
    if (!_summaryCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"综合评价:";
        conCell.OneContentLabel.text = self.todays.summary;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
        [conCell.OneContentLabel setPreferredMaxLayoutWidth:preMaxWaith];
        self.summaryCell = conCell;
    }
    return _summaryCell;
}
- (TapeTwoCell *)allCell
{
    if (!_allCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        LDProgressView *progressView5 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView5.color = [UIColor blackColor];
        
        NSString *all01 = [self.todays.all stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *all02 = [NSString stringWithFormat:@"0.%@",all01];
        progressView5.progress = [all02 floatValue];
        progressView5.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView5];
        self.allCell = conCell;
    }
    return _allCell;
}
- (TapeTwoCell *)workCell
{
    if (!_workCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        conCell.TwoTitleLabel.text = @"工作指数:";
        LDProgressView *progressView4 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView4.color = [UIColor colorWithRed:0.10f green:0.10f blue:0.73f alpha:1.00f];
        
        NSString *work01 = [self.todays.work stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *work02 = [NSString stringWithFormat:@"0.%@",work01];
        progressView4.progress = [work02 floatValue];
        progressView4.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView4];
        self.workCell = conCell;
    }
    return _workCell;
}
- (TapeTwoCell *)loveCell
{
    if (!_loveCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        conCell.TwoTitleLabel.text = @"爱情指数:";
        LDProgressView *progressView3 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView3.color = [UIColor colorWithRed:0.73f green:0.10f blue:0.00f alpha:1.00f];
        
        NSString *love01 = [self.todays.love stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *love02 = [NSString stringWithFormat:@"0.%@",love01];
        progressView3.progress = [love02 floatValue];
        
        progressView3.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView3];
        self.loveCell = conCell;
    }
    return _loveCell;
}
- (TapeTwoCell *)moneyCell
{
    if (!_moneyCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        conCell.TwoTitleLabel.text = @"财运指数";
        LDProgressView *progressView2 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView2.color = [UIColor colorWithRed:0.73f green:0.73f blue:0.10f alpha:1.00f];
        
        NSString *money01 = [self.todays.money stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *money02 = [NSString stringWithFormat:@"0.%@",money01];
        progressView2.progress = [money02 floatValue];
        
        progressView2.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView2];

        self.moneyCell = conCell;
    }
    return _moneyCell;
}
- (TapeTwoCell *)healthCell
{
    if (!_healthCell) {
        TapeTwoCell *conCell = [TapeTwoCell cellWithTableView:self.myTable];
        
        conCell.TwoTitleLabel.text = @"健康指数:";
        LDProgressView *progressView1 = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, [self.Pwidth  floatValue], 27)];
        progressView1.color = [UIColor colorWithRed:0.10f green:0.73f blue:0.00f alpha:1.00f];
        
        NSString *health01 = [self.todays.health stringByReplacingOccurrencesOfString:@"%" withString:@""];
        NSString *health02 = [NSString stringWithFormat:@"0.%@",health01];
        progressView1.progress = [health02 floatValue];
        
        progressView1.flat = @YES;
        [conCell.TwoContentLable addSubview:progressView1];
        
        self.healthCell = conCell;
    }
    return _healthCell;
}
- (TapeOneCell *)colorCell
{
    if (!_colorCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"幸运颜色:";
        conCell.OneContentLabel.text = self.todays.color;
        self.colorCell = conCell;
    }
    return _colorCell;
}
- (TapeOneCell *)QFriendCell
{
    if (!_QFriendCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"速配星座:";
        conCell.OneContentLabel.text = self.todays.QFriend;
        self.QFriendCell = conCell;
    }
    return  _QFriendCell;
}
- (TapeOneCell *)numberCell
{
    if (!_numberCell) {
        TapeOneCell *conCell = [TapeOneCell cellWithTableView:self.myTable];
        conCell.OneTitleLabel.text = @"幸运数字:";
        conCell.OneContentLabel.text = self.todays.number;
        self.numberCell = conCell;
    }
    return _numberCell;
}
- (void)setToday:(TodayTomorrow *)today
{
    self.todays = today;
}
- (void)setTomorrow:(TodayTomorrow *)tomorrow
{
    self.tomorrows = tomorrow;
}
- (void)setWeek:(WeekNextWeek *)week
{
    self.weeks = week;
}
- (void)setNextWeek:(WeekNextWeek *)nextWeek
{
    self.nextWeeks = nextWeek;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 9;
    } else if (section == 1) {
        return 9;
    } else if (section == 2) {
        return 6;
    } else {
        return 6;
    }
}
#pragma mark 头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"今日运势";
        case 1:
            return @"明日运势";
        case 2:
            return @"本周运势";
        default:
            return @"下周运势";
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor grayColor]];
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 8) {
            TapeOneCell *cell1 = self.summaryCell;
            CGSize size = [cell1.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            return size.height + 1;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 8) {
            TapeOneCell *cell1 = self.tomorrowSummaryCell;
            CGSize size = [cell1.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            return size.height + 1;
        }
    } else if (indexPath.section == 2)
    {
        TapeOneCell *cell1;
        
        if (indexPath.row == 0) {
            
            cell1 = self.weekDate;
            
        }else if (indexPath.row == 1) {
            
            cell1 = self.weekHealth;
            
        }else if (indexPath.row == 2) {
            
            cell1 = self.weekJob;
            
        }else if (indexPath.row == 3) {
            
            cell1 = self.weekLove;
            
        }else if (indexPath.row == 4) {
            
            cell1 = self.weekMoney;;
            
        }
        else if (indexPath.row == 5) {
            
            cell1 = self.weekWork;
            
        }
        CGSize size = [cell1.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
     
    } else if (indexPath.section == 3)
    {
        TapeOneCell *cell1;
        
        if (indexPath.row == 0) {
            
            cell1 = self.nextWeekDate;
            
        }else if (indexPath.row == 1) {
            
            cell1 = self.nextWeekHealth;
            
        }else if (indexPath.row == 2) {
            
            cell1 = self.nextWeekJob;
            
        }else if (indexPath.row == 3) {
            
            cell1 = self.nextWeekLove;
            
        }else if (indexPath.row == 4) {
            
            cell1 = self.nextWeekMoney;;
            
        }
        else if (indexPath.row == 5) {
            
            cell1 = self.nextWeekWork;
            
        }
        CGSize size = [cell1.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
        
    }

    return 50;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
             return self.QFriendCell;
        } else if (indexPath.row == 1) {
             return self.numberCell;
        } else if (indexPath.row == 2) {
            return self.colorCell;
        } else if (indexPath.row == 3) {
            return self.healthCell;
        } else if (indexPath.row == 4) {
            return self.moneyCell;
        } else if (indexPath.row == 5) {
            return self.loveCell;
        } else if (indexPath.row == 6) {
            return self.workCell;
        } else if (indexPath.row == 7) {
            return self.allCell;
        }  else if (indexPath.row == 8) {
            return self.summaryCell;
        }
       
    } else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            return self.tomorrowQFriendCell;
        } else if (indexPath.row == 1) {
            return self.tomorrowNumberCell;
        } else if (indexPath.row == 2) {
            return self.tomorrowColorCell;
        } else if (indexPath.row == 3) {
            return self.tomorrowHealthCell;
        } else if (indexPath.row == 4) {
            return self.tomorrowMoneyCell;
        } else if (indexPath.row == 5) {
            return self.tomorrowLoveCell;
        } else if (indexPath.row == 6) {
            return self.tomorrowWorkCell;
        } else if (indexPath.row == 7) {
            return self.tomorrowAllCell;
        }  else if (indexPath.row == 8) {
            return self.tomorrowSummaryCell;
        }

    } else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            return self.weekDate;
        } else if (indexPath.row == 1) {
            return self.weekHealth;
        } else if (indexPath.row == 2) {
            return self.weekJob;
        } else if (indexPath.row == 3) {
            return self.weekLove;
        } else if (indexPath.row == 4) {
            return self.weekMoney;
        } else if (indexPath.row == 5) {
            return self.weekWork;
        }
    } else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            return self.nextWeekDate;
        } else if (indexPath.row == 1) {
            return self.nextWeekHealth;
        } else if (indexPath.row == 2) {
            return self.nextWeekJob;
        } else if (indexPath.row == 3) {
            return self.nextWeekLove;
        } else if (indexPath.row == 4) {
            return self.nextWeekMoney;
        } else if (indexPath.row == 5) {
            return self.nextWeekWork;
        }

    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

@end
