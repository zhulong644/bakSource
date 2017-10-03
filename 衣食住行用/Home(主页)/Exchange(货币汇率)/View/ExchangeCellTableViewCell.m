//
//  ExchangeCellTableViewCell.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/07/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "ExchangeCellTableViewCell.h"

@interface ExchangeCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *fBuyPriLabel;

@property (weak, nonatomic) IBOutlet UILabel *mBuyPriLabel;

@property (weak, nonatomic) IBOutlet UILabel *fSellPriLabel;

@property (weak, nonatomic) IBOutlet UILabel *mSellPriLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankConversionPriLabel;
@end

@implementation ExchangeCellTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ExchangeCellTableViewCell";
    ExchangeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExchangeCellTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setExchange:(Exchange *)exchange
{
    _exchange = exchange;
    self.date.text = [NSString stringWithFormat:@"%@  %@", _exchange.date, _exchange.time];
    self.fBuyPriLabel.text = [NSString stringWithFormat:@"现汇买入价: %@", _exchange.fBuyPri];
    self.mBuyPriLabel.text = [NSString stringWithFormat:@"现钞买入价: %@", _exchange.mBuyPri];
    self.fSellPriLabel.text = [NSString stringWithFormat:@"现汇卖入价: %@", _exchange.fSellPri];
    self.mSellPriLabel.text = [NSString stringWithFormat:@"现钞卖入价: %@", _exchange.mSellPri];
    self.bankConversionPriLabel.text = [NSString stringWithFormat:@"银行折算价: %@", _exchange.bankConversionPri];
    
}
@end
