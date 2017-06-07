//
//  ExpressionView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/9.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "SignInView.h"
#import "SignInViewModel.h"
//#import "ExpressionViewModel.h"

//typedef enum : NSUInteger {
//    BTN_TAG_0 = 1000,
//    BTN_TAG_1 = 2000,
//    BTN_TAG_2 = 3000,
//    BTN_TAG_3 = 4000,
//    BTN_TAG_4 = 5000,
//    BTN_TAG_5 = 6000,
//} BTN_TAG;

@interface SignInView()

@property(nonatomic ,weak)IBOutlet UIView *view;

@property(nonatomic ,copy)void(^selectItem)(NSInteger tag);
@property(nonatomic ,copy)void(^close)(void);
@property(nonatomic ,copy)int(^test)(int);

@end

@implementation SignInView

-(void)setModel:(SignInViewModel *)model{
    if (model) {
        _model = model;
        [_model setValue:self forKey:@"view"];
        [self reloadImage];
    }
}
-(void)reloadImage{
    if (self.model.picturesName.count) {
        for (int i = 1 ; i<7;i++ ) {
            UIButton *btn = [self viewWithTag:i*1000];
            if (btn) {
              //  btn.buttonType = UIButtonTypeCustom;
                UIImage *image = [UIImage imageNamed:[self.model.picturesName objectAtIndex:i-1]];
                if (image) {
                    [btn setImage:image forState:UIControlStateNormal];
                }
            }
        }
    }
}
//绑定model callback
-(void (^)(NSInteger ))selectItem{
    if (!_selectItem) {
        void (^callback)(NSInteger ) = [_model valueForKey:@"didSelectItemCallback"];
        if (callback) {
            _selectItem = ^(NSInteger tag){
                callback(tag);
            };
        }
    }
    return _selectItem;
}
-(void (^)(void))close{
    if (!_close) {
        void(^callback)(void) = [_model valueForKey:@"willCloseCallback"];
        if(callback){
            _close =  ^(void){
                callback();
            };
        }
    }
    return _close;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initFromNib];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initFromNib];
}

-(void)initFromNib{
    [[NSBundle mainBundle]loadNibNamed:@"SignInView" owner:self options:nil];
    [self addSubview:self.view];
}


-(IBAction)close:(id)sender{
    !self.close?:self.close();
    [[self class] dissmissOnWindow:nil];
}

-(IBAction)btnClick:(UIButton *)sender
{
    !self.selectItem?:self.selectItem( sender.tag/1000);
    
    NSLog(@"%s btn_id:%ld",__func__,sender.tag);
    if (sender.tag == BTN_TAG_0) {
    
    }
    if (sender.tag == BTN_TAG_1) {
        
    }
    if (sender.tag == BTN_TAG_2) {
        
    }
    if (sender.tag == BTN_TAG_3) {
        
    }
    if (sender.tag == BTN_TAG_4) {
        
    }
    if (sender.tag == BTN_TAG_5) {
        
    }
}

+(void)showOnWindow:(void (^)(void))complient{
    
    SignInView *temp = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //动画
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        NSArray *windowArr = [UIApplication sharedApplication].windows;
        window = [windowArr objectAtIndex:0];
    }
    //    [window addSubview:temp];
    NSLog(@"%@",window.subviews);
    
    [window insertSubview:temp atIndex:window.subviews.count];
    [window bringSubviewToFront:temp];

//    temp.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    [UIView animateWithDuration:2.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        temp.transform = CGAffineTransformIdentity;
//        
//    } completion:nil];
    
   // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //  [window bringSubviewToFront:temp];
   // });

    //     [temp initFromNib];
    !complient ? :complient();
}

+(void)dissmissOnWindow:(void (^)(bool dissMiss))complient{
    bool isFound = NO;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    for (id temp in [window subviews]) {
        if ([temp isKindOfClass: [self class]]) {
            NSLog(@"find ConnectView will remove from window%@",temp);
            [((typeof(self))temp) removeFromSuperview];
            isFound = YES;
        }
    }
    !complient? : complient(isFound);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
