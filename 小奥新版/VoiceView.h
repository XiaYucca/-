//
//  VoiceView.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VoiceViewModel;

@interface VoiceView : UIView
@property (nonatomic ,strong)VoiceViewModel *model;

+(instancetype)voiceViewWithFrame:(CGRect)frame;

@end
