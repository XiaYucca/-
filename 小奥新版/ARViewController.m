/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/
#import <UserNotifications/UserNotifications.h>
#import "ARViewController.h"

@interface ARViewController ()

@end

@implementation ARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
    [btn setBackgroundImage:[UIImage imageNamed:@"Arrow-icon-blue"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeBtnClose) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self.glView setOrientation:self.interfaceOrientation];
    WeakObj(self);
    self.glView.didRecognizeImage = ^(NSUInteger index, NSString *info) {
        StrongObj(self);
        NSLog(@"did recognize index:%ld info:%@",index,info);
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"识别结果" message:info preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [ac addAction:action];
        [self presentViewController:ac animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ac dismissViewControllerAnimated:NO completion:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            });
        }];
    };
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView start];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView stop];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.glView resize:self.view.bounds orientation:self.interfaceOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.glView setOrientation:toInterfaceOrientation];
}

-(void)closeBtnClose{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
