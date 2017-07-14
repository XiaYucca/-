//
//  ExpressionViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/10.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "SignInViewModel.h"

@interface SignInViewModel ()
@property(nonatomic,copy)void(^didSelectItemCallback)(NSInteger btntag);
@property(nonatomic,copy)void(^willCloseCallback)(void);

@property(nonatomic,assign)NSInteger currSignedDay;
@property(nonatomic,assign)NSInteger signedDay;


@end

@implementation SignInViewModel

#pragma mark -init

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.picturesName = [dict objectForKey:@"picturesName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    //[super encodeWithCoder:coder];
    [coder encodeObject:self.picturesName forKey:@"picturesName"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    //    self = [super initWithCoder:coder];
    if (self = [super init]) {
        self.picturesName = [coder decodeObjectForKey:@"picrureName"];
    }
    return self;
}


-(void)viewDidSelectItem:(void(^)(NSInteger btntag))callback{
    self.didSelectItemCallback = callback;
    WeakObj(self);
    [weakself viewWillClose:nil];
//    StrongObj(self);
//    [self viewWillClose:nil];
}

-(void)viewWillClose:(void(^)())callback{
    self.willCloseCallback = callback;
}


/*
-(void)archiveToFile:(NSString *)file withKey:(NSString *)key{
    NSString *strFilePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *fileName=[strFilePath stringByAppendingPathComponent:file];
    //***********归档，序列化****************
    //1.创建一个可变的二进制流
    NSMutableData *data=[[NSMutableData alloc]init];
    //2.创建一个归档对象(有将自定义类转化为二进制流的功能)
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //3.用该归档对象，把自定义类的对象，转为二进制流
    [archiver encodeObject:self forKey:key];
    //4归档完毕
    [archiver finishEncoding];
    //将data写入文件
    [data writeToFile:fileName atomically:YES];
}


-(id)unarchiveFromFile:(NSString *)file withKey:(NSString *)key{
    
    NSString *strFilePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *fileName=[strFilePath stringByAppendingPathComponent:file];
    //******************反归档******************
    NSMutableData *mData=[NSMutableData dataWithContentsOfFile:fileName];
    //2.创建一个反归档对象，将二进制数据解成正行的oc数据
    NSKeyedUnarchiver *unArchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:mData];
    return [unArchiver decodeObjectForKey:key];
} 
 
*/



@end
