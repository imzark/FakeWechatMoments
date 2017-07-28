//
//  ZRKDBManager.h
//  FakeMoments
//
//  Created by Zark on 2017/7/19.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRKDBManager : NSObject

- (instancetype)initWithDataBaseFileName: (NSString *)dbFileName;
- (void)insertDataWithArray:(NSArray *)dataArray;
- (void)updateDataWithArray:(NSArray *)dataArray;
- (NSArray *)queryData;

@end
