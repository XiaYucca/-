//
//  setMaskView.h
//  XYCoreBlueToothDemo
//
//  Created by RainPoll on 16/1/16.
//  Copyright © 2016年 RainPoll. All rights reserved.
//


#import <UIKit/UIKit.h>



@interface HMView : UIView
//开放一个属性用于接收从控制器传过来的线宽
@property(nonatomic,assign)CGFloat lineWidth;

@property(nonatomic,assign) CGFloat speed;
//开放一个属性接收控制器传过来的颜色
@property(nonatomic,strong) UIColor * lineColor;


@property(nonatomic,assign) BOOL isEnable;


@property(nonatomic,copy)CGFloat(^lineWidthBlock)();

-(void)clear;
-(void)back;
-(void)erase;
-(void)save;
-(void)reStart;

-(void)touchOutsideView:(void (^)(CGPoint p ,BOOL *stop)) outsideBlock;

@end
