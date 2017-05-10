//
//  ExpressionView.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/9.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ExpressionView.h"
#import "ExpressionViewModel.h"

//typedef enum : NSUInteger {
//    BTN_TAG_0 = 1000,
//    BTN_TAG_1 = 2000,
//    BTN_TAG_2 = 3000,
//    BTN_TAG_3 = 4000,
//    BTN_TAG_4 = 5000,
//    BTN_TAG_5 = 6000,
//} BTN_TAG;

@interface ExpressionView()

@property(nonatomic ,weak)IBOutlet UIView *view;

@property(nonatomic ,copy)void(^selectItem)(NSInteger tag);
@property(nonatomic ,copy)void(^close)(void);

@property(nonatomic ,copy)int(^test)(int);

@end

@implementation ExpressionView

-(void)setModel:(ExpressionViewModel *)model{
    if (model) {
        _model = model;
        [_model setValue:self forKey:@"view"];
        [self reloadImage];
    }
}
-(void)reloadImage{
    if (self.model.picturesName.count) {
        for (int i = 1 ; i<7;i++ ) {
            UIButton *btn = [self viewWithTag:i*1000];
            if (btn) {
              //  btn.buttonType = UIButtonTypeCustom;
                UIImage *image = [UIImage imageNamed:[self.model.picturesName objectAtIndex:i-1]];
                if (image) {
                    [btn setImage:image forState:UIControlStateNormal];
                }
            }
        }

    }
}
//绑定model callback
-(void (^)(NSInteger ))selectItem{
    if (!_selectItem) {
        void (^callback)(NSInteger ) = [_model valueForKey:@"didSelectItemCallback"];
        if (callback) {
            _selectItem = ^(NSInteger tag){
                callback(tag);
            };
        }

    }
    return _selectItem;
}
-(void (^)(void))close{
    if (!_close) {
        void(^callback)(void) = [_model valueForKey:@"willCloseCallback"];
        if(callback){
            _close =  ^(void){
                callback();
            };
        }
    }
    return _close;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initFromNib];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initFromNib];
}

-(void)initFromNib{
    [[NSBundle mainBundle]loadNibNamed:@"ExpressionView" owner:self options:nil];
    [self addSubview:self.view];
}


-(IBAction)close:(id)sender{
    !self.close?:self.close();
}

-(IBAction)btnClick:(UIButton *)sender
{
    !self.selectItem?:self.selectItem( sender.tag/1000);
    
    NSLog(@"%s btn_id:%ld",__func__,sender.tag);
    if (sender.tag == BTN_TAG_0) {
    
    }
    if (sender.tag == BTN_TAG_1) {
        
    }
    if (sender.tag == BTN_TAG_2) {
        
    }
    if (sender.tag == BTN_TAG_3) {
        
    }
    if (sender.tag == BTN_TAG_4) {
        
    }
    if (sender.tag == BTN_TAG_5) {
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
