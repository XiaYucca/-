//
//  FindMapView.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FindMapView.h"

typedef NS_ENUM(NSUInteger, MAP_BTN_TAG) {
    MAP_BTN_1_TAG = 1001,
    MAP_BTN_2_TAG = 1002,
    MAP_BTN_3_TAG = 1003,
    
    MAP_BTN_4_TAG = 1004,
    MAP_BTN_5_TAG = 1005,
    MAP_BTN_6_TAG = 1006,
};


@interface FindMapView ()

@property (nonatomic ,weak)IBOutlet UIView *contentView;
@property (nonatomic ,copy)void(^btnClickCallback)(NSInteger);
@property (nonatomic ,copy)void(^backBtnCallaback)(void);

@end


@implementation FindMapView

-(void)setup{
    
    for(int i=MAP_BTN_1_TAG; i <= MAP_BTN_6_TAG; i++){
        UIButton *btn = [self viewWithTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self loadFromNib];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self loadFromNib];
    }
    return self;
}

-(void)loadFromNib{
    [[NSBundle mainBundle]loadNibNamed:@"FindMapView" owner:self options:nil];
    [self addSubview:_contentView];
    [self setup];
}

-(void)selectMapItem:(void(^)(NSInteger Item))callBack{
    _btnClickCallback = callBack;
}

-(IBAction)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case MAP_BTN_1_TAG:
            break;
        case MAP_BTN_2_TAG:
            break;
        case MAP_BTN_3_TAG:
            break;
        case MAP_BTN_4_TAG:
            break;
        case MAP_BTN_5_TAG:
            break;
        case MAP_BTN_6_TAG:
            break;
        default:
            break;
    }
    if(_btnClickCallback){
        _btnClickCallback(sender.tag);
    }
}

-(IBAction)backBtnClick:(id)sender{
    ! self.backBtnCallaback ?: self.backBtnCallaback();
}

-(void)didClickBackBtn:(void(^)(void))callback{
    self.backBtnCallaback = callback;
}



@end
