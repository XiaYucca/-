//
//  PlayRecordView.h
//  小奥新版
//
//  Created by RainPoll on 2017/6/12.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayRecordViewCell : UITableViewCell

@property (nonatomic ,assign)CGFloat progress;

-(void)setProgress:(CGFloat)progress withAnimation:(BOOL)animate;

@end

