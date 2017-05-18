//
//  HelpView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//
#import "HelpView.h"

@implementation HelpView

-(instancetype)initFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"HelpView" owner:nil options:nil]firstObject];
}

+(instancetype)helpViewFromNib{
    return [[self alloc]initFromNib];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(IBAction)backBtnClick :(id)sender{
    [self dissmissOnWindow];
}

-(void)showOnWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
    if (!window) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window addSubview:self];
}

-(void)dissmissOnWindow{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    for (id temp in [window subviews]) {
        if ([temp isKindOfClass: [self class]]) {
            NSLog(@"find ConnectView will remove from window%@",temp);
            [((typeof(self))temp) removeFromSuperview];
        }
    }
}


@end
