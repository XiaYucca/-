//
//  VoiceView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "VoiceView.h"
#import "VoiceViewModel.h"

@interface VoiceView ()
@property (nonatomic ,assign)CGRect sFrame;

@property(nonatomic ,copy)BOOL(^willShowCallback)();
@property(nonatomic ,copy)BOOL(^willDissmissCallback)();

@property(nonatomic ,copy)void(^helpBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^setBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^voiceBtnClickCallback)(UIButton *btn);

@end

@implementation VoiceView{
   // CGRect rFrame;
}
@synthesize model = _model;



#pragma mark -lazy load model;
-(void)setModel:(VoiceViewModel *)model{
    if (model) {
        _model = model;
        [_model setValue:self forKey:@"view"];
        [_model addObserver:self forKeyPath:@"willShowCallback" options:NSKeyValueObservingOptionNew context:nil];
    }
}
-(VoiceViewModel *)model{
    if (!_model) {
        _model = [[VoiceViewModel alloc]init];
    }
    return _model;
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
                    return NO;
                }
            };
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//-(BOOL (^)())willShowCallback{
//    if (!_willShowCallback) {
//        if (self.model) {
//            BOOL (^temp)(UIView *) = [_model valueForKey:@"willShowCallback"];
//            if (temp) {
//                WeakObj(self);
//                _willShowCallback = ^BOOL(void){
//                    return temp(weakself);
//                };
//            }
//        }
//    }
//    return _willShowCallback;
//}

+(instancetype)voiceViewWithFrame:(CGRect)frame
{
    VoiceView *temp = [[NSBundle mainBundle]loadNibNamed:@"VoiceView" owner:nil options:nil].firstObject;
   // temp->rFrame = frame;
    temp.sFrame = frame;
    return temp;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //self = self
    
    NSLog(@"%s",__func__);
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
      // self = [[NSBundle mainBundle]loadNibNamed:@"VoiceView" owner:nil options:nil].firstObject;
    }
    NSLog(@"%s",__func__);
    return self;
}
//-(instancetype)initWithFrame:(CGRect)frame{
//    
//}

-(void)drawRect:(CGRect)rect{
    self.frame = self.sFrame;
}

-(IBAction)backBtnClick{

}

-(IBAction)helpBtnClick:(id)sender{

}

-(IBAction)setBtnClick:(id)sender{

}

-(IBAction)voiceBtnClick:(id)sender
{

}


@end
