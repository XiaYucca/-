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

@implementation MainViewController

-(void)test{
   id t = VerifyValue(@1);
  //  [NSData contentTypeForImageData:[[NSData alloc]init]];
    [MainViewController testClassMethod];
    
    NSLog(@"+++imp_method%@",[self class]);
    
    SignInViewModel *model = [[SignInViewModel alloc]init];
    [model viewDidSelectItem:^(NSInteger btntag) {
        NSLog(@"selected item %d",btntag);
    }];
 //   model
    
//    SignInView *signView = [[SignInView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:signView];
    
    [SignInView showOnWindow:^{
        
    }];
//    [SignInView dissmissOnWindow:^(bool dissMiss) {
//        NSLog(@"signView dissmissOnWindow");
//      //  return YES;
//    }];
    //signView.model= model;
    
}

+(void)testClassMethod{
    typeof(self) t = self;
    NSLog(@"class_method%@",[self class]);
    NSLog(@"nsclass from nsstring %@",NSClassFromString(@"MainViewController"));
    NSLog(@"class_typeof%@ --self%@",t,self);
}


- (void)viewDidLoad {
 
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    

    
    MainViewModel *mainViewModel = [[MainViewModel alloc] init ];
    mainViewModel.pageListArr = @[@"跳舞",@"语音",@"寻线",@"手绘",@"编程",@"重力"];
    mainViewModel.jumpPageListArr = @[@"ExpressionViewController",
                                      @"EditFaceViewController",
                                      @"DrawingViewController",
                                      @"HuntingViewController",
                                      @"VoiceViewController",
                                      @"DanceViewController"];
    
    WeakObj(self);
    WeakObj(mainViewModel);
    mainViewModel.didSeletItemCallback = ^(UIView *view ,NSInteger index){
        NSLog(@"view:%@\n indx:%li",view,(long)index);
        NSString *str = [weakmainViewModel.jumpPageListArr objectAtIndex:index];
        [[Route share]GoToControllerIsPush:NO ClassName:str From:weakself PropertyDic:nil];
    };
    
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

//    HeadView *headV = [HeadView headView:CGRectMake(0, 0, 200, 200)];
//    [self.view addSubview:headV];
       [self test];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
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
