//
//  CitySearchView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/2.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "CitySearchView.h"
#import "City.h"
#import "MTConst.h"

@interface CitySearchView ()
@property (nonatomic, strong) NSMutableArray *resultCities;
@end

@implementation CitySearchView

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    
    searchText = searchText.lowercaseString;
    
        self.resultCities = [NSMutableArray array];
        // 根据关键字搜索想要的城市数据
        for (City *city in self.citys) {
            if ([city.city_name containsString:searchText] || [city.city_pinyin containsString:searchText] || [city.city_pre containsString:searchText])
            {
                [self.resultCities addObject:city];
            }
        }
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultCities.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    City *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.city_name;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   City *city = self.resultCities[indexPath.row];
    // 发出通知
    [MTNotificationCenter postNotificationName:MTCityDidChangeNotification object:nil userInfo:@{MTSelectCityId : city.id, MTSelectCityName : city.city_name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
