//
//  DetialMapView.h
//  小奥新版
//
//  Created by RainPoll on 2017/7/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetialMapView : UIView

@property(nonatomic ,copy)NSString *mapName;

@property (nonatomic ,copy) void(^backBtnClickCallback)(void);

@end
