//
//  ZRKDBManager.h
//  FakeMoments
//
//  Created by Zark on 2017/7/19.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZRKContactsModel;

@interface ZRKDBManager : NSObject

- (instancetype)initWithDataBaseFileName: (NSString *)dbFileName;
- (NSArray *)queryContactsModelsArray;
- (BOOL)insertContactsModel:(ZRKContactsModel *)model;
- (BOOL)updateContactsModel:(ZRKContactsModel *)model;

@end
