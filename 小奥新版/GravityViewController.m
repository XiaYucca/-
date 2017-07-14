//
//  GravityViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/21.
//  Copyright © 2017年 RainPoll. All rights reserved.
//
#import "GravityView.h"
#import "GravityViewController.h"

@interface GravityViewController ()

@end

@implementation GravityViewController

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
    self.view = [[GravityView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

@end
