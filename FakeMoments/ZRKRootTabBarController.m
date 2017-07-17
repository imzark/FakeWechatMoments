//
//  ZRKRootTabBarController.m
//  FakeMoments
//
//  Created by Zark on 2017/7/17.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKRootTabBarController.h"
#import "ZRKBaseNavigationController.h"

@interface ZRKRootTabBarController ()

@end

static NSString *const rootVCClassString = @"rootVCClassString";
static NSString *const rootVCTitleString = @"rootVCTitleString";
static NSString *const rootVCImageString = @"rootVCImageString";
static NSString *const rootVCSelectedImgString = @"rootVCSelectedImgString";

@implementation ZRKRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                             @{rootVCClassString : @"ZRKHomeViewController",
                               rootVCTitleString : @"微信",
                               rootVCImageString : @"tabbar_home",
                               rootVCSelectedImgString : @"tabbar_home_highlighted"},
                             
                             @{rootVCClassString : @"ZRKContactsViewController",
                               rootVCTitleString : @"通讯录",
                               rootVCImageString : @"tabbar_contacts",
                               rootVCSelectedImgString : @"tabbar_contacts_highlighted"},
                             
                             @{rootVCClassString : @"ZRKDiscoveryViewController",
                               rootVCTitleString : @"发现",
                               rootVCImageString : @"tabbar_discovery",
                               rootVCSelectedImgString : @"tabbar_discovery_highlighted"},
                             
                             @{rootVCClassString : @"ZRKMyselfViewController",
                               rootVCTitleString : @"我",
                               rootVCImageString : @"tabbar_myself",
                               rootVCSelectedImgString : @"tabbar_myself_highlighted"}
                             ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *viewController = [[NSClassFromString(dict[rootVCClassString]) alloc] init];
        
        //「If a navigation controller is nested in a tabbar controller, it uses the title and toolbar attributes of the bottom view controller on the stack. 」———— UINavigationController.h
        viewController.title = dict[rootVCTitleString];
        ZRKBaseNavigationController *rootNavC = [[ZRKBaseNavigationController alloc] initWithRootViewController:viewController];
        UITabBarItem *tabBarItem = viewController.tabBarItem;

        // 不显式指明tabar.title会使用其子控制器的title
//        tabBarItem.title = dict[rootVCTitleString];
        tabBarItem.image = [UIImage imageNamed:dict[rootVCImageString]];
        tabBarItem.selectedImage = [UIImage imageNamed:dict[rootVCSelectedImgString]];
        
        // Tab顺序根据加入子控制器的顺序
        [self addChildViewController:rootNavC];
    }];
    
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
