//
//  XYNotificationManage.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/20.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "XYNotificationManage.h"


@implementation XYNotificationManage

+(instancetype)shared{
    static XYNotificationManage *temp ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[XYNotificationManage alloc]init];
    });
    return temp;
}

-(void)addNotification{
    //iOS 10
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"request authorization succeeded!");
        }
    }];
    
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"%@",settings);
    }];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    //Local Notification
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Introduction to Notifications";
    content.subtitle = @"Session 707";
    content.body = @"Woah! These new notifications look amazing! Don’t you agree?";
    content.badge = @1;
    
    //Remote Notification
    //    {
    //        "aps" : {
    //            "alert" : {
    //                "title" : "Introduction to Notifications",
    //                "subtitle" : "Session 707",
    //                "body" : "Woah! These new notifications look amazing! Don’t you agree?"
    //            },
    //            "badge" : 1
    //        },
    //    }
    //
    //2 分钟后提醒
    
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];
    
    //每小时重复 1 次喊我喝水
    UNTimeIntervalNotificationTrigger *trigger2 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3600 repeats:YES];
    
    //每周一早上 8：00
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.weekday = 2;
    components.hour = 8;
    UNCalendarNotificationTrigger *trigger3 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    //#import <CoreLocation/CoreLocation.h>
    //    //一到麦当劳就喊我下车
    //    CLRegion *region = [[CLRegion alloc] init];
    //    UNLocationNotificationTrigger *trigger4 = [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
    
    NSString *requestIdentifier = @"sampleRequest";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                          content:content
                                                                          trigger:trigger1];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];

}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    XLog(@"%s",__func__);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    XLog(@"%s",__func__);
}


-(void)removeNotificationByIDList:(NSArray<NSString *>*)idList{
    //ios10
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter  currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:idList];
}

@end
