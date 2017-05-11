//
//  VoiceViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "VoiceViewController.h"
#import "VoiceView.h"
#import "VoiceViewModel.h"

@interface VoiceViewController ()

@end

@implementation VoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    VoiceViewModel *model = [[VoiceViewModel alloc]init];
    ((VoiceView *)self.view).model = model;
    [model willShow:^BOOL(UIView *v) {
        NSLog(@"%s",__func__);
        return YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)loadView{
    self.view = [VoiceView voiceViewWithFrame:[UIScreen mainScreen].bounds];
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
