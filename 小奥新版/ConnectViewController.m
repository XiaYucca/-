//
//  ConnectViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/20.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ConnectViewController.h"
#import "MessageRoute.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//  MessageRoute *r = [MessageRoute SharedRoute];

////    [r test];
////    NSLog(@"    [r test];");
//    [r evalObject_C:@"[[MessageRoute SharedRoute]testParm1:1 parm2:parm2 parm3:parm3]" CallBack:^(id response) {
//        NSLog(@"i=====d%@",[response class]);
//        NSLog(@"%@",response);
//    }];
    
//    [r evalObject_C:@"[[NSBundle mainBundle]loadNibNamed:\"MainView\" owner:self options:nil]" CallBack:^(id response) {
//        NSLog(@"i=====d%@",[response class]);
//        NSLog(@"%@",response);
//    }];
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

@end
