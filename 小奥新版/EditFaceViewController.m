//
//  EditFaceViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "EditFaceViewController.h"
#import "EditFaceView.h"
#import "EditFaceViewModel.h"

@interface EditFaceViewController ()

@end

@implementation EditFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EditFaceViewModel *model = [[EditFaceViewModel alloc]init];
    [model closeClick:^{
        [[Route share]GoBackFromController:self];
    }];
    
    ((EditFaceView *)self.view).model = model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    EditFaceView *view = [EditFaceView EditFaceViewWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
}


@end
