//
//  DrawingViewModel.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/9.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DrawingView;

@interface DrawingViewModel : NSObject

@property (nonatomic, weak,readonly)DrawingView *view;

-(void)didDissmissDrawingView:(void(^)(UIView *view))callback;

@end
