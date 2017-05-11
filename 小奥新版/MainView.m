//
//  MainView.m
//  小奥新版
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "MainView.h"
#import "iCarousel.h"
#import "NSMutableArray+Queue.h"
#import "MainViewModel.h"

@interface MainView ()<iCarouselDelegate,iCarouselDataSource>
@property (strong, nonatomic) IBOutlet UIView *content;
@property (strong, nonatomic) IBOutlet iCarousel *icarV;

@property (strong, nonatomic) NSMutableArray *pageList;
@property (nonatomic ,assign)CGRect rFrame;

@end


@implementation MainView



-(void)setModel:(MainViewModel *)model{
    if (model) {
        self.pageList = [model.pageListArr mutableCopy];
        _model = model;
        [self.icarV reloadData];
    }
}

-(NSArray *)pageList{
   // _pageList = [_model.pageListArr mutableCopy];
    if (!_pageList) {
        _pageList = [@[]mutableCopy];
    }
    return _pageList;
}

-(void (^)(UIView *, NSInteger))didSeletItemCallback{
    if (!_didSeletItemCallback) {
        _didSeletItemCallback = [_model.didSeletItemCallback copy];
    }
    return _didSeletItemCallback;
}



+(instancetype)MainView:(CGRect)frame{
    //用这种方法不需要在fileowner设置self 需要指定wiew 为当前类 并且所属的连线 都拖出来的属性都和改view相关
    MainView *temp = [[NSBundle mainBundle]loadNibNamed:@"MainView" owner:self options:nil].firstObject;
    NSLog(@"temp %@",temp);
    temp.frame = frame;
    temp.rFrame = frame;
    
    return temp;
//    return  self;
}

-(void)setupIcarView{
    
  //  self.icarV = [[iCarousel alloc]initWithFrame:self.icarV.frame];
    self.icarV.type = iCarouselTypeCustom;
    self.icarV.backgroundColor = [UIColor clearColor];
   // self.icarV.perspective = - 0.01;
    self.icarV.stopAtItemBoundary = NO;
    self.icarV.scrollToItemBoundary = NO;
 //   [self addSubview:self.icarV];
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"%s",__func__);
    
  
}

-(instancetype)init{
    NSLog(@"--------init");
    self = [super init];
    return  self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"%s",__func__);
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"%s",__func__);
    self = [super initWithFrame:frame];
 //   [self initFromNib];
 
    return self;
}


#pragma mark - icarViewDataSources
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.pageList.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.icarV.frame.size.height, self.icarV.frame.size.height)];
    id d = [self.pageList pop];
    if ( [d isKindOfClass:[NSString class]]) {
        imageV.image = [UIImage imageNamed:(NSString *)d];
    }
    
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
    return CATransform3DTranslate(transform, offset * self.icarV.itemWidth * 1.2, 0.0, 0.0);
}


-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    WeakObj(carousel);
    NSLog(@"点击了 %ld",index);
    !self.didSeletItemCallback ? :_didSeletItemCallback(weakcarousel,index);
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"%s",__func__);
    [self setupIcarView];
    
    self.frame = self.rFrame;
}


@end
