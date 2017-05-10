//
//  EditFaceView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "EditFaceView.h"
#import "EditFaceViewModel.h"
#import "FaceView.h"

@interface EditFaceView ()
@property (nonatomic, weak)IBOutlet UIView *view;
@property (nonatomic, weak)IBOutlet FaceView *leftFaceView;
@property (nonatomic, weak)IBOutlet FaceView *rightFaceView;

@end
@implementation EditFaceView

@synthesize model = _model;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(EditFaceViewModel *)model{
    if (!_model) {
        _model = [[EditFaceViewModel alloc]init];
    }
    return _model;
}
-(void)setModel:(EditFaceViewModel *)model{
    if (model) {
        _model = model;
        _model.view = self;
    }
}

-(FaceView *)leftFaceView{
    if (!_leftFaceView) {
        _leftFaceView = [self viewWithTag:1000];

    }
    return _leftFaceView;
}
-(FaceView *)rightFaceView{
    if (!_rightFaceView) {
       _rightFaceView = [self viewWithTag:2000];
    }
    return _rightFaceView;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self EditFaceViewInitFromXib];

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self EditFaceViewInitFromXib];
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}

-(void)EditFaceViewInitFromXib{
    [[NSBundle mainBundle]loadNibNamed:@"EditFaceView" owner:self options:nil];
    [self addSubview:_view];
    [self.leftFaceView addObserver:self forKeyPath:@"fontHexValue" options:NSKeyValueObservingOptionNew context:nil];
    [self.rightFaceView  addObserver:self forKeyPath:@"fontHexValue" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.leftFaceView) {
        NSData *ldata = change[@"new"];
        NSArray *arr = self.model.faceHexData;
        self.model.faceHexData = @[ldata,arr[0]];
    }
    if (object == self.rightFaceView) {
        NSData *rdata = change[@"new"];
        NSArray *arr = self.model.faceHexData;
        self.model.faceHexData = @[arr[0],rdata];
    }
    NSLog(@"%@",self.model.faceHexData);
}

+(instancetype)EditFaceViewWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame];
}


//这个从xib加载后调用的(storyboard 直接关联类加载视图时候调用的)
-(void)awakeFromNib{
    [self EditFaceViewInitFromXib];
}


- (void)drawRect:(CGRect)rect {
    
 //   [self EditFaceViewInitFromXib];
}

-(IBAction)clearBtnClick:(id)sender{
    [self.leftFaceView clear];
    [self.rightFaceView clear];
    !self.model.clear? :self.model.clear();
}

-(IBAction)sendBtnClick:(id)sender{
    !self.model.send ? :self.model.send();
}

-(IBAction)Close:(id)sender{
    !self.model.close ?:self.model.close();
    [self.leftFaceView removeObserver:self forKeyPath:@"fontHexValue"];
    [self.rightFaceView removeObserver:self forKeyPath:@"fontHexValue"];
    [self removeFromSuperview];
}




@end
