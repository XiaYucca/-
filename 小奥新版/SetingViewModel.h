//
//  SetingViewModel.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SetingView;

@interface SetingViewModel : NSObject

@property (nonatomic, assign)BOOL enableVoice;
@property (nonatomic ,assign)BOOL enableMusic;
@property (nonatomic ,assign)BOOL isChinese;

@property (nonatomic ,weak,getter=view)SetingView *view;
@property (nonatomic ,copy)BOOL(^viewWillDissmiss)(SetingView *view);
@property (nonatomic ,copy)void(^viewWillShow)(SetingView *view);
@property (nonatomic ,copy)void (^clickBtn)(id sender);

-(void)setingViewWillDissmiss:(BOOL(^)(SetingView *view))viewWillDissmiss;
-(void)setingViewWillShow:(void(^)(SetingView *view))viewWillShow;
-(void)setintViewClickBtn:(void (^)(id sender))clickBtn;

@end
