//
//  ProgramView.h
//  小奥新版
//
//  Created by RainPoll on 2017/7/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramView : UIView
@property (nonatomic, copy)void (^ _Nullable jsToIOSAlertCallback)(UIAlertController * _Nullable ac);

@property (nonatomic, copy)void (^ _Nullable jsToBackCallback)(void (^ complite)(id info));

@end
