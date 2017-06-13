//
//  SteeringWheel.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 16/7/2.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import "SteeringWheel.h"
//#import "UIButton+BJMusic.h"
#import"XYDirectionCalculate.h"
//#import "UIPanGestureRecognizer.h"

#define DRBTN_NOMAL_R 40

#define MIN_EFFECTIVE_DISTANCE 0.2
#define MAX_EFFECTIVE_DISTANCE 0.6


@interface SteeringWheel ()<UIGestureRecognizerDelegate>

@property (nonatomic ,strong)UIPanGestureRecognizer *pan;
@property (nonatomic ,strong)UIButton *derictionBtn;

@property (nonatomic ,assign)CGPoint origionCenter;

@end

@implementation SteeringWheel


- (void)drawRect:(CGRect)rect {
    
    [self setupView];
}
-(void)setupView
{
    UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:imagV];
    _bgImage? imagV.image = _bgImage : nil;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, DRBTN_NOMAL_R, DRBTN_NOMAL_R)];
    
    [btn setBackgroundImage:self.btnDrgImage forState:UIControlStateNormal];
    btn.center = imagV.center;
    
  //  btn.backgroundColor = [UIColor blueColor];
    
    [btn addTarget:self action:@selector(dericionDown:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(dericionUp:) forControlEvents:UIControlEventTouchUpInside];
    
    self.derictionBtn = btn;
    
    [self addSubview:btn];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(derictionDrag:)];
    self.pan = pan;
    
    [self addGestureRecognizer:pan];
    
//    if ([btn respondsToSelector:@selector(setDisableAnimation:)]) {
//        [btn setDisableAnimation:YES];
//    }
    
    self.origionCenter = btn.center;
}

-(void)didDidDrag:(void(^)(DERICTION der))didDrag
{
    self.didDrag = didDrag;
}

-(void)dericionDown:(id)sender
{
    self.derictionBtn.transform = CGAffineTransformMakeScale(1.3, 1.3) ;
    [UIView animateWithDuration:0.3 animations:^{
          self.alpha = 0.6;
    }];
  
}
-(void)dericionUp:(id)sender
{
    self.derictionBtn.transform = CGAffineTransformIdentity ;
    self.alpha = 1;
}

-(void)setAngle:(float)angle{
    if (angle < - 0.999) {
        return;
    }
    if (_angle != angle) {
        // 1.在view上面挪动的距离
        CGPoint translation = CGPointMake(cos(angle) * self.frame.size.width * MAX_EFFECTIVE_DISTANCE*0.5 , sin(angle) * self.frame.size.width * MAX_EFFECTIVE_DISTANCE*0.5);
        
        CGPoint center = self.origionCenter;
        self.derictionBtn.center = getLocationWithTranslation(center, translation, self.frame.size.width * MIN_EFFECTIVE_DISTANCE * 0.5, self.frame.size.width * MAX_EFFECTIVE_DISTANCE*0.5);
    
        NSInteger result = [self autoSendOrderWithTranslation:translation];
        _angle = angle;
    }
}

- (void)derictionDrag:(UIPanGestureRecognizer *)sender {
    static int i = 0;
    static NSInteger oldresult = 0;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"开始拖拽");
            break;
            
        case UIGestureRecognizerStateEnded:
            NSLog(@"结束拖拽");
            self.derictionBtn.transform = CGAffineTransformIdentity ;

            [sender setTranslation:CGPointZero inView:sender.view];
            
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 1;
            }];

            break;
            
    }
    
    // 1.在view上面挪动的距离
    CGPoint translation = [sender translationInView:sender.view];
    CGPoint center = self.origionCenter;
    
    self.derictionBtn.center = getLocationWithTranslation(center, translation, self.frame.size.width * MIN_EFFECTIVE_DISTANCE * 0.5, self.frame.size.width * MAX_EFFECTIVE_DISTANCE*0.5);
    
    
    if (!(i % 8)) {
        NSInteger result = [self autoSendOrderWithTranslation:translation];
        if (oldresult != result) {
//            [self.xyAudio replayMusicAtIndex:2];

        }
        oldresult = result;
    }i++;
    
}

#pragma mark  计算坐标 并发送数据
-(NSInteger)autoSendOrderWithTranslation:(CGPoint)translation
{   static BOOL stop = NO;
    
    DERICTION D = WHEEL_ORIGOIN;
    
    CGFloat r = getAngleWithVector(translation);
    int result = getDeriction(r);
    
    NSLog(@" angle --%f   v --%d",r,result);
    //只运行一次
    if (result == 0) {
        if (stop == NO) {
            [self sendStr:@"s"];
            stop = YES;
        }
    }
    else{
        stop = NO;
        switch (result) {
            case 0:
                //       [self sendStr:@"s"];
                
                D = WHEEL_ORIGOIN;
                break;
            case 1:
                [self sendStr:@"d"];
                D = WHEEL_LEFT;
                break;
            case 2:
                [self sendStr:@"e"];
                  D = WHEEL_LEFT_UP;
                break;
            case 3:
                [self sendStr:@"w"];
                  D = WHEEL_UP;
                break;
            case 4:
                [self sendStr:@"q"];
                  D = WHEEL_RIGHT_UP;
                break;
            case 5:
                [self sendStr:@"a"];
                  D = WHEEL_RIGHT;
                break;
            case 6:
                [self sendStr:@"z"];
                  D = WHEEL_RIGHT_DOWN;
                break;
            case 7:
                [self sendStr:@"x"];
                  D = WHEEL_DOWN;
                break;
            case 8:
                [self sendStr:@"c"];
                  D = WHEEL_LEFT_DOWN;
                break;
                
            default:
                break;
        }
    }
    
    !self.didDrag ?: self.didDrag(D);
    
    return result;
}

-(void)sendStr:(NSString *)str
{

}

@end
