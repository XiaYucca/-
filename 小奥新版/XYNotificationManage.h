//
//  XYNotificationManage.h
//  小奥新版
//
//  Created by RainPoll on 2017/6/20.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface XYNotificationManage : NSObject <UNUserNotificationCenterDelegate>


/**
 管理本地通知 测试.
 */
+(instancetype)shared;
-(void)addNotification;
-(void)removeNotificationByIDList:(NSArray<NSString *>*)idList;
@end
