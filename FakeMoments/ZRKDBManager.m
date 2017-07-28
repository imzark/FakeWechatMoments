//
//  ZRKDBManager.m
//  FakeMoments
//
//  Created by Zark on 2017/7/19.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKDBManager.h"
#import <FMDB.h>

@interface ZRKDBManager()

@property (nonatomic, strong) NSString *dbFileName;
@property (nonatomic, strong) NSString *dbPath;

@end

static NSString *const sql_createTable = @"CREATE TABLE contactsInfo ('contactsInfoId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(30), 'picPath' text, 'picURL' text)";
static NSString *const sql_insert = @"INSERT INTO contactsInfo (name, picPath, picURL) VALUES (?, ?, ?)";
static NSString *const sql_update = @"UPDATE contactsInfo SET name = ?, picPath = ?, picURL = ? WHERE contactsInfoId = ?";
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

- (void)insertDataWithDic:(NSDictionary *)dataDic {
    //todo
}

- (void)insertDataWithArray:(NSArray *)dataArray {
    FMDatabase *db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        BOOL succ = [db executeUpdate:sql_insert withArgumentsInArray:dataArray];
        
        if (!succ) {
            NSLog(@"error when inserting data: %@", [db lastErrorMessage]);
        } else {
            NSLog(@"succ insert affected %d rows", [db changes]);
        }
        [db close];
    }
}

- (void)updateDataWithArray:(NSArray *)dataArray {
    FMDatabase *db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        BOOL succ = [db executeUpdate:sql_update withArgumentsInArray:dataArray];
        if (!succ) {
            NSLog(@"error when updating data: %@", [db lastErrorMessage]);
        } else {
            NSLog(@"succ update affected %d rows", [db changes]);
        }

    }
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
