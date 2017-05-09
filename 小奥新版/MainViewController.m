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

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MainViewModel *mainViewModel = [[MainViewModel alloc] init ];
    mainViewModel.pageListArr = @[@"重力",@"编程",@"手绘",@"寻线",@"语音",@"跳舞"];
    
 //   MainView *mainView = [[MainView alloc]initWithFrame:self.view.frame];
    MainView *mainView = [MainView MainView:self.view.frame];
    mainView.model = mainViewModel;
    [self.view addSubview:mainView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        EditFaceViewController *edit = [[EditFaceViewController alloc]init];
        [self presentViewController:edit animated:YES completion:nil];
    });

    
//    HeadView *headV = [HeadView headView:CGRectMake(0, 0, 200, 200)];
//    [self.view addSubview:headV];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
