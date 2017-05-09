//
//  DrawingViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/9.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DrawingViewModel.h"
@interface DrawingViewModel()

@property (nonatomic ,copy)void(^didDissmissCallBack)(UIView *view);

@end

@implementation DrawingViewModel

-(void)didDissmissDrawingView:(void(^)(UIView *view))callback{
    self.didDissmissCallBack = callback;
}


@end
