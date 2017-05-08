//
//  MModel.m
//  map
//
//  Created by lujh on 2017/3/22.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MModel+test.h"
#import "HYXMLParserProtocol.h"
#import <objc/runtime.h>


@implementation MModel (test)

-(void)TestSetValuesForKeysWithDictionary:(NSDictionary *)dic{
    
    u_int count;
    Ivar* ivars = class_copyIvarList([self class], &count);
    NSMutableArray *arr_m = [NSMutableArray array];
    for (const Ivar*p = ivars; p < ivars+count; ++p) {
        Ivar const ivar = *p;
        NSString* name = [NSString stringWithUTF8String:ivar_getName(ivar)];
       // NSLog(@"name: %@",name);
        [arr_m addObject:name];
    }
    NSArray *keys = [dic allKeys];
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isContent = NO;
        for (NSString *res in arr_m) {
            if ([res isEqualToString: [NSString stringWithFormat:@"_%@",obj]] ||[res isEqualToString: obj] ) {
                isContent = YES;
                break;
            }
        }
        if (isContent) {
            
        }else{
            NSLog(@"没有相应的key %@",obj);
//            NSUInteger size;
//            NSUInteger alignment;
//            NSGetSizeAndAlignment("*", &size, &alignment);
//            
//            class_addIvar([self class], "expression", size, alignment, "*");
//            
//            NSLog(@"%@",self);
//            class_addMethod

        }
    }];
    
    [self TestSetValuesForKeysWithDictionary:dic];
}

-(void)test{
    NSLog(@"%s",__func__);
}

+(void)initialize{
 Method method1 = class_getInstanceMethod(self, @selector(setValuesForKeysWithDictionary:));
 Method method2 = class_getInstanceMethod(self, @selector(TestSetValuesForKeysWithDictionary:));
  
 method_exchangeImplementations(method1, method2);
}

//+(void)load{
//    Method method1 = class_getClassMethod(self, @selector(setValuesForKeysWithDictionary:));
//    
//    Method method2 = class_getClassMethod(self, @selector(test));
//    
//    method_exchangeImplementations(method1, method2);
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"您尝试设置的key: %@ 不存在",key);
    NSLog(@"您尝试设置的value: %@",value);
}

-(void) setNilValueForKey:(NSString *)key
{
    [super setNilValueForKey:key];
}




@end
