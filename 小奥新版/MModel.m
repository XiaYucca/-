//
//  MModel.m
//  map
//
//  Created by lujh on 2017/3/22.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MModel.h"
#import "HYXMLParserProtocol.h"
#import <objc/runtime.h>

@interface MModel ()<HYXMLParserProtocol>

@end

@implementation MModel

-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}
//+(void)load{
//    Method method1 = class_getClassMethod(self, @selector(setValuesForKeysWithDictionary:));
//    Method method2 = class_getClassMethod(self, @selector(TestSetValuesForKeysWithDictionary:));
//    method_exchangeImplementations(method1, method2);
//}

-(void)hy_setKeyValues:(NSDictionary*)dic{
    
//    Method method1 = class_getClassMethod([self class], @selector(setValuesForKeysWithDictionary:));
//    Method method2 = class_getClassMethod([self class], @selector(TestSetValuesForKeysWithDictionary:));
//    method_exchangeImplementations(method1, method2);
    [self setValuesForKeysWithDictionary:dic];
}


//-(void)TestSetValuesForKeysWithDictionary:(NSDictionary *)dic{
//    
//    u_int count;
//    Ivar* ivars = class_copyIvarList([self class], &count);
//    NSMutableArray *arr_m = [NSMutableArray array];
//    for (const Ivar*p = ivars; p < ivars+count; ++p) {
//        Ivar const ivar = *p;
//        NSString* name = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        NSLog(@"name: %@",name);
//        [arr_m addObject:name];
//    }
//    NSArray *keys = [dic allKeys];
//    
//    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (![keys containsObject:obj]) {
//            NSLog(@"没有相应的key:%@",obj);
//           // *stop = YES;
//        };
//    }];
//    
//
//    
//    [self TestSetValuesForKeysWithDictionary:dic];
//}

@end
