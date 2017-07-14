//
//  ExpressionViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/10.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ExpressionViewController.h"
#import "ExpressionView.h"
#import "ExpressionViewModel.h"

@interface ExpressionViewController ()

@end

@implementation ExpressionViewController

-(void)loadView{
    self.view = [[ExpressionView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ExpressionViewModel *model = [[ExpressionViewModel alloc]init];
    model.picturesName = @[@"X-btn-",@"X-btn-",@"X-btn-",@"音乐",@"音乐",@"音乐"];
    WeakObj(self);
    [model viewWillClose:^{
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [model viewDidSelectItem:^(NSInteger btntag) {
        NSLog(@"%s,%ld",__func__,btntag);
    }];
    
    ((ExpressionView *)(self.view)).model = model;
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
