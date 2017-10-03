//
//  MainWeatherTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainWeatherTableViewCell.h"

@interface MainWeatherTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UILabel *windLabel;

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (nonatomic, strong) Realtime *myRealtime;
@end

@implementation MainWeatherTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MainWeatherTableViewCell";
    MainWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainWeatherTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setRealtime:(Realtime *)realtime
{
    _myRealtime = realtime;
    //设置日期
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    self.dateLabel.text = [NSString stringWithFormat:@"%@", currentDateStr];
    //设置天气温度
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@℃", realtime.weather.temperature];
    //设置天气情况
    self.infoLabel.text = _myRealtime.weather.info;
    //设置城市
    self.cityLabel.text = _myRealtime.city_name;
    //设置图片
    UIImage *img = [self imageWithId:_myRealtime.weather.img];
    self.weatherImageView.image = img;
    //设置风的信息
    self.windLabel.text = [NSString stringWithFormat:@"%@"@"%@", _myRealtime.wind.power, _myRealtime.wind.direct];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    if (width == 320) {
        
        self.cityLabel.font = [UIFont systemFontOfSize:25];
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        self.windLabel.font = [UIFont systemFontOfSize:14];
        self.infoLabel.font = [UIFont systemFontOfSize:14];
        
        self.temperatureLabel.font = [UIFont systemFontOfSize:35];
        
    } else if (width == 375) {
        self.cityLabel.font = [UIFont systemFontOfSize:30];
        self.dateLabel.font = [UIFont systemFontOfSize:14];
        self.windLabel.font = [UIFont systemFontOfSize:16];
        self.infoLabel.font = [UIFont systemFontOfSize:16];
        
        self.temperatureLabel.font = [UIFont systemFontOfSize:40];
    }
    
}
- (UIImage *)imageWithId:(NSString *)weatherId
{
    UIImage *img = nil;
    
    if ([weatherId isEqualToString:@"0"]) {//晴天
        img = [UIImage imageNamed:@"sunny.png"];
    } else if ([weatherId isEqualToString:@"1"]) {//多云
        img = [UIImage imageNamed:@"cloudy4"];
    } else if ([weatherId isEqualToString:@"2"]) {//阴天
        img = [UIImage imageNamed:@"cloudy5"];
    } else if ([weatherId isEqualToString:@"3"]) {//阵雨
        img = [UIImage imageNamed:@"shower2"];
    } else if ([weatherId isEqualToString:@"4"]) {//雷阵雨
        img = [UIImage imageNamed:@"tstorm3"];
    } else if ([weatherId isEqualToString:@"5"]) {//雷阵雨伴有冰雹
        img = [UIImage imageNamed:@"hail"];
    } else if ([weatherId isEqualToString:@"6"]) {//雨夹雪
        img = [UIImage imageNamed:@"sleet"];
    } else if ([weatherId isEqualToString:@"7"]) {//小雨
        img = [UIImage imageNamed:@"light_rain"];
    } else if ([weatherId isEqualToString:@"8"]) {//中雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"9"]) {//大雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"10"]) {//暴雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"11"]) {//大暴雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"12"]) {//特大暴雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"13"]) {//阵雪
        img = [UIImage imageNamed:@"snow3"];
    } else if ([weatherId isEqualToString:@"14"]) {//小雪
        img = [UIImage imageNamed:@"snow4"];
    } else if ([weatherId isEqualToString:@"15"]) {//中雪
        img = [UIImage imageNamed:@"snow4"];
    } else if ([weatherId isEqualToString:@"16"]) {//大雪
        img = [UIImage imageNamed:@"snow5"];
    } else if ([weatherId isEqualToString:@"17"]) {//暴雪
        img = [UIImage imageNamed:@"snow5"];
    } else if ([weatherId isEqualToString:@"18"]) {//雾
        img = [UIImage imageNamed:@"mist"];
    } else if ([weatherId isEqualToString:@"19"]) {//冻雨
        img = [UIImage imageNamed:@"hail"];
    } else if ([weatherId isEqualToString:@"20"]) {//沙尘暴
        img = [UIImage imageNamed:@"fog"];
    } else if ([weatherId isEqualToString:@"21"]) {//小雨-中雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"22"]) {//中雨-大雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"23"]) {//大雨-暴雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"24"]) {//暴雨-大暴雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"25"]) {//大暴雨-特大暴雨
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherId isEqualToString:@"26"]) {//小雪-中雪
        img = [UIImage imageNamed:@"snow5"];
    } else if ([weatherId isEqualToString:@"27"]) {//中雪-大雪
        img = [UIImage imageNamed:@"snow5"];
    } else if ([weatherId isEqualToString:@"28"]) {//大雪-暴雪
        img = [UIImage imageNamed:@"snow5"];
    } else if ([weatherId isEqualToString:@"29"]) {//浮尘
        img = [UIImage imageNamed:@"mist_night"];
    } else if ([weatherId isEqualToString:@"30"]) {//扬沙
        img = [UIImage imageNamed:@"mist_night"];
    } else if ([weatherId isEqualToString:@"31"]) {//强沙尘暴
        img = [UIImage imageNamed:@"mist_night"];
    } else if ([weatherId isEqualToString:@"53"]) {//霾
        img = [UIImage imageNamed:@"mist_night"];
    }
    return img;
}

@end
