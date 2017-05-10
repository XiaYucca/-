//
//  ExpressionViewModel.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/10.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExpressionView;
@interface ExpressionViewModel : NSObject

@property(nonatomic,weak,readonly)ExpressionView *view;
@property(nonatomic,strong)NSArray *picturesName;

-(void)viewDidSelectItem:(void(^)(NSInteger btntag))callback;
-(void)viewWillClose:(void(^)())callback;

@end
