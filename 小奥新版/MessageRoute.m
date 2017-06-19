//
//  MessageRoute.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/25.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "MessageRoute.h"
#import <objc/runtime.h>
#import <objc/message.h>


//#define WS(weakSelf)  __weak __typeof(self)weakSelf = self
//#define WeakObj(o) __weak typeof(o) weak##o = o

@interface XYObject : NSObject
@property (nonatomic ,copy)NSString *className;
@property (nonatomic ,copy)NSString *classMethod;
@property (nonatomic ,copy)NSArray *classMethodParm;
@end

@implementation XYObject

@end

@interface MessageRoute()

@property(nonatomic ,strong)NSString *property;
@property (nonatomic ,strong)NSMutableArray<XYObject *> *objArr;
@property (nonatomic ,copy) void(^evalCallBack)(id response);

@end

typedef struct returnStruct{
    int RETURN_TYPE_OBJ:1;
    int RETURN_TYPE_VOID:1;
    int RETURN_TYPE_BYTE:1;
    int RETURN_TYPE_CHAR:1;
    int RETURN_TYPE_INT:1;
    int RETURN_TYPE_LONG:1;
    int RETURN_TYPE_FLOAT:1;
    int RETURN_TYPE_DOUBLE:1;
    int RETURN_TYPE_STRUCT:1;
    int RETURN_TYPE_POINT:1;

}RETURNSTRUCT ;


@implementation MessageRoute

static typeof(MessageRoute) *_static_route;


+(instancetype)SharedRoute{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _static_route = [[super allocWithZone:NULL]init];
    });
    return _static_route;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self SharedRoute];
}

-(instancetype)copyWithZone:(struct _NSZone *)zone{
    return [[self class] SharedRoute];
}

-(void)postMessageWithUrl:(NSString *)url ParmArray:(NSArray *)parms Callback:(id(^)(id response))callBack{

}

-(void)evalObject_C:(NSString *)str CallBack:(void (^)(id response))callBack{
    self.evalCallBack = callBack;
    [self methTest:[str mutableCopy]];
    [self enumCode];
}
//int Check_Msg()

-(NSMutableArray *)objArr{
    if (!_objArr) {
        _objArr = [@[]mutableCopy];
    }
    return  _objArr;
}

