//
//  VoiceViewModel.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VoiceView;

@interface VoiceViewModel : NSObject

@property (nonatomic, weak ,readonly) VoiceView *view;


-(void)willDissmiss:(BOOL(^)(UIView *v))callback;
-(void)willShow:(BOOL(^)(UIView *v))callback;

-(void)helpBtnClick:(void(^)(UIButton *btn))callback;
-(void)setBtnClick:(void(^)(UIButton *btn))callback;
-(void)voiceBtnClick:(void(^)(UIButton *btn))callback;


@end
