//
//  ConnectViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/20.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ConnectViewController.h"
#import "MessageRoute.h"
#import "ConnectView.h"
#import "XYSerialManage.h"

#import "AppDelegate.h"


@interface ConnectViewController ()
@property (nonatomic ,weak)XYSerialManage *manage;

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
    XLog(@"-------");
    self.manage = appDelegate.siralManage;
    
    [self.manage blueToothAutoScaning:1 withTimeOut:30 autoConnectDistance:-100 didConnected:^(CBPeripheral *peripheral) {
        
        [[Route share]GoBackFromController:self];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),                  dispatch_get_main_queue(), ^{
//            [self.manage writeData:[@"dance" dataUsingEncoding: NSUTF8StringEncoding]];
//            sleep(1);
//            [self.manage writeData:[@"advance" dataUsingEncoding: NSUTF8StringEncoding]];
//            sleep(1);
//            [self.manage writeData:[@"stop" dataUsingEncoding: NSUTF8StringEncoding]];;
//        });
        
    } timeOutCallback:^{
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadView{
    self.view = [[ConnectView alloc]initWithFrame:[UIScreen mainScreen].bounds];
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
