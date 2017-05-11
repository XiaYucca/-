//
//  HuntingViewModel.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HuntingView;
@interface HuntingViewModel : NSObject
@property (nonatomic, weak ,readonly) HuntingView *view;


-(void)willDissmiss:(BOOL(^)(UIView *v))callback;
-(void)willShow:(BOOL(^)(UIView *v))callback;

-(void)helpBtnClick:(void(^)(UIButton *btn))callback;
-(void)setBtnClick:(void(^)(UIButton *btn))callback;
-(void)voiceBtnClick:(void(^)(UIButton *btn))callback;

@end
