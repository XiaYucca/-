//
//  XYDirectionCalculate.c
//  XYCoreBlueToothDemo
//
//  Created by RainPoll on 16/1/4.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#include "XYDirectionCalculate.h"

#pragma mark - 通过两点坐标 计算半径点的范围  返回坐标与中心点和参数点在同一条直线上
CGPoint getLocationWithTranslation(CGPoint center, CGPoint translation, CGFloat minRadius, CGFloat maxRadius)
{
    CGFloat x2 = pow(translation.x, 2);
  
    CGFloat y2 = pow(translation.y, 2);
    
    CGFloat R2 = sqrt(x2 + y2);
    
    if (R2 <= minRadius) {
        return center;
    }
    
    if (R2 >= maxRadius) {
        CGFloat mutpli = maxRadius / R2;
        CGFloat dx = (translation.x) * mutpli;
        CGFloat dy = (translation.y) * mutpli;
        center.x += dx;
        center.y += dy;
        
    }
    else
    {
        center.x += translation.x;
        center.y += translation.y;
    }
    return center;
}
#pragma mark - 角度转换方位 返回方位
deriction getDeriction(CGFloat angle)
{
    angle = angle * 180/M_PI;
    
    if (angle < 0) {
        return origin;
    }
    int deriction = (angle + 22.5)/45.0 + 1;
    if (deriction >= 9) {
        deriction = 1;
    }
    return deriction;
}

#pragma mark - 用向量计算角度 返回角度 -1为原点
CGFloat getAngleWithVector(CGPoint translation)
{
        if (translation.x == 0 && translation.y == 0) {
            return -1;
        }else
        {
            CGFloat location = (-translation.y)/translation.x;
            CGFloat result;
            
            
            CGFloat R = sqrt( pow(translation.y, 2) + pow(translation.x, 2) );
            
            result = acos(- translation.y / R);
            
            
            
            
            if (translation.x <0) {
                result = M_PI * 2 - result;
            }

        return result;
    }
}
#pragma mark - 用点计算角度 返回弧度 -1为原点  坐标系向上为 0  顺时针+ 逆时针为-
CGFloat getAngleWithPoint(CGPoint center, CGPoint translate)
{
    CGPoint translation = CGPointMake(translate.x - center.x, translate.y - center.y);
    return getAngleWithVector(translation);
  /*
    if (translation.x == 0 && translation.y == 0) {
        return -1;
    }else
    {
        CGFloat location = (-translation.y)/translation.x;
        CGFloat result;
        
        
        CGFloat R = sqrt( pow(translation.y, 2) + pow(translation.x, 2) );
        
        result = acos(- translation.y / R)/ M_PI * 180 ;
        
        
        
        
      if (translation.x <0) {
            result = -result;
        }
//        if (translation.y < 0) {
//            result = 360 -  result;
//        }
//        
        
//        
//        if ((translation.x < 0)&&(translation.y < 0) ) {
//            result = 180 + (atan(location)*180.0)/M_PI;
//        }
//        else if((translation.y > 0)&&(translation.x < 0))
//        {
//            result = (atan(location)*180.0)/M_PI+180;
//        }
//        else if((translation.y > 0)&&(translation.x >0))
//        {
//            result = (atan(location)*180.0)/M_PI+360;
//        }
//        else if(translation.x == 0 && translation.y >0){
//            result = M_PI* 0.5;
//        }else if (translation.x == 0 && translation.y <0)
//        {
//           result = M_PI* 1.5;
//        }else{
//         result = (atan(location)*180.0)/M_PI;
//        }
//        
        
         printf("\nresult ----    >%.2f\n",result);
        return result;
    } */
    
}
//CGFloat getClockwiseAngleWithPoint(CGPoint center, CGPoint translate, CGFloat originAngle)
//{
//    CGFloat value = getAngleWithPoint(center, translate);
//    if (value == -1) {
//        return -1;
//    }
//
//}
//
//CGFloat getAnticlockwiseAngleWithPoint(CGPoint center, CGPoint translate, CGFloat originAngle)
//{
//
//}

#pragma  参数为正坐标系顺时针旋转 向右为0  顺时针增加

CGFloat getCoordinateTransform(CGFloat orgin , CGFloat parameter)
{
//    CGFloat result ;
//    if (orgin >= 0 && orgin < M_PI_2) {
//        
//        result = M_PI_2 * 3 + orgin;
//    }else if (orgin >= M_PI_2 && orgin <= M_PI)
//    {
//        result = orgin - M_PI_2;
//    }else if (orgin < -M_PI_2 && orgin >=  -M_PI)
//    {
//        result = M_PI_2 * 3 + orgin;
//    }else if (orgin < 0 && orgin > - M_PI_2)
//    {
//        result = M_PI_2 * 3  + orgin;
//    }
    CGFloat result = orgin - parameter;
    if (result < 0) {
        result = M_PI * 2 - parameter + orgin;
    }
    if (result > M_PI * 2) {
        result = result - M_PI *2;
    }
    
    
    return  result; // (orgin - M_PI_2)>0 ? (orgin - M_PI_2):(M_PI_2 * 3 + orgin);
}
//CGFloat getCoordinateTransformContrarotate(CGFloat orgin)
//{
//    return orgin + M_PI
//    
//}

#pragma mark - 计算点击是否在圆环里，在的返回YES,不在返回NO
bool touchRingWithPoint(CGPoint center, CGFloat minRadius, CGFloat maxRadius, CGPoint touchPoint)
{
    CGPoint translation = CGPointMake(touchPoint.x - center.x , touchPoint.y - center.y);
    
    CGFloat x2 = pow(translation.x, 2);
    
    CGFloat y2 = pow(translation.y, 2);
    
    CGFloat radius = sqrt(x2 + y2);
    
    if ((radius >= minRadius)&& (radius <= maxRadius)) {
        return true;
    }
    return false;
}