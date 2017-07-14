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
#import "XYNotificationManage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(XYSerialManage *)siralManage{
    if (!_siralManage) {
        _siralManage = [[XYSerialManage alloc]init];
    }
    return _siralManage;
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
    
    //iOS 10 before
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
//    [application registerUserNotificationSettings:settings];
//    
       
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


-(void)testNotification{
    // 1.创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 2.设置本地通知的内容
    // 2.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
    // 2.2.设置通知的内容
    localNote.alertBody = @"在干吗?";
    // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
    localNote.alertAction = @"解锁";
    // 2.4.决定alertAction是否生效
    localNote.hasAction = NO;
    // 2.5.设置点击通知的启动图片
    localNote.alertLaunchImage = @"123Abc";
    // 2.6.设置alertTitle
    localNote.alertTitle = @"你有一条新通知";
    // 2.7.设置有通知时的音效
    localNote.soundName = @"buyao.wav";
    // 2.8.设置应用程序图标右上角的数字
    localNote.applicationIconBadgeNumber = 999;
    
    // 2.9.设置额外信息
    localNote.userInfo = @{@"type" : @1};
    
    // 3.调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];

}

/*
 应用程序在进入前台,或者在前台的时候都会执行该方法
 */
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    // 必须要监听--应用程序在后台的时候进行的跳转
////    if (application.applicationState == UIApplicationStateInactive) {
////        NSLog(@"进行界面的跳转");
////        // 如果在上面的通知方法中设置了一些，可以在这里打印额外信息的内容，就做到监听，也就可以根据额外信息，做出相应的判断
////        NSLog(@"%@", notification.userInfo);
////        
////        //
////        UIView *redView = [[UIView alloc] init];
////        redView.frame = CGRectMake(0, 0, 100, 100);
////        redView.backgroundColor = [UIColor redColor];
////        [self.window.rootViewController.view addSubview:redView];
////    }
//    XLog(@"%s",__func__);
//
//}


@end
