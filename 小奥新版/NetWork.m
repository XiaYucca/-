//
//  NetWork.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/17.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"

@implementation NetWork

+(instancetype)network{
    static NetWork *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(instancetype)netWork{
    return [NetWork network];
}

-(void)test{

//    dispatch_release(group);
//    dispatch_release(semaphore);
    
}


@end
