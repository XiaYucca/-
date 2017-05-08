//
//  setMaskView.h
//  XYCoreBlueToothDemo
//
//  Created by RainPoll on 16/1/16.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import "HMView.h"
#import "HMBezierPath.h"
#import "CanvasLayer.h"
#include "XYDirectionCalculate.h"
#import<CoreGraphics/CoreGraphics.h>
@interface XYPosition : NSObject

@property (nonatomic , assign)CGPoint point;
@property (nonatomic , assign)int index;
+(instancetype)positiontWithPoint:(CGPoint)point;

@end
@implementation XYPosition

+(instancetype)positiontWithPoint:(CGPoint)point
{
    XYPosition *p = [[XYPosition alloc]init];
    p.point = point;
    return p;

}
@end


@interface HMView ()

@property (nonatomic,strong)NSMutableArray * path;

@property (nonatomic,strong)CanvasLayer *cLayer;

@property (nonatomic,strong)NSMutableArray *points;

@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic, copy)void (^outsideBlock)(CGPoint p, BOOL * stop);

@end

@implementation HMView
{
    int index;
    int speed;
    CGPoint firstTouch;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
         self.isEnable = YES;
    }
    return self;
}

//懒加载很重要
-(NSMutableArray *)path
{
    if (!_path) {
        _path = [NSMutableArray array];
    }
    return _path;
}

-(void)setSpeed:(CGFloat)speed
{
    speed = speed;
    
    [self playAnitameWithDeration:speed];
    
}

-(NSMutableArray *)points
{
    if (!_points) {
        _points = [@[]mutableCopy];
    }
    return _points;
}

-(void)touchOutsideView:(void (^)(CGPoint ,BOOL *))outsideBlock
{
    self.outsideBlock = outsideBlock;
}


-(CanvasLayer *)cLayer
{
    if (!_cLayer) {
        _cLayer = [CanvasLayer layer];
        
        _cLayer.bounds = CGRectMake(0,0, 40, 40);
        _cLayer.backgroundColor = [UIColor clearColor].CGColor;
        
       // _cLayer.cornerRadius = 10;
     //   _cLayer.masksToBounds = YES;
        
        [_cLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
        
        [self.layer addSublayer:_cLayer];
    }
    _cLayer.hidden = NO;

    return _cLayer;
}

-(void)drawRect:(CGRect)rect
{
    //所有的路劲都渲染一次
    CGContextRef context =  UIGraphicsGetCurrentContext();
  
    UIGraphicsPushContext(context);
    

    for (int i = 0; i < self.path.count; i++) {
        HMBezierPath * path = self.path[i];
        
#warning 这句话很重要 不要用self.lineColor 是每一个路径设置 如果没有这句话 不会显示颜色
        [path.lineColor set];
        
        // 设置连接出的样式
        [path setLineJoinStyle:kCGLineJoinRound];
        
        // 设置头尾的样式`
        [path setLineCapStyle:kCGLineCapRound];
        
        [path stroke];
    }
    UIGraphicsPopContext();
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isEnable) {
        return;
    }
    [self clear];
    // 获取触摸对象
//    UIGraphicsPopContext();
    UITouch* t = touches.anyObject;
    
    // 获取当前手指的位置
    CGPoint p = [t locationInView:t.view];
    
    // 创建路径
    HMBezierPath* path = [[HMBezierPath alloc] init];
//    CGContextRestoreGState(context)
    // 设置起点
    [path moveToPoint:p];
    
    // 设置线宽
    [path setLineWidth:self.lineWidth];
    
    //使用block来传值
//    [path setLineWidth:self.lineWidthBlock()];

    
    // 设置颜色
    [path setLineColor:self.lineColor];
    
    // 把每一条创建的路径 添加到数组中 方便管理
    [self.path addObject:path];
    
    
    XYPosition *pos = [XYPosition positiontWithPoint:p];
    
    
    [self.points addObject:pos];

}



-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isEnable) {
        return;
    }
    
    static CGPoint oldPosition;
    //增加一个起点
    UITouch * touch = touches.anyObject;
    
    CGPoint p = [touch locationInView:touch.view];
    
    //touch outside view
    bool stop = NO;
    
    if ( (p.x > self.frame.size.width || p.x< 0) || (p.y < 0 || p.y > self.frame.size.height) ) {
        
        NSLog(@"手指出界%@",NSStringFromCGPoint(p));
        !self.outsideBlock ? : self.outsideBlock(p , &stop);
    
    }
    if (stop) {
        return ;
    }
    
    XYPosition * oldXYPosition = self.points.lastObject;
    
    oldPosition = oldXYPosition.point;
    
    //始终是给数组中的最后的路径添加线

 //   if ([self isOutOfRangeOldPoint:oldPosition NewPoint:p Range:10]) {
    if ( (int)[self getDistanceWithStartPoint:oldPosition endPoint:p]< 15 &&(int)[self getDistanceWithStartPoint:oldPosition endPoint:p]> 5 ) {

      //  oldPosition = p;
        
        [self.path.lastObject addLineToPoint:p];
        
        XYPosition *pos = [XYPosition positiontWithPoint:p];
        
        [self.points addObject:pos];
        
#warning setNeedsDisplay一定要记得重绘
        [self setNeedsDisplay];
        }
}


