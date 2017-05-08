//
//  LittleItem.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 16/7/1.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import "LittleItem.h"

#define defalutColor  [UIColor colorWithRed:0x00/255.0 green: 0x80/255.0 blue:0xdd/255.0 alpha:1]
#define selectColor  [UIColor colorWithRed:0xff/255.0 green: 0x8b/255.0 blue:0x98/255.0 alpha:1]

//
//#define defalutColor  [UIColor lightGrayColor]
//#define selectColor   [UIColor colorWithRed:0x00/255.0 green: 0x80/255.0 blue:0xdd/255.0 alpha:1]

@implementation LittleItem



-(void)setSetOn:(BOOL)setOn
{
    if (_setOn != setOn) {
        
        _setOn = setOn;
        _setOn ?  [self setBackgroundColor:selectColor]:[self setBackgroundColor:defalutColor];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            self.transform = CGAffineTransformIdentity;
        }];
    }
}

-(void)drawRect:(CGRect)rect
{
//    NSLog(@"tag : %lu 创建了",self.tag);
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
////    self.backgroundColor = [UIColor blueColor];
//    
//    NSLog(@"开始 点击到了----%lu",self.tag);
//}

//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//  //  [super touchesMoved:touches withEvent:event];
//    NSLog(@"开始 移动");
//}


@end
