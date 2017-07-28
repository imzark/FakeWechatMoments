//
//  ZRKContactsDBManager.h
//  FakeMoments
//
//  Created by Zark on 2017/7/27.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKDBManager.h"
#import "ZRKContactsModel.h"

@interface ZRKContactsDBManager : ZRKDBManager

- (NSArray *)queryContactsModelsArray;

@end
