//
//  CollectionDetailViewController.m
//  YSLTransitionAnimatorDemo
//
//  Created by yamaguchi on 2015/05/20.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "CollectionDetailViewController.h"
#import "StepsTableView.h"
#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"
#import "UIImageView+WebCache.h"

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface CollectionDetailViewController () <YSLTransitionAnimatorDataSource>

@property (nonatomic, weak) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myViewHeight;
@property (nonatomic, strong) StepsTableView *stepTable;

/*** 菜的名字***/
@property (nonatomic, strong) UILabel *foodName;
/*** 菜的描述***/
@property (nonatomic, strong) UILabel *foodDesc;
/*** 菜的主料***/
@property (nonatomic, strong) UILabel *ingredients;
/*** 菜的配料***/
@property (nonatomic, strong) UILabel *burden;
/*** 菜的用途***/
@property (nonatomic, strong) UILabel *tags;
/*** 收藏按钮***/
@property (nonatomic, strong) NSString *buttonSelect;

@end

@implementation CollectionDetailViewController

{
    BOOL showingSettings;
}

- (UILabel *)foodName
{
    if (!_foodName) {
        UILabel *name = [[UILabel alloc] init];
        name.backgroundColor = [UIColor clearColor];
        _foodName = name;
    }
    return _foodName;
}

