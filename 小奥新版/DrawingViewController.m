//
//  DrawingViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingView.h"
#import "DrawingViewModel.h"

@interface DrawingViewController ()

@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakObj(self);
    DrawingViewModel *drawingModel = [[DrawingViewModel alloc]init];
    [drawingModel didDissmissDrawingView:^(UIView *view) {
        NSLog(@"%s",__func__);
//  下面这样写也会引用循环
     //  [[Route share]GoBackFromController:self];
#warning //注意 : self ->view -> model ->block ->self 引用循环;
       //  [self dismissViewControllerAnimated:YES completion:nil];
       //正确写法
        [[Route share]GoBackFromController:weakself]; // or  [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    ((DrawingView *)self.view).model = drawingModel;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadView{
    DrawingView *drawV = [[DrawingView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view =drawV;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
