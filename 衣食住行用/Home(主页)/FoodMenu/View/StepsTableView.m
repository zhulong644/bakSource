//
//  StepsTableView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/31.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "StepsTableView.h"
#import "StepTableViewCell.h"
#import "Step.h"
#import "UIImageView+WebCache.h"
@interface StepsTableView ()
@property (nonatomic, strong) StepTableViewCell *prototypeCell;
@end

@implementation StepsTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"StepTableViewCell";
    //自定义cell类
    StepTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"StepTableViewCell" owner:self options:nil] lastObject];
    
    self.prototypeCell = cell;
    //去掉分隔线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
//    self.tableView.bounces=NO;
    [self setExtraCellLineHidden:self.tableView];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.steps.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StepTableViewCell *cell = self.prototypeCell;
    
    Step *step = self.steps[indexPath.row];

    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 108;
    [cell.foodDescLabel setPreferredMaxLayoutWidth:preMaxWaith];
    
    cell.foodDescLabel.text = step.stepDesc;
    [cell.foodImage sd_setImageWithURL:[NSURL URLWithString:step.img]];

    [cell.foodDescLabel layoutIfNeeded];

    [cell.contentView layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return 1  + size.height;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"StepTableViewCell";
    //自定义cell类
    StepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StepTableViewCell" owner:self options:nil] lastObject];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //添加测试数据
    Step *step = self.steps[indexPath.row];
    cell.foodDescLabel.text = step.stepDesc;
    //测试图片
    [cell.foodImage sd_setImageWithURL:[NSURL URLWithString:step.img]];
    return cell;
}
@end