-(void)methTest:( NSMutableString *)str{
    //  \\[[\\w,\\s,:]+\\]
    //  \[(\s*\w*)
    // \\w+
    WeakObj(self);
    __block XYObject *xyObj = [[XYObject alloc]init];
    [self.objArr addObject:xyObj];
    NSLog(@"\n\nparm:%@",str);
    
    __block NSString *className = @"";
    __block NSString *classMethod = @"";
    __block NSMutableArray  *classMethodParm;
    __block NSRange lastRange = {0,0};
    
    if (!classMethodParm) {
        classMethodParm = [@[] mutableCopy];
    }
    
    printf("\n\n\n\n");
    __block NSMutableString *searchText = [str mutableCopy];
    
    __block int head;
    head = 0;

    
    [self metchString:searchText reg:@"\\[[\\w,\\s,:]+\\]" Response:^BOOL(NSUInteger index, NSTextCheckingResult *result) {
      //  xyW
        static NSInteger i = 1;
        NSRange range = result.range;
//        range.location = range.location-lastRange.length;
//        lastRange = result.range;
        NSString *classTemp = [searchText substringWithRange:range];
        NSLog(@"classTemp%@",classTemp);
        
        if (range.length <= 0) {
            return NO;
        }
        
        [weakself metchString:classTemp reg:@"\\s?[\\w]*:?" Response:^BOOL(NSUInteger index, NSTextCheckingResult *result) {
            if(result.range.length){
                NSMutableString * temp = [[classTemp substringWithRange:result.range]mutableCopy];
                [temp replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
                NSLog(@"getItem:%@",temp);
                
                if (temp.length < 1) {
                    return YES;
                }
                
                head ++;
                if (head == 1) {
                    className = [temp copy];
                    NSLog(@"ClassName:%@",temp);
                }else{
                    if (head%2 == 0) {
                        NSMutableString * s = [NSMutableString stringWithFormat:@"%@%@",classMethod,temp];
                        [s replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
                        classMethod = [s copy];
                        NSLog(@"ClassMethod:%@",s);
                    }else{
                        [classMethodParm addObject:temp];
                    }
                }
                
            }
            return YES;
        }];
        
        xyObj.className = className;
        xyObj.classMethod = classMethod;
        xyObj.classMethodParm = [classMethodParm copy];

        if (result.range.length + result.range.location < searchText.length -1) {

            NSString *indexStr= [NSString stringWithFormat:@"_ClassInstace_%li ",(long)i++];
            [searchText replaceCharactersInRange:result.range withString:indexStr];
            NSLog(@"searchText%@",searchText);
            NSMutableString *test = [searchText mutableCopy];
            
            [weakself methTest:test];
        }
        return YES;
    }];
    
    NSLog(@"className :%@",className);
    NSLog(@"classMethod :%@",classMethod);
    NSLog(@"classMethodParm%@",classMethodParm);

/*
    NSTextCheckingResult *result = [self metchString:searchText reg:@"\\[[\\s,a-z,A-Z]*\\]"];
    if (result) {
        //匹配到的最里面的 [xxxx xxxx]
        NSMutableString *contentStr = [[searchText substringWithRange:result.range]mutableCopy];
        
        NSTextCheckingResult *classR = [self metchString:contentStr reg:@"\\w+"];
        if (classR) {
            NSMutableString *classStr = [[contentStr substringWithRange:classR.range]mutableCopy];
            NSLog(@"class %@",classStr);
            [contentStr replaceCharactersInRange:classR.range withString:@""];
            NSLog(@"contentStr %@",contentStr);
        }
        
        NSTextCheckingResult *methodR = [self metchString:contentStr reg:@"\\w+"];
        if (methodR) {
            NSMutableString *classStr = [[contentStr substringWithRange:methodR.range]mutableCopy];
            NSLog(@"method %@",classStr);
        }
        // 去掉 [xxxx xxxx]之后
        NSMutableString *searchMutableStr = [searchText mutableCopy];
        [searchMutableStr replaceCharactersInRange:result.range withString:@""];
        NSTextCheckingResult *impMethodR = [self metchString:searchMutableStr reg:@"[a-z,A-Z,0-9,_]*:"];
        if (impMethodR) {
            NSMutableString *impStr = [[searchMutableStr substringWithRange:impMethodR.range]mutableCopy];
            NSLog(@"impMethodR %@",impStr);
        }
    } */
    printf("\n\n\n\n");
    
}

-(NSArray *)metchString:(NSString *)str
                                 reg:(NSString *)re
                            Response:(BOOL(^)(NSUInteger index, NSTextCheckingResult *result))response {
    
    NSMutableString *searchText = [str mutableCopy];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:re options:NSRegularExpressionCaseInsensitive error:&error];
    
 //   NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    
    NSArray *arr = [regex matchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, [searchText length])];
    if (arr.count) {
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL re = response(idx,obj);
            if (!re) {
                *stop = YES;
            }else{
                *stop = NO;
            }
        }];
    }
    
//    if (result) {
//        returnStr = [[searchText substringWithRange:result.range]mutableCopy];
//    }
    return arr;
}

