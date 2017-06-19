//
//  ____Tests.m
//  小奥新版Tests
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DrawLine.h"
#import "DanceViewModel.h"


@interface ____Tests : XCTestCase

@end

@interface TaskTree:NSObject

@property (nonatomic ,strong) TaskTree *left;
@property (nonatomic ,strong) TaskTree *right;

@property (nonatomic ,assign) BOOL if_status;
@property (nonatomic ,assign) int loop_times;
@property (nonatomic ,assign) BOOL loop_status;

@property (nonatomic ,copy) NSString *info;

+(instancetype)TaskTreeWithInfo:(NSString *)info;
@end

@implementation TaskTree

-(instancetype)init{
    if (self = [super init]) {
        self.if_status = YES;
        self.loop_status = NO;
    }
    return self;
}

+(instancetype)TaskTreeWithInfo:(NSString *)info{
    TaskTree *temp = [[TaskTree alloc]init];
    temp.info = info;
    return temp;
}

@end

@implementation ____Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)__testDanceViewModel{
    DanceViewModel *model = [[DanceViewModel alloc]init];
    
  //  NSLog(@"%@",model.songsPathList);
    NSLog(@"%@",model.songsNameList);
}

-(void)__testConnect{
    NodeList *list = [NodeList nodeList];
    for (int i = 0; i < 10; i ++) {
        [list appendNode:[Node createNodeWithPoint:CGPointMake(i,0)]];
    }
    NodeList *list_2 = [NodeList nodeList];
    for (int i = 0; i < 10; i ++) {
        [list_2 appendNode:[Node createNodeWithPoint:CGPointMake(i,1)]];
    }
    //测试连接
    [list connectLineFromLine:list toLine:list_2];
    
    
    //测试定点范围剪切
    Node *node = [Node createNodeWithPoint:CGPointMake(5.5, 1)];

    NSArray *arr =  [list cutNodeListAtNode:node];
    arr;
}


-(void)___testLine{

    NodeList *list = [NodeList nodeList];
    NSLog(@"%@",list);
    
    int i = 0;
    for (int i = 0; i < 10; i ++) {
        [list appendNode:[Node createNodeWithPoint:CGPointMake(i,0)]];
    }
    NSLog(@"%@",list);
    
    NodeList *list_2 = [NodeList nodeList];
    NSLog(@"%@",list_2);
    
    for (int i = 0; i < 10; i ++) {
        [list_2 appendNode:[Node createNodeWithPoint:CGPointMake(i,1)]];
    }
    NSLog(@"%@",list_2);
    
    [list appenList: list_2];
    NSLog(@"listAppend:%@",list);
    [list enumerateNodesUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index %ld ,obj:%@",idx,NSStringFromCGPoint(((Node*)obj).point));
    }];
    
    NSArray *arr = [list cutNodeListAtIndex:8];
    NSLog(@"%@",arr[0]);
    NSLog(@"%@",arr[1]);
    
    NodeList *r1 = arr[0];
    NodeList *r2 = arr[1];
    
    for (int i= 0; i < r1.nodeLifeManage.count; i ++) {
        Node *nod = r1.nodeLifeManage[i];
        NSLog(@"index %ld ,obj:%@",i,NSStringFromCGPoint(nod.point));
    }
    NSLog(@"\n\n\n");
    
    for (int i= 0; i < r2.nodeLifeManage.count; i ++) {
        Node *nod = r2.nodeLifeManage[i];
        NSLog(@"index %ld ,obj:%@",i,NSStringFromCGPoint(nod.point));
    }
    
    NSLog(@"\n\n\n");
    
    Node *head = r1.head;
    while (head) {
        NSLog(@"obj:%@",NSStringFromCGPoint(head.point));
        head = head.next;
    }
}




