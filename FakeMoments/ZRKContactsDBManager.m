//
//  ZRKContactsDBManager.m
//  FakeMoments
//
//  Created by Zark on 2017/7/27.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKContactsDBManager.h"

@implementation ZRKContactsDBManager

- (NSMutableArray *)queryContactsModelsArray {
    NSMutableArray *mutArray = [self queryData].mutableCopy;
    if(!mutArray) {
        return nil;
    } else {
        NSMutableArray *modelsArray = [NSMutableArray array];
        for (NSMutableArray *arr in mutArray) {
            ZRKContactsModel *model = [[ZRKContactsModel alloc] init];
            model.userId = (int)arr[0];
            model.name = arr[1];
            model.brief = arr[2];
            model.picUrl = arr[3];
            [modelsArray addObject:model];
        }
        return modelsArray;
    }
}

@end
