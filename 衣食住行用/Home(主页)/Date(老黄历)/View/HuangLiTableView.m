//
//  HuangLiTableView.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/23.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "HuangLiTableView.h"
#import "Huang.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH_4s 320.0f
#define CELL_CONTENT_WIDTH_6 375.0f
#define CELL_CONTENT_WIDTH_6p 414.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface HuangLiTableView ()
@property (nonatomic, strong) Huang *huangli;
@end

@implementation HuangLiTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)setHuang:(Huang *)huang
{
    self.huangli = huang;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 30, 20)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 20)];
    headerLabel.textColor = [UIColor lightGrayColor];
    NSString *text = nil;
    if (section == 0) {
        text = @"阳历:";
    }
    else if (section == 1) {
        text = @"阴历:";
    }
    else if (section == 2) {
        text = @"五行:";
    }
    else if (section == 3) {
        text = @"冲煞:";
    }
    else if (section == 4) {
        text = @"彭祖百忌:";
    }
    else if (section == 5) {
        text = @"吉神宜趋:";
    }
    else if (section == 6) {
        text = @"适宜:";
    }
    else if (section == 7) {
        text = @"忌讳:";
    }
    else if (section == 8) {
        text = @"凶神宜忌:";
    }

    headerLabel.text = text;
    [header addSubview:headerLabel];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *detailText = nil;
        if (indexPath.section == 0) {
            detailText = self.huangli.yangli;
        }
        else if (indexPath.section == 1) {
            detailText = self.huangli.yinli;
        }
        else if (indexPath.section == 2) {
            detailText = self.huangli.wuxing;
        }
        else if (indexPath.section == 3) {
            detailText = self.huangli.chongsha;
        }
        else if (indexPath.section == 4) {
            detailText = self.huangli.baiji;
        }
        else if (indexPath.section == 5) {
            detailText = self.huangli.jishen;
        }
        else if (indexPath.section == 6) {
            detailText = self.huangli.yi;
        }
        else if (indexPath.section == 7) {
            detailText = self.huangli.ji;
        }
        else if (indexPath.section == 8) {
            detailText = self.huangli.xiongshen;
        }
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), 20000.0f);
    
    if (width == 320) {
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), 20000.0f);
    } else if (width == 375) {
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_6 - (CELL_CONTENT_MARGIN *2), 20000.0f);
    } else if (width == 414){
        constraint = CGSizeMake(CELL_CONTENT_WIDTH_6p - (CELL_CONTENT_MARGIN *2), 20000.0f);
    }
    
    CGSize size = [detailText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height =MAX(size.height, 44.0f);
    return height + (CELL_CONTENT_MARGIN *2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    UILabel *label =nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"];
        cell.selectionStyle = YES;
        //不可点击
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:FONT_SIZE];
        [label setNumberOfLines:0];
        label.textColor = [UIColor blackColor];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setTag:1];
        //去掉边框
//        [[label layer]setBorderWidth:2.0f];
        [[cell contentView]addSubview:label];
    }
    
    // 设置cell显示的文字
    NSString *text = nil;
    NSString *detailText = nil;
    if (indexPath.section == 0) {
        detailText = self.huangli.yangli;
    }
    else if (indexPath.section == 1) {
        detailText = self.huangli.yinli;
    }
    else if (indexPath.section == 2) {
        detailText = self.huangli.wuxing;
    }
    else if (indexPath.section == 3) {
        detailText = self.huangli.chongsha;
    }
    else if (indexPath.section == 4) {
        detailText = self.huangli.baiji;
    }
    else if (indexPath.section == 5) {
        detailText = self.huangli.jishen;
    }
    else if (indexPath.section == 6) {
        detailText = self.huangli.yi;
    }
    else if (indexPath.section == 7) {
        detailText = self.huangli.ji;
    }
    else if (indexPath.section == 8) {
        detailText = self.huangli.xiongshen;
    }
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_WIDTH_4s *2), 20000.0f);
    
        if (width == 320) {
                constraint = CGSizeMake(CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), 20000.0f);
        } else if (width == 375) {
                constraint = CGSizeMake(CELL_CONTENT_WIDTH_6 - (CELL_CONTENT_MARGIN *2), 20000.0f);
        } else if (width == 414){
                constraint = CGSizeMake(CELL_CONTENT_WIDTH_6p - (CELL_CONTENT_MARGIN *2), 20000.0f);
        }

    CGSize size = [detailText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (!label)
         label = (UILabel*)[cell viewWithTag:1];
 
    [label setText:detailText];
    if (width == 320) {
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH_4s - (CELL_CONTENT_MARGIN *2), MAX(size.height, 44.0f))];
    } else if (width == 375) {
       [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH_6 - (CELL_CONTENT_MARGIN *2), MAX(size.height, 44.0f))];
    } else if (width == 414){
          [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH_6p - (CELL_CONTENT_MARGIN *2), MAX(size.height, 44.0f))];
    }
    return cell;
}

@end
