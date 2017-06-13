//
//  SaveOprationCell.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/8.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "SaveOprationCell.h"

@interface SaveOprationCell ()

@property(nonatomic ,weak)  IBOutlet UIButton *playBtn;
@property (nonatomic ,weak) IBOutlet UIView *progressView;

@property (nonatomic ,weak) IBOutlet NSLayoutConstraint *progressRight;
@property (nonatomic ,weak) IBOutlet NSLayoutConstraint *progressLeght;

@end

@implementation SaveOprationCell
{
   BOOL isAnimate;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)drawRect:(CGRect)rect{
    self.progress = 0.0;
}


-(IBAction)playBtnClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    [self setProgress:self.progress + 0.2 withAnimation:YES];
}


-(void)setProgress:(CGFloat)progress{
    
    if (progress > 1.0) {
        progress = 1.0;
    }
    if (progress < 0.0) {
        progress = 0.0;
    }
    _progress = progress;
    CGFloat width = self.progressView.frame.size.width;
    CGFloat temp = width*(1.0 - progress);
    
    if (isAnimate) {
        [UIView animateWithDuration:0.2 animations:^{
            self.progressRight.constant = temp;
            [self layoutIfNeeded];
        }];
    }else{
        self.progressRight.constant = temp;
        [self layoutIfNeeded];
    }
    
}

-(void)setProgress:(CGFloat)progress withAnimation:(BOOL)animate{
    isAnimate = animate;
    self.progress = progress;
}


@end