-(void)enumCode{
    NSMutableArray *itemList = [@[]mutableCopy];
    [self.objArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XYObject *xyObj = obj;
        if(xyObj.className){
            id c;
            if (idx == 0) {
              c = objc_getClass([xyObj.className UTF8String]);
            }else{
              c = [itemList lastObject];
            }

            NSArray *parm = xyObj.classMethodParm;
            int count = xyObj.classMethodParm.count;
            
            
            Method mc = class_getClassMethod([c class], sel_registerName([xyObj.classMethod UTF8String]));
            SEL s =  sel_registerName([xyObj.classMethod UTF8String]);
            Method mi = class_getInstanceMethod([c class],s);
            char dc[10] = {};
            char di[10] = {};
            
               method_getReturnType(mc, dc, 10);
               method_getReturnType(mi, di, 10);
            
               printf("\n\n %s----%s\n\n",dc,di);
               bool hasReturn = NO;
            RETURNSTRUCT returnType ;
            
            if (strcmp(dc,"@")==0|| strcmp(di,"@")==0) {
                printf("return type is object\n");
                returnType.RETURN_TYPE_OBJ = 1;
                hasReturn = YES;
            }
            if (strcmp(dc, "v")==0||strcmp(di, "v")==0) {
                printf("return type is void\n");
                 returnType.RETURN_TYPE_VOID = 1;
                 hasReturn = NO;
            }
            if (strcmp(dc,"C")==0 || strcmp(di,"C")==0) {
                printf("return type is byte\n");
                 returnType.RETURN_TYPE_BYTE = 1;
            }
            if (strcmp(dc,"c")==0 || strcmp(di,"c")==0) {
                printf("return type is char\n");
                 returnType.RETURN_TYPE_CHAR = 1;
            }
            
            if (strcmp(dc, "i")==0||strcmp(di, "i")==0) {
                printf("return type is interge\n");
                 returnType.RETURN_TYPE_INT = 1;
            }
            if (strcmp(dc, "f")==0||strcmp(di, "f")==0) {
                printf("return type is float\n");
                 returnType.RETURN_TYPE_FLOAT = 1;
            }
            if (strcmp(dc, "*")==0||strcmp(di, "*")==0) {
                printf("return type is c-point\n");
                returnType.RETURN_TYPE_POINT = 1;
            }
            if (strcmp(dc,"{")>=0 || strcmp(di,"{")>=0) {
                printf("return type is c-struct\n");
                returnType.RETURN_TYPE_STRUCT = 1;
            }

            id x = nil;
            NSInteger i = 0;
            float f = 0.0;
            void *p = NULL;


            if (count == 0) {
                if (hasReturn) {
                     x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
                }else{
                    objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
                }
               
            }
            if (count == 1) {
                if (hasReturn) {
                     x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0]);
                }else{
                    objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0]);

                }
               
            }
            if (count == 2) {
                if (hasReturn) {
                    x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1]);

                }else{
                    objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1]);

                }
            }
            if (count == 3) {
                if (hasReturn) {
                     x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2]);
                }else{
                    objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2]);
                }
            }
            if (count == 4) {
                if (hasReturn) {
                    x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3]);
                }
                else{
                    objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3]);
                }
            }
            if (count == 5) {
                if (hasReturn) {
                    x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3],parm[4]);

                }else{
                   objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3],parm[4]);
                }
            }
            if (x) {
                [itemList addObject:x];
            }else{
                NSLog(@"创建对象失败或者没有执行方法");
            }
        }
//        NSString *indexStr= [NSString stringWithFormat:@"_ClassInstace_%li",idx];
//        if ([xyObj.className isEqualToString:indexStr]) {
//            
//        }
    }];
    
    if (self.evalCallBack) {
        self.evalCallBack(itemList.lastObject);
    }
    [self.objArr removeAllObjects];
}
/*
void processReturnType(RETURNSTRUCT *r,id c,XYObject *xyObj,void (^callBack)()){
    if(callBack) callBack();
    
    NSArray *parm = xyObj.classMethodParm;
    int count = xyObj.classMethodParm.count;
    
    id x = nil;
    NSInteger i = 0;
    float f = 0.0;
    void *p = NULL;
    
    bool hasReturn = NO;
   
     void(^block)(RETURNSTRUCT *r, id c, XYObject *xyObj, NSArray *parm) = ^(RETURNSTRUCT *r, id c, XYObject *xyObj, NSArray *parm){
       
        int count = xyObj.classMethodParm.count;
        
        if (count == 0) {

            if ((*r).RETURN_TYPE_OBJ) {
                id x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_VOID) {
                 objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_BYTE) {
                Byte x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_CHAR) {
                char  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_INT) {
                int x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_FLOAT) {
                float x = objc_msgSend_fpret(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_LONG) {
                long  x = objc_msgSend_fpret(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_DOUBLE) {
                double  x = objc_msgSend_fpret(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_STRUCT) {
                 RETURNSTRUCT *x = objc_msgSend_stret(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_POINT) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            // block(r,c,xyObj,parm);
        }
        if (count == 1) {
            x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0]);
        }
        if (count == 2) {
            x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1]);
        }
        if (count == 3) {
            if (hasReturn) {
                x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2]);
            }else{
                objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2]);
            }
        }
        if (count == 4) {
            x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3]);
        }
        if (count == 5) {
            x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3],parm[4]);
        }
        {
            if ((*r).RETURN_TYPE_OBJ) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
                
            }
            if ((*r).RETURN_TYPE_VOID) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_BYTE) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_CHAR) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_INT) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_FLOAT) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_LONG) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_DOUBLE) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_STRUCT) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            if ((*r).RETURN_TYPE_POINT) {
                //  x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
            }
            
        }
    };
    
    if (count == 0) {
        x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]));
       // block(r,c,xyObj,parm);
    }
    if (count == 1) {
        x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0]);
    }
    if (count == 2) {
        x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1]);
    }
    if (count == 3) {   
        if (hasReturn) {
            x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2]);
        }else{
            objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2]);
        }
    }
    if (count == 4) {
        x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3]);
    }
    if (count == 5) {
        x = objc_msgSend(c, sel_registerName([xyObj.classMethod UTF8String]),parm[0],parm[1],parm[2],parm[3],parm[4]);
    }
    if (x) {
      //  [itemList addObject:x];
    }else{
        NSLog(@"创建对象失败或者没有执行方法");
    }
} */

