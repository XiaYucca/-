//
//  MainView.h
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainViewModel;

@interface MainView : UIView

@property (nonatomic ,strong)MainViewModel *model;
+(instancetype)MainView:(CGRect)frame;


@end
