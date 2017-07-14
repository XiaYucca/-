//
//  SlaveCmd.h
//  小奥新版
//
//  Created by RainPoll on 2017/6/21.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#ifndef SlaveCmd_h
#define SlaveCmd_h

#define DEVICE_ARDUINO_AND_IPHONE

//手机预编译开关
#define DEVIECE_IPHONE 1

// arduino 指令表
#ifdef DEVICE_ARDUINO_AND_IPHONE

#define CMD_DANCE           "dance"
#define CMD_SEAR            "sear"
#define CMD_FACE            "face"

#define CMD_STOP            "stoprun"
#define CMD_TURN_RIGHT      "rightturn"
#define CMD_TURN_LEFT       "leftturn"
#define CMD_TURN_BACK       "retreat"
#define CMD_TURN_ADVANCE    "advance"

#define CMD_NOD             "nod"
#define CMD_SHAKE           "shake"
#define CMD_RAISEL          "raisel"
#define CMD_RAINSER         "raiser"

#define CMD_VOLUME          "volume "
#define CMD_PLAY            "play"
#define CMD_NEXT            "next"
#define CMD_STOPMP3         "stopmp3"

#endif

//iphone
#if DEVIECE_IPHONE
static const NSString *INSTRUCT_DANCE       = @CMD_DANCE;
static const NSString *INSTRUCT_SEAR        = @CMD_SEAR;
static const NSString *INSTRUCT_FACE        = @CMD_FACE;

static const NSString *INSTRUCT_STOP        = @CMD_STOP;
static const NSString *INSTRUCT_TURN_RIGHT  = @CMD_TURN_RIGHT;
static const NSString *INSTRUCT_TURN_LEFT   = @CMD_TURN_LEFT;
static const NSString *INSTRUCT_TURN_BACK   = @CMD_TURN_BACK;
static const NSString *INSTRUCT_ADCANCE     = @CMD_TURN_ADVANCE;

static const NSString *INSTRUCT_NOD         = @CMD_NOD;
static const NSString *INSTRUCT_SHAKE       = @CMD_SHAKE;
static const NSString *INSTRUCT_RAISEL      = @CMD_RAISEL;
static const NSString *INSTRUCT_RAINSER     = @CMD_RAINSER;

static const NSString *INSTRUCT_VOLUME     = @CMD_VOLUME;
static const NSString *INSTRUCT_PLAY        = @CMD_PLAY;
static const NSString *INSTRUCT_NEXT        = @CMD_NEXT;
static const NSString *INSTRUCT_STOPMP3     = @CMD_STOPMP3;

#endif


#endif /* SlaveCmd_h */
