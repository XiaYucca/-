//
//  DataStore.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DataStore.h"
#import "FMDB.h"

@interface DataStore ()

@property(nonatomic ,strong)FMDatabase *db;
@end

@implementation DataStore

-(void)initFmdb{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        db = nil;
        return;
    }
    self.db = db;
}

-(FMDatabase *)creatTable{
    static int tableId = 1;
    NSString *orginPath = NSTemporaryDirectory();
    
    NSString *path = [orginPath stringByAppendingPathComponent: [NSString stringWithFormat:@"table_%i",tableId]];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    NSString *contentTableName = @"content";
    
    NSLog(@"path:%@",path);
    if (![db open]) {
        db = nil;
        return db;
    }
    
    
    FMDatabase *db_base = [FMDatabase databaseWithPath:[orginPath stringByAppendingPathComponent:@"table_0.db"]];
    if (![db_base open]) {
        db_base = nil;
        return db;
    }
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",interval];
    NSLog(@"timeStemp:%@",timeStr);
    
    BOOL success = [db_base executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_Base (id INTEGER PRIMARY KEY AUTOINCREMENT, time TEXT NOT NULL, content TEXT NOT NULL,  path TEXT NOT NULL)"];
    if (success) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
    BOOL success_insert = [db_base executeUpdate:@"INSERT INTO Table_Base (time, content, path) VALUES (?, ?, ?);", timeStr, contentTableName, path];
    if (success_insert) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
    FMResultSet *result = [db_base executeQuery:@"SELECT id, time, content, path FROM Table_Base;"];
    while ([result next]) {
        int ID = [result intForColumnIndex:0];
        NSString *time = [result stringForColumn:@"time"];
        NSString *path = [result stringForColumn:@"path"];
        NSString *content= [result stringForColumn:@"content"];
        NSLog(@"ID: %zd, time: %@, path: %@ content:%@" , ID, time, path, content);
    }
//    BOOL result_close = [db_base close];
//    if (result_close) {
//        NSLog(@"table close successed");
//    }else{
//        NSLog(@"table close faild");
//    }
    
    //查询sql 最后一条记录
    FMResultSet *result_last = [db_base executeQuery:@"select * from Table_Base limit 1 offset (select count(*) - 1  from Table_Base);"];
//  FMResultSet *result_last = [db_base executeQuery:@"SELECT id, time, content, path FROM Table_Base ORDER BY id desc;"];
    
    while ([result_last next]) {
        int ID = [result_last intForColumnIndex:0];
        NSString *time = [result_last stringForColumn:@"time"];
        NSString *path = [result_last stringForColumn:@"path"];
        NSString *content= [result_last stringForColumn:@"content"];
        NSLog(@"last ++++++++\n ID: %zd, time: %@, path: %@ content:%@" , ID, time, path, content);
    }
    
    BOOL result_close = [db_base close];
    
    if (result_close) {
        NSLog(@"table close successed");
    }else{
        NSLog(@"table close faild");
    }
    
    return db;
}

-(void)test{
    
    [self creatTable];
    return;

    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp1.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    NSLog(@"path:%@",path);
    if (![db open]) {
        db = nil;
        return;
    }
    self.db = db;
    BOOL success = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER DEFAULT 1, icon BLOB)"];
    if (success) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
    NSData *data = [@"test nsstring data write to sqllite" dataUsingEncoding:NSUTF8StringEncoding];
    
    
    BOOL success_insert = [self.db executeUpdate:@"INSERT INTO t_student (name, age , icon) VALUES (?, ?, ?);", @"jack", @(10), data];
    if (success_insert) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
    FMResultSet *result = [self.db executeQuery:@"SELECT id ,name, age, icon FROM t_student;"];
    while ([result next]) {
        int ID = [result intForColumnIndex:0];
        NSString *name = [result stringForColumn:@"name"];
        int age = [result intForColumn:@"age"];
        NSData *data = [result dataForColumn:@"icon"];
        NSLog(@"ID: %zd, name: %@, age: %zd, data: %@" , ID, name, age, data);
    }
    BOOL result_close = [self.db close];
    if (result_close) {
        NSLog(@"table close successed");
    }else{
        NSLog(@"table close faild");
    }
    /*
    // 插入数据
    int time = 20;
    while (time--) {
        static NSInteger age = 10;
        age++;
        
        BOOL success_insert = [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", @"jack", @(age)];
        
        if (success_insert) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }

    // 删除数据
    BOOL success_delete = [self.db executeUpdate:@"DELETE FROM t_student WHERE age > 20 AND age < 25;"];
    
    // 修改数据
    BOOL success_update = [self.db executeUpdate:@"UPDATE t_student SET name = 'liwx' WHERE age > 12 AND age < 15;"];
    
    
    // 查询数据
    FMResultSet *result = [self.db executeQuery:@"SELECT id, name, age FROM t_student WHERE id > 0;"];
    
    while ([result next]) {
        int ID = [result intForColumnIndex:0];
        NSString *name = [result stringForColumn:@"name"];
        int age = [result intForColumn:@"age"];
        
        NSLog(@"ID: %zd, name: %@, age: %zd", ID, name, age);
    }
    */
}

//插入数据
- (void) addData:(NSString *)name age:(NSInteger) age sex:(NSString *)sex avtar:(NSData*)data{
    if ([_db open]) {
        NSString *sql =@"INSERT INTO t_student(name, age, sex, avtar) VALUES (?, ?, ?, ?)";
        BOOL bResult = [_db executeUpdate:sql, name, @(age), sex, data];
        //
        //注意：
        //1、使用executeUpdate:sql的参数必须是NSObject类型(见上面的age)，否者会报EXC_BAD_ACCESS
        //2、上面的语句不要这么写，这么写是无法保存二进制的（没二进制数据的时候是可以）
        //  NSString *sql = [NSString stringWithFormat:@"INSERT INTO student(name, age, sex, avtar) VALUES ('%@', '%ld', '%@', '%@')", name, (long)age,  //sex, data];
        //  BOOL bResult = [_db executeUpdate:sql];
        
        if(bResult) {
            NSLog(@"数据插入成功！");
        }
        else {
            NSLog(@"数据插入失败！");
        }
    }
    [_db close];
}

//获取数据
- (void) getData {
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_student"];
        FMResultSet *resultSet = [_db executeQuery:sql];
        
        while ([resultSet next]) {
            NSString *name = [resultSet stringForColumn:@"name"];
            NSInteger age = [resultSet intForColumn:@"age"];
            NSString *sex = [resultSet stringForColumn:@"sex"];
            NSData *data = [resultSet dataForColumn:@"avtar"];
            //UIImage *image = [UIImage imageWithData:data];
        }
    }
    [_db close];
}




@end
