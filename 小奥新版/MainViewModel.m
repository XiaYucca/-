//
//  MainViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel


-(NSArray *)pageListArr{
    if (!_pageListArr) {
        _pageListArr = @[];
    }
    return _pageListArr;
}


-(NSArray *)jumpPageListArr{
    if (!_pageListArr) {
        _pageListArr = @[];
    }
    return _pageListArr;
}

-(void)didSeletItem:(void (^)(UIView *view, NSInteger index))callback{
    _didSeletItemCallback = callback;
}


@end
