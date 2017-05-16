//
//  ExpressionViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/10.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "SignInViewModel.h"

@interface SignInViewModel ()
@property(nonatomic,copy)void(^didSelectItemCallback)(NSInteger btntag);
@property(nonatomic,copy)void(^willCloseCallback)(void);


@end

@implementation SignInViewModel

-(void)viewDidSelectItem:(void(^)(NSInteger btntag))callback{
    self.didSelectItemCallback = callback;
}

-(void)viewWillClose:(void(^)())callback{
    self.willCloseCallback = callback;
}

@end
