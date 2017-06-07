//
//  Drawomg.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DrawingView.h"
#import "HMView.h"
#import "DrawingViewModel.h"

@interface DrawingView ()

@property(nonatomic ,weak)IBOutlet UIView *content;
@property(nonatomic ,weak)IBOutlet HMView *hmView;

@property(nonatomic ,weak)IBOutlet UIButton *btnWrite;
@property(nonatomic ,weak)IBOutlet UIButton *btnPlay;
@property(nonatomic ,weak)IBOutlet UIButton *btnRestart;
//@property (nonatomic ,strong) UIView *number;

@end

@implementation DrawingView

-(void)setModel:(DrawingViewModel *)model{
    if (model) {
        _model = model;
     //  WeakObj(self);
        [_model setValue:self forKey:@"view"];
    }
}

-(void (^)(void))dismiss{
    WeakObj(_model);
    WeakObj(self);
    if (!_dismiss) {
        _dismiss = ^(void){
            void(^callback)(UIView *view) = [weak_model valueForKey:@"didDissmissCallBack"];
            if(callback){
                callback(weakself);
            }
        };
    }
    return _dismiss;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initFromNib];
    }
    return self;
}

-(void)awakeFromNib{
    [self initFromNib];
}

-(void)initFromNib
{
    [[NSBundle mainBundle]loadNibNamed:@"DrawingView" owner:self options:nil];
    [self addSubview:self.content];
    [self loadHMView];
}

-(void)loadHMView
{
    self.hmView.lineColor = [UIColor blueColor];
    self.hmView.lineWidth = 8;
    
    [self.hmView hmViewAnimationDidStart:^{
        self.btnWrite.selected = YES;
    }];
    [self.hmView hmViewAnimationDidStop:^{
        self.btnWrite.selected = NO;
    }];
    //    [self.hmView reStart];
}

-(IBAction)restartDraw:(id)sender{
    self.btnPlay.selected = NO;
    self.btnWrite.selected = NO;
    [self.hmView clear];
}

-(IBAction)playDrawPath:(id)sender{
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;
    [self.hmView reStart];
}
-(IBAction)enableDraw:(id)sender{
    self.hmView.isEnable = !self.hmView.isEnable;
}
-(IBAction)close:(id)sender{
    !self.dismiss ? : self.dismiss();
  //  [self removeFromSuperview];
}

-(void)dismissDrawingView:(void (^)(void))callback{
    _dismiss = callback;
}

@end
