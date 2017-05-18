//
//  MainViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "MainViewModel.h"

@interface MainViewModel ()
@property(nonatomic, copy)void(^didClickHelpBtnCallback)(void);
@property(nonatomic, copy)void(^didClickSetBtnCallback)(void);
@end

@implementation MainViewModel


-(NSArray *)pageListArr{
    if (!_pageListArr) {
        _pageListArr = @[];
    }
    return _pageListArr;
}


-(NSArray *)jumpPageListArr{
    if (!_jumpPageListArr) {
        _jumpPageListArr = @[];
    }
    return _jumpPageListArr;
}

-(void)didSeletItem:(void (^)(UIView *view, NSInteger index))callback{
    _didSeletItemCallback = callback;
}

-(void)didClickSetBtn:(void (^)(void))callback{
    _didClickSetBtnCallback = callback;
}
-(void)didClickHelpBtn:(void (^)(void))callback{
    _didClickHelpBtnCallback = callback;
}
@end
