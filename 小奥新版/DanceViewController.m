//
//  DanceViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/15.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DanceViewController.h"
#import "DanceView.h"

@interface DanceViewController ()

@end

@implementation DanceViewController

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

-(void)loadView
{
    DanceView *dv = [[DanceView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = dv;
    WeakObj(self);
    dv.backBtnCallback = ^{
        StrongObj(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

@end
