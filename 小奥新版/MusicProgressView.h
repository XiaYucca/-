//
//  MusicProgressView.h
//  AlsRobot_4WD
//
//  Created by RainPoll on 16/8/11.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicProgressView : UIView

@property (nonatomic , assign)CGFloat value;

+(instancetype)musicProgresssView;

-(void)didChangleValue:(void(^)(CGFloat value))callback;

-(void)stopBtnCallback:(void (^)(void))callBack;

-(void)forwardBtnCallback:(void(^)(void))calllBack;

-(void)backwardBtnCallback:(void(^)(void))callBack;

@end