-(BOOL)isOutOfRangeOldPoint:(CGPoint)oldPoint NewPoint:(CGPoint)newPoint Range:(CGFloat)range
{
    if (abs((int) (oldPoint.x - newPoint.y))>range || abs((int)(oldPoint.y - newPoint.y))>range ) {
        return YES;
    }else
        return NO;
}

-(CGFloat)calculateSlopeWithCenter:(CGPoint) center {
    
    static CGPoint oldCenter;
    static CGFloat oldAngle;
    
//   NSLog(@"point %@",NSStringFromCGPoint(center));
    
//   if (touchRingWithPoint(oldCenter, 0, 100, center)) {
//        
//        CGFloat angle = getAngleWithPoint(oldCenter,center);
//        oldCenter = center;
//        oldAngle = angle;
//    }
    if ([self isOutOfRangeOldPoint:oldCenter NewPoint:center Range:10]) {
            CGFloat angle = getAngleWithPoint(oldCenter,center);
            oldCenter = center;
            oldAngle = angle;
    }
   
    
   // NSLog(@"角度是-----%lf",oldAngle);
    
    return oldAngle;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
}


-(void)playAnitameWithDeration:(CGFloat)deration
{
    [self.timer invalidate];
    self.timer = nil;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        
//       
//
//    });
    self.timer = [NSTimer scheduledTimerWithTimeInterval:deration target:self selector:@selector(animateWithoutSpeed:) userInfo:nil repeats:YES];
   // [self animateWithSpeed:nil];
}


//-(void)animateWithSpeed:(NSTimer *)timer
//{
//    static CGPoint oldP ;
//    oldP = ((XYPosition *)self.points.firstObject).point;
//    
//    
//    dispatch_queue_t q1=dispatch_queue_create("com.hellocation.gcdDemo", DISPATCH_QUEUE_SERIAL);
//
//
//    for (XYPosition *p in self.points) {
//    //XYPosition *p= [self.points lastObject];
//        
//        {
//            dispatch_async(q1, ^{
//                [NSThread sleepForTimeInterval :1];
//                
//                NSLog(@"%@",[NSThread currentThread]);
//                
//                
////                
////                dispatch_async(dispatch_get_main_queue(), ^{
////                    CGPoint newP = p.point;
////                    
////                    CGFloat distance = sqrt(pow(newP.x, 2) + pow(newP.y, 2));
////                    
////                    //   if () {
////                    
////                    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
////                    animation.fromValue =  [NSValue valueWithCGPoint: self.cLayer.position];
////                    //            CGPoint toPoint = logoLayer.position;
////                    //            toPoint.x += 180;
////                    
////                    animation.duration = 0.05f;
////                    animation.toValue = [NSValue valueWithCGPoint:newP];
////                    
////                    [self.cLayer addAnimation:animation forKey:@"position"];
////                    [self.cLayer setNeedsDisplay];
////                    
////                });
//                
//           
//                
//                
//
//            });
//
//            
//        
//            //旋转动画
////            CABasicAnimation* rotationAnimation =
////            [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
////            rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 3];
////            // 3 is the number of 360 degree rotations
////            // Make the rotation animation duration slightly less than the other animations to give it the feel
////            // that it pauses at its largest scale value
////            rotationAnimation.duration = 2.0f;
////            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
////            
////            
////            CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
////            animationGroup.duration = 2.0f;
////            animationGroup.autoreverses = YES;   //是否重播，原动画的倒播
////            animationGroup.repeatCount = NSNotFound;//HUGE_VALF;     //HUGE_VALF,源自math.h
////            [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
////            
////            
////            //将上述两个动画编组
////            [logoLayer addAnimation:animationGroup forKey:@"animationGroup"];
//  //      }
//
//        }
//        
//    }
//    
// //   }
//}

-(CGFloat)getDistanceWithStartPoint:(CGPoint)start endPoint:(CGPoint)end
{
    return sqrt(pow(end.x - start.x , 2) + pow(end.y - start.y , 2));
}



-(void)animateWithoutSpeed:(NSTimer *)timer
{
      if(index < self.points.count) {
            XYPosition *p = [self.points objectAtIndex:index++];

            CGFloat angle =  [self calculateSlopeWithCenter:p.point];
            
            // self.cLayer.transform = CGAffineTransformMakeRotation(angle /180.0*M_PI);
            [self.cLayer setAffineTransform:CGAffineTransformMakeRotation((angle))];
            
            self.cLayer.position  = p.point;
            [self.cLayer setNeedsDisplay];
            
        }
        else
        {
           // [self clear];
            //   [self.timer invalidate];
        }
    
}



-(void)reStart{
    index = 0;
    
    if (self.points.count) {
        XYPosition *p = [self.points objectAtIndex:0];
        self.cLayer.position = p.point;
        [self playAnitameWithDeration:0.2];
    }
}


-(void)clear
{
    
    [self.timer invalidate];
    index = 0;
    [self.points removeAllObjects];
     self.cLayer.hidden = YES;
    
    
    [self.path removeAllObjects];
    [self setNeedsDisplay];
}


-(void)back{
    [self.path removeLastObject];
    [self setNeedsDisplay];
}
-(void)erase
{
    self.lineColor =  self.backgroundColor;
    [self setNeedsDisplay];
}
-(void)save{

    XYPosition *p = [self.points objectAtIndex:0];
    self.cLayer.position = p.point;
    [self playAnitameWithDeration:0.2];

}
@end
