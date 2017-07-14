//
//  Registe.m
//  小奥新版
//
//  Created by RainPoll on 2017/7/4.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "RegisteView.h"

@interface RegisteView ()

@property(nonatomic, weak)IBOutlet UIView *contentView;

@property(nonatomic ,weak)IBOutlet UITextField *mailFeild;
@property (nonatomic ,weak)IBOutlet UITextField *passwordFeild;

@end

@implementation RegisteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self initWithNib];
    }
    
    return self;
}
-(void)initWithNib{
    [[NSBundle mainBundle]loadNibNamed:@"RegisteView" owner:self options:nil];
    [self setup];
}

-(void)setup{
    [self addSubview:self.contentView];
    CGRect frame = self.mailFeild.frame;//f表示你的textField的frame
    frame.size.width = 15;//设置左边距的大小
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.mailFeild.leftViewMode = UITextFieldViewModeAlways;//设置左边距显示的时机，这个表示一直显示
    self.mailFeild.leftView = leftview;
    
    CGRect passLeftframe = self.mailFeild.frame;//f表示你的textField的frame
    passLeftframe.size.width = 15;//设置左边距的大小
    UIView *passleftview = [[UIView alloc] initWithFrame:frame];
    
    self.passwordFeild.leftViewMode = UITextFieldViewModeAlways;
    self.passwordFeild.leftView = passleftview;
    self.passwordFeild.secureTextEntry = YES;

}


@end
