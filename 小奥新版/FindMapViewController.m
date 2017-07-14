//
//  FindMapViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "FindMapViewController.h"
#import "FindMapView.h"
#import "ScenarioSimulation.h"

@implementation FindMapViewController

-(void)viewDidLoad{

}

-(void)loadView{
    FindMapView *findV = [[FindMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [findV selectMapItem:^(NSInteger Item) {
        [[Route share]GoToControllerIsPush:NO ClassName:@"DetailMapViewController" From:self PropertyDic:@{@"picName":[NSString stringWithFormat:@"寻线-map%d",Item]}];
    }];
    
    [findV didClickBackBtn:^{
        [[Route share]GoBackFromController:self];
    }];
    
//    self.view = findV;
    ScenarioSimulation *view = [[ScenarioSimulation alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = findV;

}


@end
