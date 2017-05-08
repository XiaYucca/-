//
//  MessageRoute.h
//  小奥新版
//
//  Created by RainPoll on 2017/4/25.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYObject;

@interface MessageRoute : NSObject

+(instancetype)SharedRoute;
//-(void)test;

/**
 执行oc的字符串 like @"[[NSSting alloc] initWith:xxx]" and callback中可以获取返回值 注意调用的方法必须为返回值 为oc类型或者void 其他c语言的基础类型不能返回且不适用(我还没做)

 @param str oc字符串
 @param callBack 执行函数返回值
 */
-(void)evalObject_C:(NSString *)str CallBack:(void (^)(id response))callBack;

@end
