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
-(void)test;

-(void)evalObject_C:(NSString *)str CallBack:(void (^)(id response))callBack;

@end
