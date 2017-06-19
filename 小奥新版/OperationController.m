//
//  OperationController.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "OperationController.h"
#import "OperationView.h"
#import "ConnectViewController.h"

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
    };
    
    opv.setBtnClickCallBack = ^(){
       // [[Route share]GoToControllerIsPush:YES ClassName:@"ConnectViewController" From:self PropertyDic:nil];
        [self presentViewController:[[ConnectViewController alloc]init] animated:NO completion:nil];
    };
    opv.dissMissCallBack = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
//    opv.setBtnClickCallBack = ^{
//        [Route share]GoToControllerIsPush:YES ClassName:"" From:<#(UIViewController *)#> PropertyDic:<#(NSDictionary *)#>
//    };
}

@end
