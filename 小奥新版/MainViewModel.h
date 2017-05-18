//
//  MainViewModel.h
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MainViewModel : NSObject

@property(nonatomic,strong)NSArray<NSString *> *pageListArr;
@property(nonatomic,strong)NSArray<NSString *> *jumpPageListArr;

@property (nonatomic ,copy)void(^didSeletItemCallback)(UIView *view, NSInteger index);

-(void)didSeletItem:(void(^)(UIView *view ,NSInteger index))callback;

-(void)didClickSetBtn:(void(^)(void))callback;
-(void)didClickHelpBtn:(void(^)(void))callback;

@end
