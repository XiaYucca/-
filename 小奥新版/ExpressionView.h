//
//  ExpressionView.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/9.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExpressionViewModel;

typedef enum : NSUInteger {
    BTN_TAG_0 = 1000,
    BTN_TAG_1 = 2000,
    BTN_TAG_2 = 3000,
    BTN_TAG_3 = 4000,
    BTN_TAG_4 = 5000,
    BTN_TAG_5 = 6000,
} BTN_TAG;

@interface ExpressionView : UIView
@property(nonatomic ,strong)ExpressionViewModel *model;

@end
