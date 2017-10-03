//
//  GoodCell.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/7.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "GoodCell.h"
#import "UIImageView+WebCache.h"

@interface GoodCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;

@end

@implementation GoodCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GoodCell";
    GoodCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodCell" owner:self options:nil] lastObject];
    }
    return cell;
}
- (void)setGoodInfo:(GoodInfo *)goodInfo
{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodInfo.sppic]];
    NSString *Info = [NSString stringWithFormat:@"%@ %@ 元", goodInfo.siteName, goodInfo.spprice];
    self.goodsTitleLabel.text = Info;
}

@end
