//
//  VoiceView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "VoiceView.h"
#import "VoiceViewModel.h"
#import "SiriView.h"

@interface VoiceView ()
@property (nonatomic ,assign)CGRect sFrame;

@property(nonatomic ,copy)BOOL(^willShowCallback)();
@property(nonatomic ,copy)BOOL(^willDissmissCallback)();

@property(nonatomic ,copy)void(^helpBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^setBtnClickCallback)(UIButton *btn);
@property(nonatomic ,copy)void(^voiceBtnClickCallback)(UIButton *btn);

@property(nonatomic ,weak)IBOutlet UIView *siriView;

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
        [_model addObserver:self forKeyPath:@"willDissmissCallback" options:NSKeyValueObservingOptionNew context:nil];
        
        [_model addObserver:self forKeyPath:@"helpBtnClickCallback" options:NSKeyValueObservingOptionNew context:nil];
        [_model addObserver:self forKeyPath:@"setBtnClickCallback" options:NSKeyValueObservingOptionNew context:nil];
        [_model addObserver:self forKeyPath:@"voiceBtnClickCallback" options:NSKeyValueObservingOptionNew context:nil];
    }
}
-(VoiceViewModel *)model{
    if (!_model) {
        self.model = [[VoiceViewModel alloc]init];
    }
    return _model;
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

#pragma mark - kvo 监听model中的callback 变化
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

#pragma mark - load siriView
-(void)loadSiriView{
    SiriView * siri = [[SiriView alloc] initWithFrame:CGRectMake(0, 0,350,60 ) ];

    __weak SiriView * weakSiri = siri;
 
    static CGFloat normalizedValue = 0.1;
    
    
    
    siri.siriLevelCallback = ^() {
        weakSiri.level = normalizedValue;
    };
    
    siri.level = 0.5;
    
    [NSTimer scheduledTimerWithTimeInterval:0.025 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static CGFloat index = 0;;
        index += 0.05;
        normalizedValue = sinf(index);
        
    }];
    
    [self.siriView addSubview:siri];
}


+(instancetype)voiceViewWithFrame:(CGRect)frame
{
    VoiceView *temp = [[NSBundle mainBundle]loadNibNamed:@"VoiceView" owner:nil options:nil].firstObject;
    temp.sFrame = frame;
    return temp;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"%s",__func__);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    NSLog(@"%s",__func__);
    return self;
}

-(void)drawRect:(CGRect)rect{
    self.frame = self.sFrame;
    [self loadSiriView];
}

-(IBAction)backBtnClick{
     bool isReturn = !self.willDissmissCallback ? : self.willDissmissCallback();
}

-(IBAction)helpBtnClick:(id)sender{

}

-(IBAction)setBtnClick:(id)sender{

}
-(IBAction)voiceBtnClick:(id)sender
{
   // !self.willShowCallback ?: self.willShowCallback();
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

@end
