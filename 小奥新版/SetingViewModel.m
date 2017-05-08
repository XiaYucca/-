//
//  SetingViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "SetingViewModel.h"

@implementation SetingViewModel

-(instancetype)init{
    if (self = [super init]) {
        _enableMusic = YES;
        _enableVoice = YES;
        _isChinese = YES;
    }
    return self;
}

-(void)setingViewWillDissmiss:(BOOL(^)(SetingView *view))viewWillDissmiss{
    self.viewWillDissmiss = viewWillDissmiss;
}
-(void)setingViewWillShow:(void(^)(SetingView *view))viewWillShow{
    self.viewWillShow = viewWillShow;
}

-(void)setintViewClickBtn:(void (^)(id))clickBtn{
    self.clickBtn = clickBtn;
}


@end
