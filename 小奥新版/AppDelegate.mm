//
//  AppDelegate.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

#include "easyar/utility.hpp"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(XYSerialManage *)siralManage{
    return [[XYSerialManage alloc]init];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    UIWindow *window = delegate.window;
//    UIViewController *controller = [[MainViewController alloc] init];
//    window.rootViewController = controller;
////    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
////    aView.backgroundColor = [UIColor blackColor];
////    [controller.view addSubview:aView];
//    [window makeKeyAndVisible];
    _active = true;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

    _active = false;
    EasyAR::onPause();
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    _active = true;
    EasyAR::onResume();
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    _active = false;
}


@end
