//
//  MainDateTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "MainDateTableViewCell.h"

@interface MainDateTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *yangLi;

@property (weak, nonatomic) IBOutlet UILabel *yinLi;

@property (weak, nonatomic) IBOutlet UILabel *yi;

@property (weak, nonatomic) IBOutlet UILabel *ji;
/** 日历 */
@property (nonatomic, strong) Huang *myHuangli;
@end
@implementation MainDateTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MainDateTableViewCell";
    MainDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainDateTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
- (void)setHuangli:(Huang *)huangli
{
    _myHuangli = huangli;
    self.yangLi.text =[_myHuangli.yangli substringWithRange:NSMakeRange(8, 2)];
    self.yinLi.text = _myHuangli.yinli;
    self.yi.text = [NSString stringWithFormat:@"适宜: %@", _myHuangli.yi];
    self.ji.text = [NSString stringWithFormat:@"忌讳: %@", _myHuangli.ji];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;

    
    if (width == 320) {
        self.yangLi.font = [UIFont systemFontOfSize:55];
        self.yinLi.font = [UIFont systemFontOfSize:15];
        self.yi.font = [UIFont systemFontOfSize:14];
        self.ji.font = [UIFont systemFontOfSize:14];
    } else if (width == 375) {
        self.yangLi.font = [UIFont systemFontOfSize:55];
        self.yinLi.font = [UIFont systemFontOfSize:14];
        self.yi.font = [UIFont systemFontOfSize:14];
        self.ji.font = [UIFont systemFontOfSize:14];
    }
}
@end
