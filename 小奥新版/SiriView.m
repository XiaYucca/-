//
//  SiriView.m
//  VocieTest
//
//  Created by ddSoul on 16/11/7.
//  Copyright © 2016年 dxl. All rights reserved.
//
#import "NSMutableArray+Queue.h"
#import "SiriView.h"

@interface SiriView ()

@property (nonatomic) CAGradientLayer *gradientLayer;
@property (nonatomic) CAGradientLayer *gradientLayer_other;
@property (nonatomic, strong)NSMutableArray *queueArr;
/**
 移动相位
 */
@property (nonatomic) CGFloat phase;

/**
 振幅
 */
@property (nonatomic) CGFloat amplitude;
@property (nonatomic) NSMutableArray * waves;
@property (nonatomic) CGFloat waveHeight;
@property (nonatomic) CGFloat waveWidth;
@property (nonatomic) CGFloat waveMid;
@property (nonatomic) CGFloat maxAmplitude;
@property (nonatomic ,strong) CABasicAnimation *baseAnimate;

@end

@implementation SiriView{

    int  lineSpead;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initConfige];
        
//            CABasicAnimation *baseAnimate = [CABasicAnimation animationWithKeyPath:@"locations"];
//            baseAnimate.fromValue =  @[@(0.0), @(0.1),@(0.2)];
//            baseAnimate.toValue =  @[@(0.8),@(1.0),@(1.0)];
//            baseAnimate.repeatCount = HUGE;
//            baseAnimate.autoreverses = YES;
//        
//            baseAnimate.duration = 1.0;
//        
//            self.baseAnimate = baseAnimate;
//        
//            [self.gradientLayer addAnimation:baseAnimate forKey:@"LocationAnimation"];
//            NSLog(@"%@",baseAnimate);
        
      //  [self dwMakeBottomRoundCornerWithRadius:300];
    }
    
    return self;
}
-(void)setLineFlowSpead:(CGFloat)lineFlowSpead{
    if (lineFlowSpead < 0.5) {
        lineSpead = 1;
    }
    
    if (lineFlowSpead <0.3){
        lineSpead = 2;
    }
    
    if (lineFlowSpead < 0.2) {
        lineSpead = 4;
    }
    
    
    if (lineFlowSpead < 0.15) {
        lineSpead = 5;
    }
    if (lineFlowSpead < 0.1) {
        lineSpead = 6;
    }
    if (lineFlowSpead <0.09) {
        lineSpead = 8;
    }
    if (lineFlowSpead <0.08) {
        lineSpead = 10;
    }
     _lineFlowSpead = lineFlowSpead;
}

- (void)initConfige
{
    
    //主线
    _gradientLayer
    = [CAGradientLayer layer];
    _gradientLayer.frame    = self.bounds;
    _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    
    _gradientLayer.locations  = @[@(0.14),@(0.28), @(0.42), @(0.56),@(0.7),@(0.84)];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint  = CGPointMake(1, 0);
    
//    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"locations"];
//    an.fromValue = @[ @(0.0), @(0.1),@(0.2)];
//    an.toValue = @[ @(0.7), @(0.8),@(0.9)];
//    an.repeatCount = 1000;
//    an.duration = 2.0;
//    
//    [self.gradientLayer addAnimation:an forKey:nil];
 
    
    [self.layer addSublayer:_gradientLayer];
    
    //次线
    _gradientLayer_other = [CAGradientLayer layer];
    _gradientLayer_other.frame    = self.bounds;
    _gradientLayer_other.colors = @[(__bridge id)[UIColor greenColor].CGColor,
                                   (__bridge id)[UIColor purpleColor].CGColor,
                                   (__bridge id)[UIColor yellowColor].CGColor,
                                    (__bridge id)[UIColor purpleColor].CGColor,
                                   (__bridge id)[UIColor redColor].CGColor];
    
    _gradientLayer_other.locations  = @[@(0.2),@(0.4), @(0.6), @(0.8)];
    _gradientLayer_other.startPoint = CGPointMake(0, 0);
    _gradientLayer_other.endPoint  = CGPointMake(1, 0);
    [self.layer addSublayer:_gradientLayer_other];
    
    self.waves = [NSMutableArray new];
    
    self.frequency = 1.5f;
    
    self.amplitude = 1.0f;
    
    self.idleAmplitude = 0.0f;
    
    self.numberOfWaves = 6;
    
    self.phaseShift = -0.0f;
    
    self.density = 1.f;
    
    self.waveColor = [UIColor whiteColor];
    self.mainWaveWidth = 2.0f;
    self.decorativeWavesWidth = 0.05f;
    
    self.waveHeight = CGRectGetHeight(self.bounds) * 0.98;
    self.waveWidth  = CGRectGetWidth(self.bounds);
    self.waveMid    = self.waveWidth / 2.0f;
    self.maxAmplitude = self.waveHeight * 0.5;
    
    self.lineFlowSpead = 0.01;
    
    self.startWaveProgress = 0.2;
    
    
    self.queueArr = [[NSMutableArray alloc]init];;
    
    [self.queueArr unshift:(__bridge id)[UIColor yellowColor].CGColor];
    [self.queueArr unshift:(__bridge id)[UIColor greenColor].CGColor];
    [self.queueArr unshift:(__bridge id)[UIColor blueColor].CGColor];
    [self.queueArr unshift:(__bridge id)[UIColor purpleColor].CGColor];
    [self.queueArr unshift: (__bridge id)[UIColor redColor].CGColor];
    [self.queueArr unshift: (__bridge id)[UIColor orangeColor].CGColor];
    [self.queueArr unshift: (__bridge id)[UIColor yellowColor].CGColor];


}

