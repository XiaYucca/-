//
//  PlayRecordView.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/12.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "PlayRecordViewCell.h"

@interface PlayRecordViewCell ()

@property (nonatomic ,weak) IBOutlet NSLayoutConstraint *progressRight;
@property (nonatomic ,weak) IBOutlet NSLayoutConstraint *progressLeght;
@property (nonatomic ,weak) IBOutlet UIView *progressView;

@property (nonatomic ,weak) IBOutlet UIView *contentView;

@end

@implementation PlayRecordViewCell{
    BOOL isAnimate;
}

/** ****** **/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initWithNib];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initWithNib];
    }
    return self;
}
-(void)initWithNib{
    
    [[NSBundle mainBundle]loadNibNamed:@"PlayRecordView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self custumFunc];
}
/** ****** **/

-(void)custumFunc{
    
}

-(void)setProgress:(CGFloat)progress{
    
    CGFloat width = self.progressView.frame.size.width;
    CGFloat temp = width*progress;
    
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





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
