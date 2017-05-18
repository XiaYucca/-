//
//  VoicesViewController.h
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/1/10.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDirectionCalculate.h"


typedef enum {
    WHEEL_ORIGOIN = 0,
    WHEEL_LEFT,
    WHEEL_LEFT_UP,
    WHEEL_UP,
    WHEEL_RIGHT_UP,
    WHEEL_RIGHT,
    WHEEL_RIGHT_DOWN,
    WHEEL_DOWN,
    WHEEL_LEFT_DOWN,
}DERICTION ;

@interface VoicesViewController : UIViewController

-(void)startRecognitionWithoutUI;
-(void)endRecongnitionWithInstraction:(void(^)(DERICTION deric))callback;

-(void)endRecongnitionWithString:(void(^)(NSString *result))recongnitionString;

-(void)endMetchWithString:(void(^)(NSArray *result))metchBlock;

-(void)speakEnd;

@end
