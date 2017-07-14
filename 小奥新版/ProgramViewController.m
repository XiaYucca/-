//
//  ProgramViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/7/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ProgramViewController.h"
#import "ProgramView.h"

@interface ProgramViewController ()

@end

@implementation ProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loadView{
    ProgramView *view = [[ProgramView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    view.jsToIOSAlertCallback = ^(UIAlertController * _Nullable ac) {
        [self presentViewController:ac animated:YES completion:^{}];
        NSLog(@"alert ++++");
    };
    
    view.jsToBackCallback = ^(void (^complite)(id info)) {
        [self dismissViewControllerAnimated:YES completion:nil];
        complite(@"dissmiss info");
    };
}

@end
