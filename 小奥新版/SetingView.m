//
//  SetingView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/3.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "SetingView.h"
#import "SetingViewModel.h"

#define VOICEBTN_TAG 1000
#define MUSEICBTN_TAG 2000
#define LANGUAGEBTN_CN_TAG 3000
#define LANGUAGEBTN_EN_TAG 4000

@interface SetingView ()
@property (nonatomic ,weak)IBOutlet UIView *content;
@property (nonatomic ,assign)CGRect sFrame;

@end

@implementation SetingView
@synthesize model = _model;

-(SetingViewModel*)model{
    if (!_model) {
        _model = [[SetingViewModel alloc]init];
        _model.view = self;
    }
    return _model;
}

-(void)setModel:(SetingViewModel *)model
{
    if (model) {
        _model = model;
        _model.view = self;
    }
}

-(IBAction)backBtnClick:(id)sender{
    WeakObj(self);
    BOOL canRemove = YES;
    if (_model.viewWillDissmiss) {
      canRemove = _model.viewWillDissmiss(weakself);
    }
    if (canRemove) {
        [self removeFromSuperview];
    }
  //  NSLog(@"%@",self.model);
}

-(IBAction)voiceTag:(UIButton *)sender{
    static bool language_select = 0;
    switch (sender.tag) {
        case VOICEBTN_TAG:
            sender.selected = ! sender.selected;
            self.model.enableVoice =  !sender.selected;
            break;
        case MUSEICBTN_TAG:
            sender.selected = ! sender.selected;
            self.model.enableMusic = ! sender.selected;
            break;
        case LANGUAGEBTN_CN_TAG:
            {
                UIButton *enBtn = [self viewWithTag:LANGUAGEBTN_EN_TAG];
                enBtn.selected = ! enBtn.selected;
                sender.selected = ! sender.selected;
                self.model.isChinese = sender.selected ? NO: YES;
            }
            break;
        case LANGUAGEBTN_EN_TAG:
            {
                UIButton *enBtn = [self viewWithTag:LANGUAGEBTN_CN_TAG];
                enBtn.selected = ! enBtn.selected;
                sender.selected = ! sender.selected;
                self.model.isChinese = enBtn.selected ? NO: YES;
            }
            break;
        default:
            break;
    }
    if(self.model.clickBtn){
        WeakObj(sender);
        self.model.clickBtn(weaksender);
    }
  //  NSLog(@"%@",self.model);
}

-(void)reloadStatusByModel{
    UIButton *enBtn = [self viewWithTag:LANGUAGEBTN_EN_TAG];
    enBtn.selected = self.model.isChinese;
    UIButton *cnBtn = [self viewWithTag:LANGUAGEBTN_CN_TAG];
    cnBtn.selected = !self.model.isChinese;
    
    UIButton *voiceBtn = [self viewWithTag:VOICEBTN_TAG];
    voiceBtn.selected = !self.model.enableVoice;
    UIButton *musicBtn = [self viewWithTag:MUSEICBTN_TAG];
    musicBtn.selected = !self.model.enableMusic;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.sFrame = frame;
        [self initFromNib];
    }
    return self;
}

-(void)initFromNib{
    WeakObj(self);
    if (_model.viewWillShow) {
        _model.viewWillShow(weakself);
    }
    [[NSBundle mainBundle]loadNibNamed:@"SetingView" owner:self options:nil];
    [self addSubview:self.content];
    [self reloadStatusByModel];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initFromNib];

}

-(void)drawRect:(CGRect)rect{
    if (CGRectIsNull(self.sFrame)) {
        self.frame = self.sFrame;
    }
}

@end
