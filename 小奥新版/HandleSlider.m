//
//  HandleSlider.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/7.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "HandleSlider.h"


@interface HandleSlider ()
//@property (weak, nonatomic) IBOutlet UIPanGestureRecognizer *pan;

@property (nonatomic ,weak)IBOutlet UIButton *processBtn;
@property (nonatomic ,weak)IBOutlet UIPanGestureRecognizer *panGesture;
@property (nonatomic ,copy)void(^didchangleCallBack)(CGFloat value);

@end

@implementation HandleSlider
@synthesize progress = _progress;

-(CGFloat)progress{
    CGFloat helf = self.frame.size.height * 0.5;
    CGFloat maxY = (helf - 17);
    CGFloat p = (self.centY.constant + maxY ) / (self.frame.size.height - 34);
    return p;
}

-(void)setProgress:(CGFloat)progress{
    if (progress > 1.0) {
        progress = 1.0;
    }
    if (progress < 0.0) {
        progress = 0.0;
    }
    
    CGFloat helf = self.frame.size.height * 0.5;

    CGFloat maxY = (helf - 17);
    CGFloat minY = -(helf - 17);
    CGFloat dp = progress * (self.frame.size.height - 34);
    
    CGFloat dc = dp + minY;
    self.centY.constant = dc;
}

+(instancetype)handleSlider{
    return [[[NSBundle mainBundle]loadNibNamed:@"HandleSlider" owner:nil options:nil]firstObject];
}

-(void)awakeFromNib{

    [self.panGesture addTarget:self action:@selector(panAction:)];
    self.progress = 0.5;
}

-(void)sliderDidChangleValue:(void (^)(CGFloat))callback{
    self.didchangleCallBack = callback;
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    if (pan.state) {
        switch (pan.state) {
            case UIGestureRecognizerStateBegan:
                
                self.processBtn.transform = CGAffineTransformMakeScale(1.5, 1.5);
                break;
            case UIGestureRecognizerStateEnded:
                self.processBtn.transform = CGAffineTransformIdentity;
                break;
            default:
                break;
        }
    }
    CGPoint dp = [pan locationInView:self];
    XLog(@"dp :%@",NSStringFromCGPoint(dp));
    
    CGFloat oy = dp.y;
    CGFloat helf = self.frame.size.height * 0.5;
    
    CGFloat dy = oy-helf;
    CGFloat minY = -(helf - 17);
    CGFloat maxY = (helf - 17);
    
    if (dy > minY && dy < maxY) {
        self.centY.constant = dy;
    }
    
    if (self.didchangleCallBack) {
        
        self.didchangleCallBack(self.progress);
        
    }

//    if (dp.y > 0 && dp.y < self.frame.size.height) {
//        self.processBtn.center = CGPointMake(self.processBtn.center.x, dp.y);
//    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
