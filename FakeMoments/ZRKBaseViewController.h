//
//  ZRKBaseViewController.h
//  FakeMoments
//
//  Created by Zark on 2017/7/17.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRKBaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

- (void)registerCellWithClass:(NSString *)className tableView:(UITableView *)tabelView;

@end
