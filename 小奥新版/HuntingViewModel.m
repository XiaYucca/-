//
//  HuntingViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "HuntingViewModel.h"
@interface HuntingViewModel()

@property(nonatomic ,copy)BOOL(^willShowCallback)(UIView *v);
@property(nonatomic ,copy)BOOL(^willDissmissCallback)(UIView *v);

@property(nonatomic ,copy)void(^helpBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^setBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^voiceBtnClickCallback)(UIButton *btn);

@end
@implementation HuntingViewModel

-(void)willDissmiss:(BOOL(^)(UIView *v))callback{
    self.willDissmissCallback = callback;
}
-(void)willShow:(BOOL(^)(UIView *v))callback{
    self.willShowCallback = callback;
}

-(void)helpBtnClick:(void(^)(UIButton *btn))callback{
    self.helpBtnClickCallback = callback;
}
-(void)setBtnClick:(void(^)(UIButton *btn))callback{
    self.setBtnClickCallback = callback;
}
-(void)voiceBtnClick:(void(^)(UIButton *btn))callback{
    self.voiceBtnClickCallback = callback;
}


@end
