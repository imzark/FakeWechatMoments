//
//  ZRKHomeViewController.m
//  FakeMoments
//
//  Created by Zark on 2017/7/17.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKHomeViewController.h"
#import "ZRKHomeCell.h"

@interface ZRKHomeViewController ()

@end

@implementation ZRKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
}

- (void)setupTableView {
    self.dataSource = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q"].mutableCopy;
    [self registerCellWithClass:@"ZRKHomeCell" tableView:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate & DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZRKHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZRKHomeCell" forIndexPath:indexPath];
    
//    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.nameLabel.text = @"ABC";
    cell.summaryLabel.text = @"谈笑风生";
    cell.avatarImageView.image = [UIImage imageNamed:@"Avater"];
    cell.TimeLabel.text = @"10:06";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}



@end
