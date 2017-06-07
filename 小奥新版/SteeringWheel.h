//
//  SteeringWheel.h
//  AlsRobot_4WD
//
//  Created by RainPoll on 16/7/2.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

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


@interface SteeringWheel : UIView

@property (nonatomic, strong)UIImage *bgImage;

@property (nonatomic, strong)UIImage *btnImage;

@property (nonatomic, strong)UIImage *btnDrgImage;

@property (nonatomic ,copy)void(^didDrag)(DERICTION der);


-(void)didDidDrag:(void(^)(DERICTION der))didDrag;


@end
