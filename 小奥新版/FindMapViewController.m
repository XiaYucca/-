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
//    FindMapView *findV = [[FindMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.view = findV;
    ScenarioSimulation *view = [[ScenarioSimulation alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;

}


@end
