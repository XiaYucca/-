//
//  ViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "HeadView.h"
#import "MainViewModel.h"
#import "EditFaceViewController.h"
#import "SetingViewController.h"
#import "Route.h"
#import "ConnectView.h"
#import "SetingView.h"

#import "SignInView.h"
#import "SignInViewModel.h"

#import "DataStore.h"
#import "HelpView.h"

#import "NSData+ImageContentType.h"

#define VerifyValue(value)\
({id tmp;\
if ([value isKindOfClass:[NSNull class]])\
tmp = nil;\
else \
tmp = value;\
tmp;\
})\

@interface MainViewController ()

@end

@implementation MainViewController{
    bool isSignIn;
}

-(void)testDispatch{
    
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

-(void)viewDidAppear:(BOOL)animated{
    
    if(!isSignIn){
        [SignInView showOnWindow:^{
            
        }];
        isSignIn = YES;
    }

    
//    DataStore *store = [[DataStore alloc]init];
//    [store test];
}

- (void)viewDidLoad {
 
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    

    
    MainViewModel *mainViewModel = [[MainViewModel alloc] init ];
    mainViewModel.pageListArr = @[@"跳舞",@"语音",@"寻线",@"手绘",@"编程",@"重力",@"摇杆"];
    mainViewModel.jumpPageListArr = @[@"ExpressionViewController",
                                      @"VoiceViewController",
                                      @"HuntingViewController",
                                      @"DrawingViewController",
                                      @"EditFaceViewController",
                                      @"DanceViewController",
                                      @"DanceViewController"
                                      ];
    
    WeakObj(self);
    WeakObj(mainViewModel);
    mainViewModel.didSeletItemCallback = ^(UIView *view ,NSInteger index){
        if(index > 4)
            return;
        NSLog(@"view:%@\n indx:%li",view,(long)index);
        NSString *str = [weakmainViewModel.jumpPageListArr objectAtIndex:index];
        [[Route share]GoToControllerIsPush:NO ClassName:str From:weakself PropertyDic:nil];
        
    };
    
    [mainViewModel didClickHelpBtn:^{
        NSLog(@"%s",__func__);
        [[HelpView helpViewFromNib] showOnWindow];
    }];
    
    ((MainView *)self.view).model = mainViewModel;
    [mainViewModel didClickSetBtn:^{
        
        NSLog(@"%s",__func__);
        SetingView *set = [[SetingView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        set.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.9];
        
        [weakself.view addSubview:set];
//        UIWindow* window = [UIApplication sharedApplication].keyWindow;
//        if (!window) {
//            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
//        }
//        [window addSubview:set];
//        [window bringSubviewToFront:set];
    }];
    
//    [ConnectView showOnWindow:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [ConnectView dissmissOnWindow:nil];
//    });
//    
//   MainView *mainView = [[MainView alloc]initWithFrame:self.view.frame];
//   MainView *mainView = [MainView MainView:self.view.frame];
//   mainView.model = mainViewModel;
//    
//   [self.view addSubview:mainView];
    
//   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),           dispatch_get_main_queue(), ^{
//        EditFaceViewController *edit = [[EditFaceViewController alloc]init];
//        [self presentViewController:edit animated:YES completion:nil];
//   });

//   HeadView *headV = [HeadView headView:CGRectMake(0, 0, 200, 200)];
//   [self.view addSubview:headV];
    [self test];
    
}


-(void)loadView{
    self.view = [MainView MainView:[UIScreen mainScreen].bounds];
//    self.view = [MainView MainView:CGRectMake(0, 0, 300, 200)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
