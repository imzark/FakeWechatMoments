//
//  ZRKContactsModel.h
//  FakeMoments
//
//  Created by Zark on 2017/7/20.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRKContactsModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) int userId;

@end
