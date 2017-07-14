//
//  DanceView.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/15.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DanceView.h"
#import "iCarousel.h"

@interface DanceView ()<iCarouselDelegate, iCarouselDataSource>

@property (nonatomic ,weak)IBOutlet UIView *content;
@property (nonatomic ,weak)IBOutlet iCarousel *icarousel;

@property (nonatomic ,weak)IBOutlet UIView *ProgressVBK;
@property (nonatomic ,weak)IBOutlet UIView *progressV;
@property (nonatomic ,weak)IBOutlet NSLayoutConstraint *progressRoghtConstraint;
@property (nonatomic ,assign)CGFloat progress;


@end

@implementation DanceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame: frame]){
        [self initFromNib];
    }
    return self;
}

-(void)initFromNib{
    [[NSBundle mainBundle]loadNibNamed:@"DanceView" owner:self options:nil];
    [self addSubview:self.content];
    [self setUp];
}

//typedef enum
//{
//    iCarouselTypeLinear = 0,
//    iCarouselTypeRotary,
//    iCarouselTypeInvertedRotary,
//    iCarouselTypeCylinder,
//    iCarouselTypeInvertedCylinder,
//    iCarouselTypeWheel,
//    iCarouselTypeInvertedWheel,
//    iCarouselTypeCoverFlow,
//    iCarouselTypeCoverFlow2,
//    iCarouselTypeTimeMachine,
//    iCarouselTypeInvertedTimeMachine,
//    iCarouselTypeCustom
//}

-(void)setUp{
    self.icarousel.type = iCarouselTypeCustom;
  //  self.icarousel.perspective = - 0.05;
    self.icarousel.bounceDistance = 0.5;
    self.ProgressVBK.layer.cornerRadius = 2;
    self.ProgressVBK.layer.masksToBounds = YES;

}

-(void)setProgress:(CGFloat)progress{
    if (progress > 1.0) {
        progress = 1.0;
    }
    if (progress < 0.0) {
        progress = 0.0;
    }
    _progress = 1.0 - progress;
    self.progressRoghtConstraint.constant = _progress * CGRectGetWidth(self.ProgressVBK.frame);
//    [UIView animateWithDuration:2.5 animations:^{
//        [self.progressV layoutIfNeeded];
//    }];
    
}

-(IBAction)backBtnClick:(id)sender{
    if (self.backBtnCallback) {
        self.backBtnCallback();
    }
}


#pragma mark -iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 16;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, carousel.frame.size.height, carousel.frame.size.height)];
//    id d = [self.pageList objectAtIndex:index];
//    NSLog(@"image : %@",d);
//    imageV.image = d;
//    //    if ( [d isKindOfClass:[NSString class]]) {
//    //        imageV.image = [UIImage imageNamed:(NSString *)d];
//    //    }
//
//    imageV.backgroundColor = [UIColor lightGrayColor];
    imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"song_%d", index+1]];
    return  imageV;
}



#pragma mark - icarViewDelegate
-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.1f;
    static CGFloat min_scale = 0.9;
    
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
        
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    //   NSLog(@"offset %f",offset);
    //  UIView *viewV = [carousel viewWithTag:10];
    //  UIImageView *imageV = [viewV viewWithTag:2];
    //  imageV.hidden = YES;
    return CATransform3DTranslate(transform, offset * self.icarousel.itemWidth * 1.2, 0.0, 0.0);
}


-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    WeakObj(carousel);
    NSLog(@"点击了 %ld",index);
    
    self.progress = index * 0.1;
//  !self.didSeletItemCallback ? :_didSeletItemCallback(weakcarousel,index);
}



@end
