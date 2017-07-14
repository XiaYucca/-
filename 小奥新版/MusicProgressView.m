//
//  MusicProgressView.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 16/8/11.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import "MusicProgressView.h"


#import "NSMutableArray+Queue.h"

@interface MusicProgressView ()<UIGestureRecognizerDelegate>
@property (nonatomic ,strong)CAGradientLayer *gradientLayer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingItem;

@property (weak, nonatomic) IBOutlet UIImageView *itemBack;
@property (weak, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;

@property (weak, nonatomic) IBOutlet UIButton *clickItem;

@property (weak, nonatomic) IBOutlet UIView *progressV;
@property (nonatomic ,strong)NSTimer *timer;


@property (nonatomic ,copy) void(^changleValue)(CGFloat);

@property (nonatomic ,copy) void(^stopCallBack)(void);
@property (nonatomic ,copy) void(^forwardCallback)(void);
@property (nonatomic ,copy) void(^backwardCallback)(void);

@property (nonatomic ,strong)NSMutableArray *queueArr;



@end



@implementation MusicProgressView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
 //   if (self.isEnableSwiper) {
        if ([gestureRecognizer class] == [UIPanGestureRecognizer class]) {
            UIPanGestureRecognizer *g = (UIPanGestureRecognizer *)gestureRecognizer;
            CGPoint point = [g velocityInView:self];
            if (fabsf((float)point.x) > fabsf((float)point.y)) {
                return YES;
            }
//        }
            return NO;
        }else{
        return NO;
    }
}



- (IBAction)panGestClick:(UIPanGestureRecognizer *)sender {
    static CGFloat orgionX;
  
    if (sender.state == UIGestureRecognizerStateBegan) {
        orgionX = _clickItem.center.x;
    } else
    {
        CGPoint touchPoint =  [sender translationInView:self];
        
        NSLog(@"_++++++%f",touchPoint.x);
        
        CGFloat center_x = CGRectGetMinX(self.progressV.frame);
        CGFloat center_y = self.clickItem.center.y;
        
        CGFloat w = CGRectGetWidth(self.progressV.frame);
        
        self.value = (orgionX +touchPoint.x - center_x) / w;
    }
  //    self.clickItem.center = CGPointMake(center_x +  touchPoint.x, center_y);

}


-(void)setValue:(CGFloat)value
{
    if (_value == value ) {
        return;
    }
    if (value < 0) {
        value = 0;
    }
    if (value > 1) {
        value = 1;
    }
    
    CGFloat center_x = CGRectGetMinX(self.progressV.frame);
    CGFloat center_y = self.clickItem.center.y;
    
    CGFloat w = CGRectGetWidth(self.progressV.frame);
    self.clickItem.center = CGPointMake(center_x +  w * value, center_y);
    
    NSLog(@"setValue%f",value);
    _value = value;
    
    ! _changleValue ?:_changleValue(value);
    
}

-(void)didChangleValue:(void (^)(CGFloat))callback
{
    self.changleValue = callback;
}



-(void)stopBtnCallback:(void (^)(void))callBack
{
    self.stopCallBack = callBack;
}

-(void)forwardBtnCallback:(void(^)(void))calllBack
{
    self.forwardCallback = calllBack;
}
-(void)backwardBtnCallback:(void(^)(void))callBack
{
    self.backwardCallback = callBack;
}




- (IBAction)backBtnClick:(id)sender {
    
    self.value = 0.0;
    
    !self.backwardCallback ? :_backwardCallback();
}

- (IBAction)stopBtnClick:(id)sender {
   
    self.value = 0.5;
    !self.stopCallBack ? :_stopCallBack();
}

- (IBAction)forwordBtnClick:(id)sender {
    self.value = 1.0;
    !self.forwardCallback ? :_forwardCallback();
}

+(instancetype)musicProgresssView
{
    return  [[[NSBundle mainBundle ]loadNibNamed:@"MusicProgressView" owner:nil options:nil] firstObject];
}

-(void)awakeFromNib
{
    
}
-(void)drawRect:(CGRect)rect{


      [self setCustomerColor];
}

