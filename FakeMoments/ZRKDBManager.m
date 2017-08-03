//
//  ZRKDBManager.m
//  FakeMoments
//
//  Created by Zark on 2017/7/19.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKDBManager.h"
#import <FMDB.h>
#import "ZRKContactsModel.h"

@interface ZRKDBManager()

@property (nonatomic, strong) NSString *dbFileName;
@property (nonatomic, strong) NSString *dbPath;

@end

static NSString *const sql_createTable = @"CREATE TABLE contactsInfo ('contactsInfoId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(30), 'brief' text, 'picURL' text)";
static NSString *const sql_insert = @"INSERT INTO contactsInfo (name, brief, picURL) VALUES (?, ?, ?)";
static NSString *const sql_update = @"UPDATE contactsInfo SET name = ?, brief = ?, picURL = ? WHERE contactsInfoId = ?";
static NSString *const sql_delete = @"DELETE FROM contactsInfo WHERE contactsInfo = ?";
static NSString *const sql_querry = @"SELECT * FROM contactsInfo";

@implementation ZRKDBManager

- (instancetype)initWithDataBaseFileName:(NSString *)dbFileName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    _dbFileName = dbFileName;
    _dbPath = [documentPath stringByAppendingPathComponent:_dbFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_dbPath]) {
        //create db
        FMDatabase *db = [FMDatabase databaseWithPath:_dbPath];
        if ([db open]) {
            NSString *sql = sql_createTable;
            
            //all sqls are executeUpdate except "select"
            BOOL succ = [db executeUpdate:sql];
            if (!succ) {
                NSLog(@"error when creating table");
            } else {
                NSLog(@"succ creating table");
            }
            [db close];
        } else {
            NSLog(@"error when opening database");
        }
    } else {
        NSLog(@"db exist");
    }
    return self;
}

#pragma mark - API

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

- (BOOL)insertContactsModel:(ZRKContactsModel *)model {
    NSMutableArray *mutArrary = [NSMutableArray arrayWithObjects:model.name, model.brief, model.picUrl, nil];
    BOOL succ = [self insertDataWithArray:mutArrary];
    return succ;
}

- (BOOL)updateContactsModel:(ZRKContactsModel *)model {
    NSMutableArray *mutArray = [NSMutableArray arrayWithObjects:model.name, model.brief, model.picUrl, [NSNumber numberWithInt: model.userId], nil];
    BOOL succ = [self updateDataWithArray:mutArray];
    return succ;
}

#pragma mark - Base

// ZARKY HERE TO DO BUG
// CANNOT UPDATE
// MAYBE BECAUSE THE USERID
// 没把insert结果回传给model

- (BOOL)insertDataWithArray:(NSArray *)dataArray {
    FMDatabase *db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        BOOL succ = [db executeUpdate:sql_insert withArgumentsInArray:dataArray];
        [db close];
        if (!succ) {
            NSLog(@"error when inserting data: %@", [db lastErrorMessage]);
            return NO;
        } else {
            NSLog(@"succ insert affected %d rows", [db changes]);
            return YES;
        }
        
    }
    return NO;
}

// ZARKY HERE TO DO BUG
// CANNOT UPDATE
// MAYBE BECAUSE THE USERID

- (BOOL)updateDataWithArray:(NSArray *)dataArray {
    FMDatabase *db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        BOOL succ = [db executeUpdate:sql_update withArgumentsInArray:dataArray];
        [db close];
        if (!succ) {
            NSLog(@"error when updating data: %@", [db lastErrorMessage]);
            return NO;
        } else {
            NSLog(@"succ update affected %d rows", [db changes]);
            return YES;
        }
    }
    return NO;
}

- (void)deleteDataWithArray:(NSArray *)dataArrary {
    FMDatabase *db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        BOOL succ = [db executeUpdate:sql_delete withArgumentsInArray:dataArrary];
        if (!succ) {
            NSLog(@"error when deleting data: %@", [db lastErrorMessage]);
        } else {
            NSLog(@"succ delete affected %d rows", [db changes]);
        }

    }
}

- (NSMutableArray *)queryData {
    FMDatabase *db = [FMDatabase databaseWithPath:_dbPath];
    NSMutableArray *resArray = [NSMutableArray array];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:sql_querry];
        while ([rs next]) {
            NSMutableArray *rowArray = [NSMutableArray array];
            for (int idx = 0; idx < rs.columnCount; idx++) {
                [rowArray addObject:[rs objectForColumnIndex:idx]];
                NSLog(@"queryresults: %@", [rs objectForColumnIndex:idx]);
            }
            [resArray addObject:rowArray];
        }
        [db close];
    }
    return resArray;
}

@end
