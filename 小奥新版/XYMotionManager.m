//
//  XYAudio.h
//  XYCoreBlueToothDemo
//
//  Created by RainPoll on 15/12/31.
//  Copyright © 2015年 RainPoll. All rights reserved.
//

#import "XYMotionManager.h"


/**
 1. 静态的全局实例
 2. allocWithZone
 3. 定义一个shared方法，供全局使用
 */

// 保存当前类的实例
static XYMotionManager *_instance;

@implementation XYMotionManager

+ (instancetype)shareMotionManager
{
    if (_instance == nil) {
        _instance  = [[[self class] alloc] init];
    }
    return _instance;
}

#pragma mark - 以下方法是为了保证对象在任何情况下都唯一
//    调用alloc的时候会调用这个方法
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    //  保证我们的block只能执行一次
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
//会在调用copy的时候调用这个方法
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

//在调用mutableCopy的时候调用这个方法
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return self;
}


-(void)accelerometerUpdateInterval:(CGFloat)updateInterval CallBack:(void(^)(XYacceleration acceleration, NSError *error))callBack
{
    if (self.isDeviceMotionAvailable) {
        self.accelerometerUpdateInterval = updateInterval;
        [self startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            XYacceleration acceleratoin;
            acceleratoin.X = accelerometerData.acceleration.x;
            acceleratoin.Y = accelerometerData.acceleration.y;
            acceleratoin.Z = accelerometerData.acceleration.z;
            
            
            !callBack ? : callBack(acceleratoin ,error);
        }];
    }
    else
    {
        NSLog(@"加速度计不可用");
    }

}

-(void)accelerometerUpdateInterval:(CGFloat)updateInterval NSOperationQueue:(NSOperationQueue *)queue CallBack:(void(^)(XYacceleration acceleration, NSError *error))callBack
{
    if (self.isDeviceMotionAvailable) {
        self.accelerometerUpdateInterval = updateInterval;
        [self startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            XYacceleration acceleratoin;
            acceleratoin.X = accelerometerData.acceleration.x;
            acceleratoin.Y = accelerometerData.acceleration.y;
            acceleratoin.Z = accelerometerData.acceleration.z;
            
            !callBack ? : callBack(acceleratoin ,error);
        }];
    }
    else
    {
        NSLog(@"加速度计不可用");
    }
}

-(void)stopAccelerometerUpdatesWithCallBack:(void(^)())callBack
{
    [self stopAccelerometerUpdates];
    
    !callBack ? : callBack();
}




@end
