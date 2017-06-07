//
//  OperationView.h
//  小奥新版
//
//  Created by RainPoll on 2017/6/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

/*
 功能	指令	说明
 开始		进入刷卡模式
 启动		刷卡结束 启动运行
 
 循环
 结束循环
 
 播放音乐	play 	指定播放歌曲时直接 使用 play x（x 歌曲编号 play与x之间加一个空格）
 上一首
 下一首	next
 播放停止	stopmp3
 音量+	volume	使用 volume x（x 音量大小 volume与x之间加一个空格 x取值 0-20 ）
 音量-
 
 点头	nod
 摇头	shake
 左看
 右看
 抬手 左	raisel
 右	raiser
 
 前进	advance	按下发送advance
 后退	retreat
 左转	leftturn
 右转	rightturn
 停止	stoprun	抬起按键发送stoprun
 
 表情	face	指定显示表情时直接 使用 face x（x 歌曲编号 face与x之间加一个空格）
	faces	发送faces进入表情编辑模式 表情格式 FE 00 00 00 00 00 00 00 00 以fe开头
 
 寻迹	sear
 跳舞	dance	使用 dance x（x 舞蹈编号号 dance与x之间加一个空格）
 */

static const NSString *INSTRUCT_DANCE = @"dance";
static const NSString *INSTRUCT_SEAR = @"sear";

static const NSString *INSTRUCT_FACE = @"face";

static const NSString *INSTRUCT_STOP = @"stoprun";
static const NSString *INSTRUCT_TURN_RIGHT = @"rightturn";
static const NSString *INSTRUCT_TURN_LEFT = @"leftturn";
static const NSString *INSTRUCT_TURN_BACK = @"retreat";
static const NSString *INSTRUCT_ADCANCE = @"advance";

static const NSString *INSTRUCT_NOD = @"nod";
static const NSString *INSTRUCT_SHAKE = @"shake";
static const NSString *INSTRUCT_RAISEL = @"raisel";
static const NSString *INSTRUCT_RAINSER = @"raiser";

static const NSString *INSTRUCT_VOLUME_ = @"volume ";
static const NSString *INSTRUCT_PLAY = @"play";
static const NSString *INSTRUCT_NEXT = @"next";
static const NSString *INSTRUCT_STOPMP3 = @"stopmp3";

#import <UIKit/UIKit.h>

@interface OperationView : UIView

@property (nonatomic ,weak)IBOutlet UIView *contentView;

@property (nonatomic ,weak)IBOutlet UIView *steeringWheel;

@end
