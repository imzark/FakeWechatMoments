//
//  ZRKBaseViewController.m
//  FakeMoments
//
//  Created by Zark on 2017/7/17.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKBaseViewController.h"

@interface ZRKBaseViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ZRKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableFooterView = [[UIView alloc] init];  // 末尾变空白
    }
    return _tableView;
}

- (void)registerCellWithClass:(NSString *)className tableView:(UITableView *)tabelView {
    [tabelView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
