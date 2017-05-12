//
//  HuntingView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "HuntingView.h"
@interface HuntingView ()
@property (nonatomic ,weak)IBOutlet UIView *view;
@property (nonatomic ,assign)CGRect fFrame;

@property(nonatomic ,copy)BOOL(^willShowCallback)();
@property(nonatomic ,copy)BOOL(^willDissmissCallback)();

@property(nonatomic ,copy)void(^helpBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^setBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^voiceBtnClickCallback)(UIButton *btn);


@end

@implementation HuntingView
@synthesize model = _model;

-(void)setModel:(HuntingViewModel *)model{
    if(_model){
        [_model removeObserver:self forKeyPath:@"willShowCallback"];
        [_model removeObserver:self forKeyPath:@"willDissmissCallback"];
        [_model removeObserver:self forKeyPath:@"helpBtnClickCallback"];
        [_model removeObserver:self forKeyPath:@"setBtnClickCallback"];
        [_model removeObserver:self forKeyPath:@"voiceBtnClickCallback"];
    }
    if (model) {
        _model = model;
        [_model setValue:self forKey:@"view"];
        [_model addObserver:self forKeyPath:@"willShowCallback" options:NSKeyValueObservingOptionNew context:nil];
        [_model addObserver:self forKeyPath:@"willDissmissCallback" options:NSKeyValueObservingOptionNew context:nil];
    
        [_model addObserver:self forKeyPath:@"helpBtnClickCallback" options:NSKeyValueObservingOptionNew context:nil];
        [_model addObserver:self forKeyPath:@"setBtnClickCallback" options:NSKeyValueObservingOptionNew context:nil];
        [_model addObserver:self forKeyPath:@"voiceBtnClickCallback" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(BOOL (^)())willDissmissCallback{
    if (!_willDissmissCallback) {
        BOOL (^temp)(UIView *) = [self.model valueForKey:@"willDissmissCallback"];
        WeakObj(self);
        self.willDissmissCallback = ^BOOL(){
            if (temp) {
                return temp(weakself);
            }else{
                return YES;
            }
        };
    }
    return _willDissmissCallback;
}

-(HuntingViewModel *)model{
    if (!_model) {
        self.model = [[HuntingViewModel alloc]init];
    }
    return _model;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initFromNib];
        self.fFrame = frame;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initFromNib];
}

-(void)initFromNib{
    [[NSBundle mainBundle]loadNibNamed:@"HuntingView" owner:self options:nil];
    [self addSubview:_view];
}

-(void)drawRect:(CGRect)rect{
    if (CGRectIsNull(self.fFrame)) {
        self.frame = self.fFrame;
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == nil) {
        NSLog(@"keyPath:%@\n obj:%@\n change:%@",keyPath,object,change);
        if ([keyPath isEqualToString:@"willShowCallback"]) {
            BOOL (^temp)(UIView *) = change[@"new"];
            WeakObj(self);
            self.willShowCallback = ^BOOL(){
                if (temp) {
                    return temp(weakself);
                }else{
                    return YES;
                }
            };
        }
        if ([keyPath isEqualToString:@"willDissmissCallback"]) {
            BOOL (^temp)(UIView *) = change[@"new"];
            WeakObj(self);
            self.willDissmissCallback = ^BOOL(){
                if (temp) {
                    return temp(weakself);
                }else{
                    return YES;
                }
            };
        }
        if ([keyPath isEqualToString:@"helpBtnClickCallback"]) {
            void (^temp)(UIButton *) = change[@"new"];
            self.helpBtnClickCallback = ^(UIButton *btn){
                if (temp) {
                    temp(btn);
                }
            };
        }
        if ([keyPath isEqualToString:@"setBtnClickCallback"]) {
            void (^temp)(UIButton *) = change[@"new"];
            self.setBtnClickCallback = ^(UIButton *btn){
                if (temp) {
                    temp(btn);
                }
            };
        }
        if ([keyPath isEqualToString:@"voiceBtnClickCallback"]) {
            void (^temp)(UIButton *) = change[@"new"];
            self.voiceBtnClickCallback = ^(UIButton *btn){
                if (temp) {
                    temp(btn);
                }
            };
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}




-(IBAction)backBtnClick:(UIButton *)btn{
    WeakObj(self);
    !self.willDissmissCallback ? : self.willDissmissCallback(weakself);
}
-(IBAction)helpBtnClick:(UIButton *)btn{
    
}
-(IBAction)setBtnClick:(UIButton *)btn{
    
}
-(IBAction)actionBtnClick:(UIButton *)btn{
    
}

-(void)dealloc{
    
    @try{
        [self.model removeObserver:self forKeyPath:@"willShowCallback"];
        [self.model removeObserver:self forKeyPath:@"willDissmissCallback"];
        [self.model removeObserver:self forKeyPath:@"helpBtnClickCallback"];
        [self.model removeObserver:self forKeyPath:@"setBtnClickCallback"];
        [self.model removeObserver:self forKeyPath:@"voiceBtnClickCallback"];

    }
    @catch(NSException *e){
        NSLog(@"model remove observer error%@",e);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
