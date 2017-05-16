//
//  CanvasLayer.m
//  RollViewDemo
//
//  Created by RainPoll on 16/5/9.
//  Copyright © 2016年 xinle.hou. All rights reserved.
//

#import "CanvasLayer.h"
#import <UIKit/UIKit.h>

@implementation CanvasLayer

+(BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"XYposition"]) {
        return YES;
    }
    else
        return [super needsDisplayForKey:key];
}


//懒加载很重要
-(NSMutableArray *)path
{
    if (!_path) {
        _path = [NSMutableArray array];
        
    }
    return _path;
}

-(UIImage *)lightImage
{
    if (!_lightImage) {
        _lightImage = [UIImage imageNamed:@"发光.png"];
    }
    return _lightImage;
}
-(UIImage *)darkImage
{
    if (!_darkImage) {
        _darkImage =  [UIImage imageNamed:@"正常.png"];
    }
    return _darkImage;
}


-(instancetype)init
{
    if (self = [super init]) {

       // self.anchorPoint = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        self.backgroundColor = [[UIColor blackColor] CGColor];
        
    }
 
    
    //self.frame =
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
     return self;
}

-(instancetype)initWithLayer:(id)layer
{
 //   NSLog(@"init %@");
    
    if (self = [super initWithLayer:layer]) {
        
    }
   // self.backgroundColor = [[UIColor blackColor] CGColor];
    
    return self;
}

+ (id)layer
{
    CanvasLayer *layer = [[CanvasLayer alloc]init];
    
    return layer;
}

-(void)drawInContext:(CGContextRef)ctx
{
//    NSLog(@"layer drawIn");
//        //所有的路劲都渲染一次
//        for (int i = 0; i < self.path.count; i++) {
//            
//             XYBezierPath *path = self.path[i];
//            
//#warning 这句话很重要 不要用self.lineColor 是每一个路径设置 如果没有这句话 不会显示颜色
//            [path.lineColor set];
//            
//            // 设置连接出的样式
//            [path setLineJoinStyle:kCGLineJoinRound];
//            
//            // 设置头尾的样式
//            [path setLineCapStyle:kCGLineCapRound];
//            
//            [path stroke];
//        }
 //   CGContextRef context =  UIGraphicsGetCurrentContext();
 //   NSLog(@"%p",ctx);
    UIGraphicsPushContext(ctx);
//    CGContextClearRect(ctx, self.frame);
    static int index = 0;
    
    if (index<2) {
        CGContextDrawImage(ctx, CGRectMake(0, 0, 40, 40), self.lightImage.CGImage);
    }else {
        CGContextDrawImage(ctx, CGRectMake(0, 0, 40, 40), self.darkImage.CGImage);
    }
    if (index ++ == 4) {
        index = 0;
    }
    UIGraphicsPopContext();
}

-(void)drawImage
{
    /*图片*/
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIImage *image = [UIImage imageNamed:@"apple.jpg"];
    [image drawInRect:CGRectMake(60, 340, 20, 20)];//在坐标中画出图片
    //    [image drawAtPoint:CGPointMake(100, 340)];//保持图片大小在point点开始画图片，可以把注释去掉看看
  //  CGContextDrawImage(context, CGRectMake(100, 340, 20, 20), image.CGImage);//使用这个使图片上下颠倒了，参考http://blog.csdn.net/koupoo/article/details/8670024
    
    //    CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), image.CGImage);//平铺图
    UIGraphicsEndImageContext();
}

//+(BOOL)needsDisplayForKey:(NSString *)key
//{
//    //NSLog(@"属性进入key了");
//    
//    if ([key isEqualToString:@"pLoaction"]) {
//        
//        NSLog(@"属性进入了");
//        
//        return YES;
//    }
//    
//    return [super needsDisplayForKey:key];
//}




@end
