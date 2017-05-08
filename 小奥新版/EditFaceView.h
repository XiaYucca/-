//
//  EditFaceView.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditFaceViewModel;
@interface EditFaceView : UIView
@property (nonatomic,strong)EditFaceViewModel *model;


+(instancetype)EditFaceViewWithFrame:(CGRect)frame;
+(instancetype)EditFaceViewWithFrame:(CGRect)frame Model:(EditFaceViewModel*)model;
@end
