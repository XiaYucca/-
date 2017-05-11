//
//  DataStore.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DataStore.h"
#import "FMDB.h"

@implementation DataStore


-(void)initFmdb{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        db = nil;
        return;
    }
}

@end
