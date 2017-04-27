//
//  MessageRoute.h
//  小奥新版
//
//  Created by RainPoll on 2017/4/25.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageRoute : NSObject

@property(nonatomic ,strong)NSString *property;

@property (nonatomic ,strong)NSMutableArray *objArr;

+(instancetype)SharedRoute;
-(void)test;


-(void)evalObject_C:(NSString *)str CallBack:(void (^)(id response))callBack;

@end
