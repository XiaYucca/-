//
//  DetailMapViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/7/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DetailMapViewController.h"
#import "DetialMapView.h"

@interface DetailMapViewController ()

@end

@implementation DetailMapViewController

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
    DetialMapView *dv = [[DetialMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if (self.picName) {
        dv.mapName = self.picName;
    }

    WeakObj(self);
    dv.backBtnClickCallback = ^{
        StrongObj(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };

    self.view = dv;
    
}

@end