-(char)testParm1:(NSString *)str parm2:(NSString *)parm2 parm3:(NSString *)parm3 //:void(^block)()
{
    NSLog(@"%s parm1:%@ parm2:%@ parm3%@",__func__,str,parm2,parm3);
    RETURNSTRUCT t = {1};
    struct returnStruct x = {2};
    return 1;
}

//测试
-(void)test{
    Class c = objc_getClass("MessageRoute");
    id co = objc_msgSend(c, sel_registerName("alloc"));
    NSArray *arr = @[@1,@2];
    //  objc_msgSend(co, @selector(Test:arr:),1,arr);
    
    
    id t = objc_msgSend([self class],@selector(SharedRoute));
    NSLog(@"obj %@",t);
    NSString *str = [NSString stringWithUTF8String:"test"];
    
    SEL s = sel_registerName("SharedRoute");
    
    NSString *s_str = [NSString stringWithUTF8String: sel_getName(s)];
    
    if (s_str.length) {
        printf("not nil sel\n");
    }
    else{
        printf(" nil sel\n");
    }
    
    id x = objc_msgSend([self class], s);
    NSLog(@"obj class method %@",x);
    
    id y = objc_msgSend(objc_getClass("NSString"), sel_registerName("stringWithUTF8String:"),"objc create string");
    NSLog(@"obj_str %@",y);
    
    //获取成员变量
    u_int count;
    Ivar* ivars = class_copyIvarList([self class], &count);
    for (const Ivar*p = ivars; p < ivars+count; ++p) {
        Ivar const ivar = *p;
        NSString* name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"name: %@",name);
    }
    //获取方法列表
    unsigned int cout = 0;
    Method *m_list = class_copyMethodList([self class], &cout);
    for (int  i =0 ; i< cout; i++) {
        Method m = m_list[i];
        NSString *meth_str = [NSString stringWithUTF8String: method_getName(m)];
        NSLog(@"method ---%@",meth_str);
    }
    //获取属性
    u_int _count;
    objc_property_t* pList = class_copyPropertyList([self class], &_count);
    for (int i = 0; i < _count; i ++) {
        const char* name = property_getName(pList[i]);
        NSString* strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSLog(@"preperty: %@",strName);
    }
    {//获取类方法
        u_int meta_count = 0;
        Method *metaList = class_copyMethodList(objc_getMetaClass("MessageRoute"), &meta_count);
        for (int  i =0 ; i< meta_count; i++) {
            Method m = metaList[i];
            NSString *meth_str = [NSString stringWithUTF8String: method_getName(m)];
            NSLog(@"meta method ---%@",meth_str);
            objc_msgSend([self class], sel_registerName(method_getName(m)));
            char t[100] ={0};
            method_getReturnType(m, t, 100);
            NSLog(@"return %@", [NSString stringWithUTF8String:t]);
        }
    }
    
    {
        char t[100] = {0};
        Method m = class_getInstanceMethod([self class], sel_registerName("hello:"));
        method_getArgumentType(m, 0, t, 100);
        NSLog(@"argumentType %@", [NSString stringWithUTF8String:t]);
    }
    //    //获取方法
    //    {
    //        Class PersonClass = object_getClass([Person class]);
    //        SEL oriSEL = @selector(test1);
    //        Method oriMethod = _class_getMethod(xiaomingClass, oriSEL);
    //
    //        Class PersonClass = object_getClass([xiaoming class]);
    //        SEL oriSEL = @selector(test2);
    //        Method cusMethod = class_getInstanceMethod(xiaomingClass, oriSEL);
    //
    //        BOOL addSucc = class_addMethod(xiaomingClass, oriSEL, method_getImplementation(cusMethod),            method_getTypeEncoding(cusMethod));
    //     }
    // objc_msgSend(self, sel_registerName("methTest"));
    // [self methTest:[@"[[UIView alloc:zone parm1:parm :parm2 parm3:parm3]initWith:frame :test] " mutableCopy]];
    // [self methTest:[@"[[UIView alloc] init] " mutableCopy]];
//     [self enumCode];
    // [_ClassInstace_0  initWithFram:frame item:ite]
}

void startEngine(id self, SEL _cmd, NSString *brand) {
    NSLog(@"my %@ car starts the engine", brand);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(drive)) {
        class_addMethod([self class], sel, (IMP)startEngine, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}




@end
