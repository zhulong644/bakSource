//
//  GoodsInfoView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/7.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "GoodsInfoView.h"
#import "UIImageView+WebCache.h"
#import "GoodInfo.h"

@interface GoodsInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;

@property (weak, nonatomic) IBOutlet UITextView *infoText;


@property (nonatomic, strong) GoodInfo *goods;
@end

@implementation GoodsInfoView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.goods.sppic]];
       NSString *Info = [NSString stringWithFormat:@"%@ %@ 元", self.goods.siteName, self.goods.spprice];
    self.goodTitleLabel.text = Info;
    self.infoText.text = self.goods.spname;
}
- (void)setGoodInfo:(GoodInfo *)goodInfo
{
    self.goods = goodInfo;
}

@end
