//
//  Drawomg.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DrawingView.h"
#import "HMView.h"

@interface DrawingView ()

@property(nonatomic ,weak)IBOutlet UIView *content;
@property(nonatomic ,weak)IBOutlet HMView *hmView;

@end

@implementation DrawingView

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
//    [self.hmView reStart];
}

-(IBAction)restartDraw:(id)sender{
    [self.hmView clear];
}
-(IBAction)playDrawPath:(id)sender{
    [self.hmView reStart];
}
-(IBAction)enableDraw:(id)sender{
    self.hmView.isEnable = !self.hmView.isEnable;
}

@end
