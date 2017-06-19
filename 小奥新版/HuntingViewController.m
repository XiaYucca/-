//
//  HuntingViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "HuntingViewController.h"
#import "HuntingView.h"
#import "HuntingViewModel.h"

@interface HuntingViewController ()

@end

@implementation HuntingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HuntingViewModel *model = [[HuntingViewModel alloc]init];
    WeakObj(self);
    
    [model willDissmiss:^BOOL(UIView *v) {
        //[[Route share]GoBackFromController:weakself];
        [self dismissViewControllerAnimated:YES completion:nil];
        return YES;
    }];
    
    ((HuntingView *)self.view).model = model;

    [model voiceBtnClick:^(UIButton *btn) {
        [[Route share]GoToControllerIsPush:NO ClassName:@"FindMapViewController" From:self PropertyDic:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadView
{
    self.view = [[HuntingView alloc]initWithFrame:[UIScreen mainScreen].bounds];
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
