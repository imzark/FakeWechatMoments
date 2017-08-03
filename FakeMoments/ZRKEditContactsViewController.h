//
//  ZRKEditContactsViewController.h
//  FakeMoments
//
//  Created by Zark on 2017/7/20.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRKEditContactsViewController;
@class ZRKContactsModel;

@protocol ZRKEditContactsDelegate <NSObject>

- (void)editContactControllerDidAddContactData:(ZRKContactsModel *)model;
- (void)editContactControllerDidEditContactData:(ZRKContactsModel *)model;

@end

@interface ZRKEditContactsViewController : UIViewController

@property (nonatomic, weak) id<ZRKEditContactsDelegate> delegate;
@property (nonatomic, strong) ZRKContactsModel *model;

@end
