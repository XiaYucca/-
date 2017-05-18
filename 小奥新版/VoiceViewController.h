//
//  VoiceViewController.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDRecognizerViewController.h"
#import "BDVRSConfig.h"

#import "BDVoiceRecognitionClient.h"
#import "BDVRRawDataRecognizer.h"
#import "NSMutableArray+Queue.h"


/*
 App ID: 9657097
 
 API Key: zc2zakHcSmQdaSGgMcf4TRnu
 
 Secret Key: 7381171bf72085044b7381109b128774
 */
//#error 请修改为您在百度开发者平台申请的API_KEY和SECRET_KEY
#define API_KEY @"zc2zakHcSmQdaSGgMcf4TRnu" // 请修改为您在百度开发者平台申请的API_KEY
#define SECRET_KEY @"7381171bf72085044b7381109b128774" // 请修改您在百度开发者平台申请的SECRET_KEY

//#error 请修改为您在百度开发者平台申请的APP ID
#define APPID @"9657097" // 请修改为您在百度开发者平台申请的APP ID

@interface VoiceViewController : UIViewController

@end
