//
//  CanvasLayer.h
//  RollViewDemo
//
//  Created by RainPoll on 16/5/9.
//  Copyright © 2016年 xinle.hou. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>




@interface CanvasLayer : CALayer

@property (nonatomic ,copy)NSMutableArray *path;

@property (nonatomic ,strong)UIImage *lightImage;

@property (nonatomic ,strong)UIImage *darkImage;


@end
