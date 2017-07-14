//
//  GravityView.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/21.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "GravityView.h"
#import "XYMotionManager.h"
#import "XYDirectionCalculate.h"

#define GRAVITY_RAG 3

@interface GravityView ()

@property (nonatomic ,weak)IBOutlet UIView *contentView;
@property (nonatomic ,strong)XYMotionManager *manage;

@property (nonatomic ,weak)IBOutlet UIButton *upBtn;
@property (nonatomic ,weak)IBOutlet UIButton *downBtn;
@property (nonatomic ,weak)IBOutlet UIButton *leftBtn;
@property (nonatomic ,weak)IBOutlet UIButton *rightBtn;

@end

@implementation GravityView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initWithNib];
    }
    return self;
}

-(void)initWithNib{
    [[NSBundle mainBundle]loadNibNamed:@"GravityView" owner:self options:nil];
    [self addSubview:_contentView];
    [self setUp];
}


-(void)setGrateVector:(CGVector)vector{
    
    vector = CGVectorMake(vector.dx * 10, vector.dy * 10);
    NSLog(@"------x%.2f------y%.2f",vector.dx,vector.dy);
    
    if (vector.dx > GRAVITY_RAG) {
        NSLog(@"up");
        self.upBtn.selected = YES;
    }else
    {
        self.upBtn.selected = NO;

    }
    if (vector.dx < -GRAVITY_RAG) {
         NSLog(@"down");
        self.downBtn.selected = YES;

    }else{
        self.downBtn.selected = NO;
    }
    if (vector.dy > GRAVITY_RAG) {
         NSLog(@"left");
        self.leftBtn.selected = YES;
    }else{
        self.leftBtn.selected = NO;
    }
    if (vector.dy < -GRAVITY_RAG) {
         NSLog(@"right");
        self.rightBtn.selected = YES;
    }else{
        self.rightBtn.selected = NO;
    
    }
//    
//    if ( (vector.dx < ratGraty(0.2) && vector.dx > -ratGraty(0.2))&& (vector.dy < ratGraty(0.2) && vector.dy > -ratGraty(0.2))) {
//       
//        return;
//    }
}

-(void)setUp{
    XYMotionManager *manage =  [[XYMotionManager alloc]init];
    self.manage = manage;
    
    WeakObj(self);
    [manage accelerometerUpdateInterval:0.2 CallBack:^(XYacceleration acceleration, NSError *error) {
       // NSLog(@"x:%lf y:%lf z:%lf",acceleration.X ,acceleration.Y ,acceleration.Z);
        StrongObj(self);
        [self setGrateVector:CGVectorMake(acceleration.X, acceleration.Y)];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
