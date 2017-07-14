//
//  XYAudio.h
//  XYCoreBlueToothDemo
//
//  Created by RainPoll on 15/12/31.
//  Copyright © 2015年 RainPoll. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import <CoreGraphics/CoreGraphics.h>

typedef struct{
    CGFloat X;
    CGFloat Y;
    CGFloat Z;
}XYacceleration;

@interface XYMotionManager : CMMotionManager

+ (instancetype)shareMotionManager;

-(void)accelerometerUpdateInterval:(CGFloat)updateInterval CallBack:(void(^)(XYacceleration acceleration, NSError *error))callBack;

-(void)accelerometerUpdateInterval:(CGFloat)updateInterval NSOperationQueue:(NSOperationQueue *)queue CallBack:(void(^)(XYacceleration acceleration, NSError *error))callBack;

-(void)stopAccelerometerUpdates;
-(void)startAccelerometerUpdates;

@end