-(void)setCustomerColor
{
    //初始化渐变层
//    NSLog(@"()()()%lf",CGRectGetWidth(self.itemBack.frame));

    CGFloat w = CGRectGetWidth(self.itemBack.frame);
    CGFloat h = CGRectGetHeight(self.itemBack.frame);
    self.gradientLayer = [CAGradientLayer layer];
    
    self.gradientLayer.frame = CGRectMake(0, 0, w, h+2);
    self.gradientLayer.cornerRadius = h*0.5;
    self.gradientLayer.masksToBounds = YES;
    
    _itemBack.layer.cornerRadius = h*0.5;
    _itemBack.layer.masksToBounds = YES;
    
    
    [_itemBack.layer addSublayer:self.gradientLayer];
    
    //设置渐变颜色方向
    self.gradientLayer.startPoint = CGPointMake(_value, 0);
    
    self.gradientLayer.endPoint = CGPointMake(0, 0);
    
    //设定颜色组
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor purpleColor].CGColor,
                                  (__bridge id)[UIColor whiteColor].CGColor];
    
    
    //设定颜色分割点
    self.gradientLayer.locations = @[[NSNumber numberWithFloat:(self.value * 0.5)] ,[NSNumber numberWithFloat:(self.value)],@(1.0f)];
    
    //定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                  target:self
                                                selector:@selector(TimerEvent)
                                                userInfo:nil
                                                 repeats:YES];
    
//    self.que = [XYQueue xyQueueWithQueSize:4];
//    
//    [self.que push:(__bridge id)[UIColor grayColor].CGColor];
//    [self.que push:(__bridge id)[UIColor lightGrayColor].CGColor];
//    [self.que push:(__bridge id)[UIColor whiteColor].CGColor];
//    [self.que push:(__bridge id)[UIColor grayColor].CGColor];
    
    
    self.queueArr = [[NSMutableArray alloc]init];;
    
    [self.queueArr unshift:(__bridge id)[UIColor grayColor].CGColor];
    [self.queueArr unshift:(__bridge id)[UIColor lightGrayColor].CGColor];
    [self.queueArr unshift:(__bridge id)[UIColor whiteColor].CGColor];
    [self.queueArr unshift:(__bridge id)[UIColor grayColor].CGColor];
    
//    [self.que push:(__bridge id)[UIColor grayColor].CGColor];
    
}


- (void)TimerEvent
{
    NSMutableArray *arrColor = [@[]mutableCopy];
    int len = 4;
    
    for (int i = 0; i< len + 1 ; i++) {
        
     //   id obj = [self.que pop];
        id obj = [self.queueArr pop];
      //  [self.que push:obj];
        [self.queueArr unshift:obj];
        
        if (i < len) {
           [arrColor addObject:obj];
        }
    }
   [arrColor insertObject:(__bridge id)[UIColor whiteColor].CGColor atIndex:0];
    
    NSMutableArray *arrDis = [@[] mutableCopy];
    float m = self.value;
    
    for (int i = 0; i<len; i++) {
        
        [arrDis addObject:@(1 * (1.0/len * (i)))];
    }
    
 
    [arrDis addObject:@(1.0f)];
    
//    NSLog(@"----%@,%@",arrColor,arrDis);
//    NSLog(@"timer %f",_value);
    
    self.gradientLayer.startPoint = CGPointMake(_value,0);
    self.gradientLayer.endPoint = CGPointMake(0, 0);
    
    self.gradientLayer.colors = arrColor;
    self.gradientLayer.locations  = arrDis;
    

//    NSMutableArray *arr = []
    
    //定时改变颜色
//    self.gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,
//                                  (__bridge id)[UIColor colorWithRed:arc4random() % 255 / 255.0
//                                                               green:arc4random() % 255 / 255.0
//                                                                blue:arc4random() % 255 / 255.0
//                                                               alpha:1.0].CGColor,
//                                  (__bridge id)[UIColor whiteColor].CGColor];
//
    //定时改变分割点
    
    
    
//    self.gradientLayer.locations = @[[NSNumber numberWithFloat:(self.value * 0.25)],[NSNumber numberWithFloat:(self.value * 0.5)] ,[NSNumber numberWithFloat:(self.value * 0.75)],[NSNumber numberWithFloat:(self.value)],@(1.0f)];
//   self.gradientLayer.locations = @[@(arc4random() % 10 / 10.0f), @(1.0f)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
