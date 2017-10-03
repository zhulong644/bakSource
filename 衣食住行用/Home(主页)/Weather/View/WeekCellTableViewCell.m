//
//  WeekCellTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/27.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "WeekCellTableViewCell.h"
#import "FInfo.h"

@interface WeekCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

@property (weak, nonatomic) IBOutlet UILabel *weekNumber;

@property (weak, nonatomic) IBOutlet UILabel *windInfo;

@property (weak, nonatomic) IBOutlet UILabel *temInfo;
@end
@implementation WeekCellTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"WeekCellTableViewCell";
    WeekCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeekCellTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setWeather:(FWeather *)weather
{
    _weather = weather;
    
    NSString *weatherinfo = self.weather.info.day[1];
    self.weatherImage.image = [self getImageWithString:weatherinfo];
    self.weekNumber.text = [NSString stringWithFormat:@"星期%@",self.weather.week];
    self.windInfo.text = self.weather.info.day[4];
    self.temInfo.text =  [NSString stringWithFormat:@"%@℃", self.weather.info.day[2]];
    
}
- (UIImage *)getImageWithString:(NSString *)weatherinfo
{
    UIImage *img = nil;
    
    if ([weatherinfo containsString:@"晴"] ) {
         img = [UIImage imageNamed:@"sunny.png"];
    } else if ([weatherinfo containsString:@"雨"]) {
        img = [UIImage imageNamed:@"shower3"];
    } else if ([weatherinfo containsString:@"云"]) {
        img = [UIImage imageNamed:@"cloudy4"];
    } else if ([weatherinfo containsString:@"阴"]) {
        img = [UIImage imageNamed:@"cloudy5"];
    }
    return img;
}
@end
