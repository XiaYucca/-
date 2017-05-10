//
//  ConnectView.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/20.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ConnectView.h"

typedef enum : NSUInteger {
    UP,
    LEFT,
    DOWN,
    RIGHT
} WAVEDERECT;

#define minRadius 45
#define maxRadius 200

@interface BlueAnimattionView : UIView
@end

@implementation BlueAnimattionView

-(void)drawRect:(CGRect)rect{
    NSLog(@"%@",self);
    __weak typeof(self) weakself = self;
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static int count = 0;
        NSLog(@"time +++");
        if (count++ >= 5) {
            [timer invalidate];
            NSLog(@"time over");
        }else{
            [weakself addWave:LEFT];
            [weakself addWave:RIGHT];
        }
    }];
}

-(void)addWave:(WAVEDERECT)derect{
    
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.position = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    shaperLayer.bounds = self.bounds;
    //    shaperLayer.anchorPoint = CGPointMake(0, 0);
    
    shaperLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    //UIGraphicsPopContext();
    
    float startAngle = -M_2_PI;
    float endAngle = M_2_PI;
    
    switch (derect) {
        case UP:
             startAngle = -M_2_PI*3;
             endAngle = -M_2_PI;
            break;
        case LEFT:
            startAngle = -M_2_PI;
            endAngle = M_2_PI;
            break;
        case DOWN:
            startAngle = M_2_PI;
            endAngle =  M_2_PI*3;
            break;
        case RIGHT:
            startAngle = M_2_PI*4;
            endAngle = M_2_PI*6;
            break;
            
        default:
            break;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:shaperLayer.position radius:minRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    shaperLayer.path = path.CGPath;
    UIColor *strokeColor = [UIColor colorWithDisplayP3Red:47/255.0 green:169/255.0 blue:255/255.0 alpha:0.9];
    
    shaperLayer.strokeColor =  strokeColor.CGColor;
    shaperLayer.lineWidth = 2.0;
    shaperLayer.fillColor = [UIColor clearColor].CGColor; // 137 222 254
    shaperLayer.opacity = 0.6;
    
 //   [self.layer insertSublayer:shaperLayer atIndex:self.layer.sublayers.count];
   // self.layer insertSublayer:<#(nonnull CALayer *)#> above:<#(nullable CALayer *)#>
    
    NSLog(@"subLayers%@",self.layer.sublayers);
    
    [self.layer addSublayer:shaperLayer];
    
    CABasicAnimation *baseAnimator = [CABasicAnimation animationWithKeyPath:@"path"];
    
    UIBezierPath *toPath = [UIBezierPath bezierPathWithArcCenter:shaperLayer.position radius:maxRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    baseAnimator.fromValue = (__bridge id)path.CGPath;
    baseAnimator.toValue = (__bridge id)toPath.CGPath;
    baseAnimator.duration = 5.0;
    baseAnimator.repeatCount = INTMAX_MAX;
    baseAnimator.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    CABasicAnimation *baseOpacityAnimator = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    baseOpacityAnimator.fromValue = @1.0;
    baseOpacityAnimator.toValue = @0.0;
    baseOpacityAnimator.duration = 5.0;
    baseOpacityAnimator.repeatCount = INTMAX_MAX;

    [shaperLayer addAnimation:baseAnimator forKey:@""];
    [shaperLayer addAnimation:baseOpacityAnimator forKey:@"baseOpacityAnimator"];
}

@end


@interface ConnectView ()
@property(nonatomic ,weak)IBOutlet UIView *view;
@property(nonatomic ,weak)IBOutlet BlueAnimattionView *blueAnimationView;
@end

@implementation ConnectView


-(void)awakeFromNib{
    [super awakeFromNib];
    [self initFromNib];
}

-(void)initFromNib{
    [[NSBundle mainBundle]loadNibNamed:@"ConnectView" owner:self options:nil];
    [self addSubview:self.view];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}
@end





//@end