-(void)__testTask{
    
    /*
    TaskTree *root = [TaskTree 
     TaskTreeWithInfo:@"root"];
    
    TaskTree *left = [TaskTree TaskTreeWithInfo:@"left_1"];
    TaskTree *right = [TaskTree TaskTreeWithInfo:@"right_1"];
    
    
    TaskTree *left_2 = [TaskTree TaskTreeWithInfo:@"left_1_left_2"];
    TaskTree *right_2 = [TaskTree TaskTreeWithInfo:@"left_1_right_2"];
    
    TaskTree *left_3 = [TaskTree TaskTreeWithInfo:@"right_1_left_2"];
    TaskTree *right_3 = [TaskTree TaskTreeWithInfo:@"right_1_right_2"];
    
    root.left = left;
    
    left.left = left_2;
    left.right = right_2;

    root.right = right;
    right.left = left_3;
    right.right = right_3;
    
    [self enumLeft:root];
    NSLog(@"end task");
     */
    
    //功能效果
    // if_funcion
    
//    if (isTrue) {
//        if_true_function();
//    }else{
//        if_false_function();
//    }
    
    
    //分支结构 树的结构 以 if else 函数为例
    //节点生成
    TaskTree *task_if = [TaskTree TaskTreeWithInfo:@"if_func"];   //if()
    TaskTree *task_if_true_func = [TaskTree TaskTreeWithInfo:@"if_true_func"]; //{} if执行体
    TaskTree *task_else_func = [TaskTree TaskTreeWithInfo:@"else_func"];  //else()
    TaskTree *task_else_content_func= [TaskTree TaskTreeWithInfo:@"else_content_func"];//{} else执行体
    
    
    //如果为真
    {
    BOOL if_status = YES;
    
    //设置节点属性
    task_if.if_status = if_status;
    task_else_func.if_status = !if_status;
    }
    
    //节点组合
    {
    task_if.left = task_if_true_func;
    task_if.right = task_else_func;
    task_else_func.left = task_else_content_func;
    }
    
    
    //分支结构 树的结构 以 if else 函数为例
    //节点生成
    TaskTree *task_if_2 = [TaskTree TaskTreeWithInfo:@"if_func_2"];   //if()
    TaskTree *task_if_true_func_2 = [TaskTree TaskTreeWithInfo:@"if_true_func_2"]; //{} if执行体
    TaskTree *task_else_func_2 = [TaskTree TaskTreeWithInfo:@"else_func_2"];  //else()
    TaskTree *task_else_content_func_2 = [TaskTree TaskTreeWithInfo:@"else_content_func_2"];//{} else执行体
    
    
    //如果为真
    {
        BOOL if_status = NO;
        
        //设置节点属性
        task_if_2.if_status = if_status;
        task_else_func_2.if_status = !if_status;
    }
    
    //节点组合
    {
        task_if_2.left = task_if_true_func_2;
        task_if_2.right = task_else_func_2;
        task_else_func.left = task_else_content_func_2;
    }

    
    task_if_true_func.left = task_if_2;

    
    
    //节点遍历
    [self enumLeft:task_if];
     NSLog(@"end if task!");
    
    
    //循环结构就是 右节点指向自己;
    TaskTree *task_loop = [TaskTree TaskTreeWithInfo:@"loop_func"];
    TaskTree *task_loop_content_1 = [TaskTree TaskTreeWithInfo:@"loop_content_1_func"];
    TaskTree *task_loop_content_2 = [TaskTree TaskTreeWithInfo:@"loop_content_2_func"];
    
    TaskTree *task_loop_end = [TaskTree TaskTreeWithInfo:@"task_loop_end_func"];
    
    task_loop_content_1.right = task_loop_content_2;
    task_loop.left = task_loop_content_1;
    task_loop.right = task_loop_end;
    
    
    task_loop.loop_times = 2;
    task_loop.loop_status = YES;
     
    [self enumLeft:task_loop];
    
       // [self enumLeft:task_loop];
    
    NSLog(@"end loop");
}

/*
 2017-06-17 14:22:18.752615+0800 小奥新版[12326:3323111] orgin:left_1
 2017-06-17 14:22:18.752720+0800 小奥新版[12326:3323111] orgin:left_1_left_2
 2017-06-17 14:22:18.752816+0800 小奥新版[12326:3323111] orgin:left_1_right_2
 2017-06-17 14:22:18.752904+0800 小奥新版[12326:3323111] orgin:right_1
 2017-06-17 14:22:18.752990+0800 小奥新版[12326:3323111] orgin:right_1_left_2
 2017-06-17 14:22:18.753077+0800 小奥新版[12326:3323111] orgin:right_1_right_2
 2017-06-17 14:22:25.672954+0800 小奥新版[12326:3323111] end task
 
 
 
 2017-06-17 14:24:29.231653+0800 小奥新版[12333:3323794] orgin:left_1_left_2
 2017-06-17 14:24:29.231855+0800 小奥新版[12333:3323794] orgin:left_1_left_2
 2017-06-17 14:24:29.231952+0800 小奥新版[12333:3323794] orgin:left_1_right_2
 2017-06-17 14:24:29.232043+0800 小奥新版[12333:3323794] orgin:left_1_right_2
 2017-06-17 14:24:29.232134+0800 小奥新版[12333:3323794] orgin:right_1_left_2
 2017-06-17 14:24:29.232222+0800 小奥新版[12333:3323794] orgin:right_1_left_2
 2017-06-17 14:24:29.232310+0800 小奥新版[12333:3323794] orgin:right_1_right_2
 
 
 2017-06-17 14:26:38.199512+0800 小奥新版[12340:3324596] orgin:left_1_left_2
 2017-06-17 14:26:38.199719+0800 小奥新版[12340:3324596] orgin:left_1_right_2
 2017-06-17 14:26:38.199815+0800 小奥新版[12340:3324596] orgin:left_1_right_2
 2017-06-17 14:26:38.199904+0800 小奥新版[12340:3324596] orgin:right_1_left_2
 2017-06-17 14:26:38.199992+0800 小奥新版[12340:3324596] orgin:right_1_right_2
 2017-06-17 14:26:38.200139+0800 小奥新版[12340:3324596] orgin:right_1_right_2
 2017-06-17 14:26:38.200229+0800 小奥新版[12340:3324596] orgin:right_1_right_2
 
 */