- (UILabel *)foodDesc
{
    if (!_foodDesc) {
        UILabel *desc = [[UILabel alloc] init];
        desc.backgroundColor = [UIColor clearColor];
        _foodDesc = desc;
    }
    return _foodDesc;
}
- (UILabel *)ingredients
{
    if (!_ingredients) {
        UILabel *ing = [[UILabel alloc] init];
        ing.backgroundColor = [UIColor clearColor];
        _ingredients = ing;
    }
    return _ingredients;
}
- (UILabel *)burden
{
    if (!_burden) {
        UILabel *burden = [[UILabel alloc] init];
        burden.backgroundColor = [UIColor clearColor];
        _burden = burden;
    }
    return _burden;
}
- (UILabel *)tags
{
    if (!_tags) {
        UILabel *tags = [[UILabel alloc] init];
        tags.backgroundColor = [UIColor clearColor];
        _tags = tags;
    }
    return _tags;
}
- (StepsTableView *)stepTable
{
    if (!_stepTable) {
        StepsTableView *stepTable = [[StepsTableView alloc] init];
        stepTable.view.backgroundColor = [UIColor clearColor];
        self.stepTable = stepTable;
    }
    return _stepTable;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self ysl_removeTransitionDelegate];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self ysl_addTransitionDelegate:self];
    [self ysl_popTransitionAnimationWithCurrentScrollView:nil
                                    cancelAnimationPointY:0
                                        animationDuration:0.3
                                  isInteractiveTransition:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"美食详情"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    showingSettings = NO;
    [self buttonSelected];
    NSString *addText = self.buttonSelect;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:addText style:0 target:self action:@selector(doCollection)];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;

    _headerImageView.frame = CGRectMake(0, statusHeight + navigationHeight, rect.size.width, 320);
    
    NSArray *imgArray = self.foodList.albums;
    NSString *image = imgArray[0];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:image]];
    
    
    [self initData];

    
}
- (void)buttonSelected
{
    
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"collectionArray"];
    NSArray *collArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (collArray.count == 0) {
        
        self.buttonSelect = @"收藏";
        
    } else {
        //读取：
        NSString *foodNameId = self.foodList.id;
        
        for (NSDictionary *dic in collArray) {
        
            NSString *foodID = [dic objectForKey:@"foodid"];
            
            if ([foodID isEqualToString:foodNameId]) {
                self.buttonSelect = @"取消收藏";
                showingSettings = !showingSettings;
                break;
            } else {
                self.buttonSelect = @"收藏";
            }
        }
    }
}
- (void)doCollection
{
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"collectionArray"];
    if(showingSettings){//从收藏字典中移除去
        
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSMutableArray *myMutableArray = [oldSavedArray mutableCopy];
        
        NSString *foodNameId = self.foodList.id;
        
        for (NSDictionary *dic in myMutableArray) {
            
            NSString *foodID = [dic objectForKey:@"foodid"];
            
            if ([foodID isEqualToString:foodNameId]) {
                [myMutableArray removeObject:dic];
                break;
            }
        }
        NSArray *myArray = [myMutableArray copy];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:myArray] forKey:@"collectionArray"];
        self.navigationItem.rightBarButtonItem.title = @"收藏";
        
    } else {//保存到收藏字典中去
        
        self.navigationItem.rightBarButtonItem.title = @"取消收藏";
        
        if (data == NULL) {
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            //创建词典对象，初始化长度为2
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:2];
            //向词典中动态添加数据
            [dictionary setObject:self.foodList.id forKey:@"foodid"];
            [dictionary setObject:self.foodList.title forKey:@"foodtitle"];
            
            [array addObject:dictionary];
            NSArray *myArray = [array copy];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:myArray] forKey:@"collectionArray"];
        } else {
            //读取：
            NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSMutableArray *myMutableArray = [oldSavedArray mutableCopy];
            
            //创建词典对象，初始化长度为2
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:2];
            //向词典中动态添加数据
            [dictionary setObject:self.foodList.id forKey:@"foodid"];
            [dictionary setObject:self.foodList.title forKey:@"foodtitle"];
            
            [myMutableArray insertObject:dictionary atIndex:0];
            
            NSArray *myArray = [myMutableArray copy];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:myArray] forKey:@"collectionArray"];
        }
        
    }
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"collectionArray" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    showingSettings = !showingSettings;
}
- (void)initData
{
    //食物的标题名字
    self.foodName.text = self.foodList.title;
    //自动折行设置
    self.foodName.lineBreakMode = NSLineBreakByWordWrapping;
    self.foodName.numberOfLines = 0;
    self.foodName.font = [UIFont fontWithName:@"Helvetica" size:25.f];
    self.foodName.textColor = [UIColor blackColor];
    CGFloat foodNameHeight = 50;
    CGFloat foodNameWidth = ScreenWidth - 40;
    CGFloat foodNameX = 10;
    CGFloat foodNameY = 330;
    CGRect foodNameFrame = CGRectMake(foodNameX, foodNameY, foodNameWidth, foodNameHeight);
    self.foodName.frame = foodNameFrame;
    [self.myView addSubview:self.foodName];
    
    //食物的描述
    NSString *imtro = [NSString stringWithFormat:@"简介: %@", self.foodList.imtro];
    self.foodDesc.text = imtro;
    //自动折行设置
    self.foodDesc.lineBreakMode = NSLineBreakByWordWrapping;
    self.foodDesc.numberOfLines = 0;
    self.foodDesc.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    self.foodDesc.textColor = [UIColor blackColor];
    CGFloat foodDescX = 10;
    CGFloat foodDescY = CGRectGetMaxY(foodNameFrame) + 10;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat foodDescWidth = width - 20;
    CGSize size = [self.foodDesc sizeThatFits:CGSizeMake(foodDescWidth, MAXFLOAT)];
    CGRect foodDescFrameRect = CGRectMake( foodDescX, foodDescY, foodDescWidth, size.height);
    self.foodDesc.frame = foodDescFrameRect;
    [self.myView addSubview:self.foodDesc];
    //用途
    NSString *tags = [NSString stringWithFormat:@"适合: %@", self.foodList.tags];
    self.tags.text = tags;
    self.tags.lineBreakMode = NSLineBreakByWordWrapping;
    self.tags.numberOfLines = 0;
    self.tags.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    self.tags.textColor = [UIColor blackColor];
    CGSize tagSize = [self.tags sizeThatFits:CGSizeMake(foodDescWidth, MAXFLOAT)];
    CGRect tagsFrameRect = CGRectMake( foodDescX, CGRectGetMaxY(foodDescFrameRect) + 10, foodDescWidth, tagSize.height);
    self.tags.frame = tagsFrameRect;
    [self.myView addSubview:self.tags];
    //主料
    NSString *ingredients = [NSString stringWithFormat:@"主料: %@", self.foodList.ingredients];
    self.ingredients.text = ingredients;
    self.ingredients.lineBreakMode = NSLineBreakByWordWrapping;
    self.ingredients.numberOfLines = 0;
    self.ingredients.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    self.ingredients.textColor = [UIColor blackColor];
    CGSize ingredientsSize = [self.ingredients sizeThatFits:CGSizeMake(foodDescWidth, MAXFLOAT)];
    CGRect ingredientsFrameRect = CGRectMake( foodDescX, CGRectGetMaxY(tagsFrameRect) + 10, foodDescWidth, ingredientsSize.height);
    self.ingredients.frame = ingredientsFrameRect;
    [self.myView addSubview:self.ingredients];
    //配料
    NSString *burden = [NSString stringWithFormat:@"配料: %@", self.foodList.burden];
    self.burden.text = burden;
    self.burden.lineBreakMode = NSLineBreakByWordWrapping;
    self.burden.numberOfLines = 0;
    self.burden.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    self.burden.textColor = [UIColor blackColor];
    CGSize burdenSize = [self.burden sizeThatFits:CGSizeMake(foodDescWidth, MAXFLOAT)];
    CGRect burdenFrameRect = CGRectMake( foodDescX, CGRectGetMaxY(ingredientsFrameRect) + 10, foodDescWidth, burdenSize.height);
    self.burden.frame = burdenFrameRect;
    [self.myView addSubview:self.burden];
    
    //步骤
    self.stepTable.steps = self.foodList.steps;
    CGRect stepsRect = CGRectMake(10, CGRectGetMaxY(burdenFrameRect) + 10, ScreenWidth - 20, 2000);
    self.stepTable.view.frame = stepsRect;
    [self.myView addSubview:self.stepTable.view];
    //myView高度
    self.myViewHeight.constant = CGRectGetMaxY(burdenFrameRect) + 10 + self.foodList.steps.count * 100 + 50;
}
#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)popTransitionImageView
{
    return self.headerImageView;
}

- (UIImageView *)pushTransitionImageView
{
    return nil;
}

@end
