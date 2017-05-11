//
//  NSArray+Safe.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/3.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)

+ (void)load {
    
    [super load];
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lxz_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
    
}
- (id)lxz_objectAtIndex:(NSUInteger)index {
    
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        NSLog(@"index out of NSArray");
        @try {
            return [self lxz_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        
        @finally {}
    } else {
        return [self lxz_objectAtIndex:index];
    }
    
}



@end
