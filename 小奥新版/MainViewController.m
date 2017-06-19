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


#import "DanceViewModel.h"

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

//-(void)testDanceView{
//
//    DanceViewModel *model = [[DanceViewModel alloc]init];
//    
//    NSArray *temp = model.songsNameList;
//    NSLog(@"%@",temp);
//}

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
    mainViewModel.pageListArr = @[@"跳舞",@"语音",@"寻线",@"手绘",@"编程",@"重力",@"摇杆",@"5_操控模式",@"6_表情",@"7_情景模拟"];
    mainViewModel.jumpPageListArr = @[@"ExpressionViewController",
                                      @"VoiceViewController",
                                      @"HuntingViewController",
                                      @"DrawingViewController",
                                      @"EditFaceViewController",
                                      @"DanceViewController",
                                      @"FindMapViewController",
                                      @"OperationController",
                                      @"ExpressionViewController",
                                      @"ScenarioSimulationViewController"
                                      ];
    
    WeakObj(self);
    WeakObj(mainViewModel);
    mainViewModel.didSeletItemCallback = ^(UIView *view ,NSInteger index){
//        if(index > 4)
//            return;
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
    }];
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