//-(void)setStartWaveProgress:(CGFloat)startWaveProgress{
//    _startWaveProgress = startWaveProgress;
//    _waveWidth = (1 - 2*startWaveProgress)*_waveWidth;
//    _phase = _startWaveProgress ;
//    
//}

-(void)dwMakeBottomRoundCornerWithRadius:(CGFloat)radius

{
    
    CGSize size = self.frame.size;
    
    CAShapeLayer
    *shapeLayer = [CAShapeLayer
                   layer];
    
    [shapeLayer setFillColor:[[UIColor whiteColor]CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path,NULL,
                      size.width - radius, size.height);
    
    CGPathAddArc(path,NULL,
                 size.width-radius, size.height-radius, radius, M_PI/2,0.0,YES);
    
    CGPathAddLineToPoint(path,NULL,
                         size.width, 0.0);
    
    CGPathAddLineToPoint(path,NULL,0.0,0.0);
    
    CGPathAddLineToPoint(path,NULL,0.0,
                         size.height - radius);
    
    CGPathAddArc(path,NULL,
                 radius, size.height - radius, radius, M_PI, M_PI/2,YES);
    
    CGPathCloseSubpath(path);
    
    [shapeLayer setPath:path];
    
    CFRelease(path);
    
    self.layer.mask = shapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制
    
}

- (void)setSiriLevelCallback:(void (^)())siriLevelCallback
{
    _siriLevelCallback = siriLevelCallback;
    CADisplayLink *displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayCallFun)];

    
    [displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
  //  displaylink.frameInterval = 2;[
    
    for(int i=0; i < self.numberOfWaves; i++)
    {
        CAShapeLayer *waveline = [CAShapeLayer layer];
//        waveline.lineCap       = kCALineCapButt;
//        waveline.lineJoin      = kCALineJoinRound;
        waveline.strokeColor   = [[[UIColor whiteColor]colorWithAlphaComponent:0.9] CGColor];
        waveline.fillColor = [UIColor clearColor].CGColor;
     //   waveline.fillColor     = [[[UIColor whiteColor]colorWithAlphaComponent:0.1] CGColor];
        [waveline setLineWidth:(i==0 ? self.mainWaveWidth : self.decorativeWavesWidth)];
        CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
        CGFloat multiplier = MIN(1.0, (progress / 3.0f * 2.0f) + (1.0f / 3.0f));
        
//        waveline.strokeColor   = [[UIColor colorWithWhite:1.0 alpha:( i == 0 ? 1.0 : 1.0 * multiplier * 0.01)] CGColor];
//        waveline.fillColor   = [[UIColor colorWithWhite:1.0 alpha:( i == 0 ? 1.0 : 1.0 * multiplier * 0.6)] CGColor];
        
//      waveline.strokeColor = [[UIColor colorWithWhite:1.0 alpha:0.8]CGColor];
        [self.layer addSublayer:waveline];
        [self.waves addObject:waveline];
    }
}

