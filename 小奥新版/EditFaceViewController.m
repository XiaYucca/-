//
//  EditFaceViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "EditFaceViewController.h"
#import "EditFaceView.h"

@interface EditFaceViewController ()

@end

@implementation EditFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    EditFaceView *editV = [EditFaceView EditFaceViewWithFrame:self.view.frame];
//    self.view = editV;
//    self.view = [ed]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    EditFaceView *view = [EditFaceView EditFaceViewWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view = view;
}


@end
