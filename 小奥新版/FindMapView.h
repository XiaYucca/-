//
//  FindMapView.h
//  小奥新版
//
//  Created by RainPoll on 2017/6/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FindMapView : UIView


-(void)selectMapItem:(void(^)(NSInteger Item))callBack;
-(void)didClickBackBtn:(void(^)(void))callback;

@end
