
//
//  Regist.m
//  小奥新版
//
//  Created by RainPoll on 2017/7/4.
//  Copyright © 2017年 RainPoll. All rights reserved.
//
#import "RegisteView.h"
#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    RegisteView *view =[[RegisteView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