-(void)enumLeft:(TaskTree *)tree{
    static TaskTree *temp;
    temp = tree;
    static TaskTree *tempRight;
    static BOOL once_tocken = YES;
    
    if (temp.loop_times && temp.loop_status) {
        if (once_tocken) {
            tempRight = temp.right;
            once_tocken = NO;
        }
        temp.right = temp;
        temp.loop_times --;
//        if (temp.loop_times <= 0) {
//            temp.loop_status = NO;
//        }
    }
    if ((temp.loop_times <= 0) && temp.loop_status) {
        temp.loop_status = YES;
        once_tocken = YES;
        temp.right = tempRight;
    }
    
    NSLog(@"info:%@",temp.info);
    
    if (tree.left && tree.if_status) {
        [self enumLeft:tree.left];
        
    }

    if (tree.right) {
        
        [self enumLeft:tree.right];
       // NSLog(@"orgin:%@",temp.info); 全部右节点
    }

}



-(void)__testDispatch{
    //  以下是控制并发队列 并发数量
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); //并发队列并设置优先级
    for (int i = 0; i < 40; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); //判断信号量是否小于0 不是通过信号量-1 否则阻塞等待信号量
        dispatch_group_async(group, queue, ^{
            NSLog(@"dispath: %i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    //创建一个源   DISPATCH_SOURCE_TYPE_DATA_ADD  源类型是增加数据
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_global_queue(0, 0));
    //设置事件回调
    dispatch_source_set_event_handler(source, ^{
        
        //数据执行完毕，通知我更新UI操作
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"## 我已经收到数据，开始更新UI操作 ##");
            dispatch_source_cancel(source);
        });
        
    });
    //source 默认处于suspend 暂停 状态 ，我们要执行 dispatch_resume  继续执行
    dispatch_resume(source);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //此处是网络请求，请求到数据之后，我们更新一个源
        NSLog(@"## 通知数据合并更新 ##");
        dispatch_source_merge_data(source, 1);
    });
    unsigned long num =   dispatch_source_get_data(source);
    NSLog(@"data = %ld",num);
    //得到dispatch  源 ，获取的是dispatch_source_create  的第三个参数，
    
    unsigned long num1 =    dispatch_source_get_mask(source);
    //获取dispatch 源  获取的是dispatch_create 的第二个参数位置的信息
    unsigned long num2 = dispatch_source_get_handle(source);
    //  源取消时的回调，用于关闭流处理
    dispatch_source_set_cancel_handler(source, ^{
        NSLog(@"## 如果source 被取消，则执行这个函数 ##");
    });
    //检测源是否取消，如果是非0 则表示取消
    long cancelNum =   dispatch_source_testcancel(source);
    //可用于源启动时调用block，调用完成后释放这个block，也可以在源执行中调用这个block
    dispatch_source_set_registration_handler(source, ^{
        NSLog(@"我是注册收到的回调");
    });
    
}
-(void)test{
   /*
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        NSLog(@"%s",__func__);
    //    });
    id t = VerifyValue(@1);
    //  [NSData contentTypeForImageData:[[NSData alloc]init]];
    [MainViewController testClassMethod];
    
    NSLog(@"+++imp_method%@",[self class]);
    
    SignInViewModel *model = [[SignInViewModel alloc]init];
    [model viewDidSelectItem:^(NSInteger btntag) {
        NSLog(@"selected item %ld",btntag);
    }];
    */
    
    
    //    model
    
    //    SignInView *signView = [[SignInView alloc]initWithFrame:self.view.frame];
    //    [self.view addSubview:signView];
    
    //    [SignInView dissmissOnWindow:^(bool dissMiss) {
    //        NSLog(@"signView dissmissOnWindow");
    //      //  return YES;
    //    }];
    //    signView.model= model;
    
}

+(void)testClassMethod{
    typeof(self) t = self;
    NSLog(@"class_method%@",[self class]);
    NSLog(@"nsclass from nsstring %@",NSClassFromString(@"MainViewController"));
    NSLog(@"class_typeof%@ --self%@",t,self);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
