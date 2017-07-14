//
//  DetialMapView.m
//  小奥新版
//
//  Created by RainPoll on 2017/7/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DetialMapView.h"

@interface DetialMapView ()
@property (nonatomic ,weak)IBOutlet UIView *contentView;

@property (nonatomic ,weak)IBOutlet UIButton *playBtn;
@property (nonatomic ,weak)IBOutlet UIButton *resumBtn;

@end


@implementation DetialMapView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self initWithNib];
    }
    return self;
}


-(void)setMapName:(NSString *)mapName{
    if (mapName) {
        UIImageView *map = [self viewWithTag:100];
        
        UIImage *image =[UIImage imageNamed:mapName];
        if (image) {
            map.image = image;
        }
    }
    _mapName = mapName;
}

-(void)initWithNib{
    [[NSBundle mainBundle]loadNibNamed:@"DetialMapView" owner:self options:nil];
    [self setup];
}

-(void)setup{
    [self addSubview:self.contentView];
    
    [self.playBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.resumBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.resumBtn.selected = YES;
    
    if (_mapName) {
        UIImageView *map = [self viewWithTag:100];
        
        UIImage *image =[UIImage imageNamed:_mapName];
        if (image) {
            map.image = image;
        }
    }

}

-(void)btnClick:(UIButton *)sender{
    
    if (sender == self.playBtn) {
        sender.selected = !sender.selected;
        if (self.playBtn.selected == NO) {
            self.resumBtn.selected = YES;
        }else{
            self.resumBtn.selected = NO;
        }
    }else{
        if (self.playBtn.selected ==YES) {
            self.playBtn.selected = NO;
            self.resumBtn.selected = YES;
        }
    }
}

-(IBAction)backBtnClick:(id)sender{
    if (self.backBtnClickCallback) {
        self.backBtnClickCallback();
    }
}


@end
