//
//  HandleSlider.h
//  小奥新版
//
//  Created by RainPoll on 2017/6/7.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandleSlider : UIView

@property (nonatomic ,weak) UIPanGestureRecognizer *pan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centY;

@property (nonatomic ,assign)CGFloat progress;

+(instancetype)handleSlider;

-(void)sliderDidChangleValue:(void(^)(CGFloat progress))callback;

@end
