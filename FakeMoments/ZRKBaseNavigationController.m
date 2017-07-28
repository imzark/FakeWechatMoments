//
//  ZRKBaseNavigationController.m
//  FakeMoments
//
//  Created by Zark on 2017/7/17.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKBaseNavigationController.h"

@interface ZRKBaseNavigationController ()

@end

@implementation ZRKBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UINavigationBar *naviBar = [UINavigationBar appearance];
    CGFloat rgb = 0.1;
    naviBar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    naviBar.tintColor = [UIColor whiteColor];
    naviBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
