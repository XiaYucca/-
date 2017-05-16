//
//  HeadView.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+(instancetype)headView:(CGRect)frame{
    HeadView *head = [[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:nil options:nil]firstObject];;
    head.frame = frame;
    return head;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
