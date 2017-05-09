//
//  Drawomg.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DrawingViewModel;

@interface DrawingView : UIView
@property(nonatomic ,strong)DrawingViewModel *model;

@property(nonatomic ,copy)void(^dismiss)(void);

-(void)dismissDrawingView:(void(^)(void))callback;

@end