-(void)displayCallFun{
    
    static int isOpen = 0;
  //  int  lineSpead = (int)(_lineFlowSpead);
  //  NSLog(@"=====%i",lineSpead);
    if (isOpen ++ > lineSpead) {
        id obj = [self.queueArr pop];
        [self.queueArr unshift:obj];
        self.gradientLayer.colors = self.queueArr;
        isOpen = 0;
    }
    
    if(_siriLevelCallback){
        _siriLevelCallback();
    }
    
//    NSMutableArray *arrDis = [@[] mutableCopy];
//    float m = self.value;
//    
//    for (int i = 0; i<len; i++) {
//        
//        [arrDis addObject:@(1 * (1.0/len * (i)))];
//    }
//    
//    
//    [arrDis addObject:@(1.0f)];
}

- (void)setLevel:(CGFloat)level
{
    _level = level;
    
    self.phase += self.phaseShift; // Move the wave
    
    self.amplitude = fmax( level, self.idleAmplitude);
    
    static int  i =0 ;
    //if(i++ >2){
        [self updateMeters];
    //    i = 0;
  //  }


}


- (void)updateMeters
{
    
    for(int i=0; i < self.numberOfWaves; i++) {
        
        
        UIBezierPath *wavelinePath = [UIBezierPath bezierPath];
        
        CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
        CGFloat normedAmplitude = (1.5f * progress - 0.5f) * self.amplitude;
        
//      NSLog(@"normedAmplitude %f",_amplitude);
//      if (_amplitude < 0.06) {
//            normedAmplitude = 0.0;
//      }
        
        CGFloat x= 0;
        
        for( x = 0; x<self.waveWidth + self.density; x += self.density) {
            
            CGFloat scaling = -pow(x / self.waveMid  - 1, 2) + 1; // make center bigger
            CGFloat y = self.waveHeight - 300;
            CGFloat d = x;
//    
//            if ((x< self.waveWidth * _startWaveProgress) || (x >self.waveWidth *(1-_startWaveProgress))) {
//                d =0;
//            }else{
//                d = x*(1-_startWaveProgress);
//            }
                // if(progress > 0.5){
                y = scaling * self.maxAmplitude * normedAmplitude * sinf(2 * M_PI *(d / self.waveWidth) * self.frequency + self.phase) + self.waveHeight*0.5;
                // }
                if (x==0) {
                    [wavelinePath moveToPoint:CGPointMake(x, y)];
                }
                else {
                    [wavelinePath addLineToPoint:CGPointMake(x, y)];
                }
        }
//        for( ; x>=0; x -= self.density) {
//            
//            CGFloat scaling = -pow(x / self.waveMid  - 1, 2) + 1; // make center bigger
//            CGFloat y = self.waveHeight*0.5 - scaling * self.maxAmplitude * normedAmplitude * sinf(2 * M_PI *(x / self.waveWidth) * self.frequency + self.phase);
//            
//            if (x==0) {
//               // [wavelinePath moveToPoint:CGPointMake(x, y)];
//            }
//            else {
//                [wavelinePath addLineToPoint:CGPointMake(x, y)];
//            }
//        }
        
//      [wavelinePath closePath];
        
        
//        [wavelinePath fill];
//        [wavelinePath closePath];
//        // 设置填充颜色
//        UIColor *fillColor = [UIColor greenColor];
//        [fillColor set];
//        [wavelinePath fill];
//        
//        // 设置画笔颜色
//        UIColor *strokeColor = [UIColor blueColor];
//        [strokeColor set];
//        
//        // 根据我们设置的各个点连线
//        [wavelinePath stroke];
        
      //  CGPathCloseSubpath(wavelinePath.CGPath);
        
        CAShapeLayer *waveline = [self.waves objectAtIndex:i];
        
        waveline.path = [wavelinePath CGPath];
        waveline.fillRule = kCAFillRuleEvenOdd;
        
//        waveline.fillColor = [UIColor whiteColor].CGColor;
//        waveline.strokeColor = [UIColor whiteColor].CGColor;
        if (i == 0) {
            _gradientLayer.mask = waveline;
        }else if(i >= 3){
            _gradientLayer_other.mask = waveline;
        }
    }
}

@end
