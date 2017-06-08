//
//  OperationController.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "OperationController.h"
#import "OperationView.h"

@interface OperationController ()

@end

@implementation OperationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadView{
    OperationView *opv =[[OperationView alloc]initWithFrame: [UIScreen mainScreen].bounds];
    self.view = opv;
    opv.callBack = ^(UIAlertController *vc){
        [self presentViewController:vc animated:YES completion:nil];
    } ;
    
}

@end
