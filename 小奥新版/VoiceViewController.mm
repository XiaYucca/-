//
//  VoiceViewController.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "VoiceViewController.h"
#import "VoiceView.h"
#import "VoiceViewModel.h"


#define VOICE_LEVEL_INTERVAL 0.1 // 音量监听频率为1秒中10次

@interface VoiceViewController () <MVoiceRecognitionClientDelegate>
@property (nonatomic ,strong) NSTimer *voiceLevelMeterTimer;

@end

@implementation VoiceViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    VoiceViewModel *model = [[VoiceViewModel alloc]init];
    ((VoiceView *)self.view).model = model;
    [model willShow:^BOOL(UIView *v) {
        NSLog(@"%s",__func__);
        return YES;
    }];
    [model willDissmiss:^BOOL(UIView *v) {
        WeakObj(self);
        [[Route share]GoBackFromController:weakself];
        

        
        return YES;
    }];
    
    WeakObj(self);
    [model voiceBtnClick:^(UIButton *btn){
        
        [weakself startRecognitionWithoutUI];
        
        NSLog(@"voice btn %s",__func__);
        
    }];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [model willShow:^BOOL(UIView *v) {
//            NSLog(@"+++++++%s",__func__);
//            return YES;
//        }];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)loadView{
    self.view = [VoiceView voiceViewWithFrame:[UIScreen mainScreen].bounds];
}

#pragma mark - start baidu voice 

-(void)startRecognitionWithoutUI{
    printf("start RecognitionWithoutUI");
    // 设置开发者信息
    [[BDVoiceRecognitionClient sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];
    
    // 设置语音识别模式，默认是输入模式
    [[BDVoiceRecognitionClient sharedInstance] setPropertyList:@[[BDVRSConfig sharedInstance].recognitionProperty]];
    
    // 加载离线识别引擎
    NSString* appCode = APPID;
    //    NSString* licenseFilePath= [[NSBundle mainBundle] pathForResource:@"bdasr_temp_license" ofType:@"dat"];
    NSString* datFilePath = [[NSBundle mainBundle] pathForResource:@"s_1" ofType:@""];
    NSString* LMDatFilePath = nil;
    if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyMap) {
        LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_Navi" ofType:@""];
    } else if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyInput) {
        LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_InputMethod" ofType:@""];
    }
    
    NSDictionary* recogGrammSlot = @{@"$name_CORE" : @"张三\n李四\n",
                                     @"$song_CORE" : @"小苹果\n朋友\n",
                                     @"$app_CORE" : @"QQ\n百度\n微信\n百度地图\n",
                                     @"$artist_CORE" : @"刘德华\n周华健\n"};
    
    int ret = [[BDVoiceRecognitionClient sharedInstance] loadOfflineEngine:appCode
                                                                   license:nil
                                                                   datFile:datFilePath
                                                                 LMDatFile:LMDatFilePath
                                                                 grammSlot:recogGrammSlot];
    
    if (0 != ret) {
        NSLog(@"load offline engine failed: %d", ret);
        return;
    }

    int startStatus = -1;
    startStatus = [[BDVoiceRecognitionClient sharedInstance] startVoiceRecognition:self];
    if (startStatus != EVoiceRecognitionStartWorking) // 创建失败则报告错误
    {
        NSString *statusString = [NSString stringWithFormat:@"%d",startStatus];
        NSLog(@"失败报告---%@",statusString);
        return;
    }
    [BDVRSConfig sharedInstance].voiceLevelMeter = YES;
}


#pragma mark - VoiceLevelMeterTimer methods

- (void)startVoiceLevelMeterTimer
{
    [self freeVoiceLevelMeterTimerTimer];
    
    NSDate *tmpDate = [[NSDate alloc] initWithTimeIntervalSinceNow:VOICE_LEVEL_INTERVAL];
    NSTimer *tmpTimer = [[NSTimer alloc] initWithFireDate:tmpDate interval:VOICE_LEVEL_INTERVAL target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    self.voiceLevelMeterTimer = tmpTimer;
    
    [[NSRunLoop currentRunLoop] addTimer:_voiceLevelMeterTimer forMode:NSDefaultRunLoopMode];
}

- (void)freeVoiceLevelMeterTimerTimer
{
    if(_voiceLevelMeterTimer)
    {
        if([_voiceLevelMeterTimer isValid])
            [_voiceLevelMeterTimer invalidate];
        self.voiceLevelMeterTimer = nil;
    }
}

- (void)timerFired:(id)sender
{
    // 获取语音音量级别
    int voiceLevel = [[BDVoiceRecognitionClient sharedInstance] getCurrentDBLevelMeter];
    
    NSString *statusMsg = [NSLocalizedString(@"StringLogVoiceLevel", nil) stringByAppendingFormat:@": %d", voiceLevel];
 //   [clientSampleViewController logOutToLogView:statusMsg];
}


#pragma mark - MVoiceRecognitoinClientDelegate

- (void)VoiceRecognitionClientWorkStatus:(int) aStatus obj:(id)aObj{
    
    NSLog(@"status--%d   obj---%@",aStatus,aObj);
    
    switch (aStatus)
    {
        case EVoiceRecognitionClientWorkStatusSentenceEnd:{
            
            break;
        }
            
        case EVoiceRecognitionClientWorkStatusFlushData: // 连续上屏中间结果
        {
            NSString *text = [aObj objectAtIndex:0];
            if ([text length] > 0)
            {
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: // 识别正常完成并获得结果
        {
            printf("识别正常完成并获得结果");
            
            if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
            {
                //  搜索模式下的结果为数组，示例为
                // ["公园", "公元"]
                NSMutableArray *audioResultData = (NSMutableArray *)aObj;
                NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
                
                for (int i=0; i < [audioResultData count]; i++)
                {
                    [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
                }
                
                NSLog(@"result --%@",tmpString);
            }
            else
            {
                NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
                NSLog(@"result ----%@",tmpString);
                printf("%s",[tmpString UTF8String]);
                
//                if(self.recongnitionString){
//                    self.recongnitionString(tmpString);
//                }
//                
//                NSMutableArray *arr = [self realizeMuiltVoice:tmpString andRules:@[@"然后",@"接着",@"最后",@"再"]];
//                __block NSString *str = @"";
//                
//                [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    [self setLableData:obj];
//                    str = [[NSString alloc]initWithFormat:@"%@ ---指令:%@",str,obj];
//                }];
//                
//                if(self.metchBlock){
//                    self.metchBlock([arr copy]);
//                }
//                
//                NSLog(@"%@",str);
//                printf("%s",[str UTF8String]);
            }
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusReceiveData:
        {
            // 此状态只有在输入模式下使用
            // 输入模式下的结果为带置信度的结果，示例如下：
            //  [
            //      [
            //         {
            //             "百度" = "0.6055192947387695";
            //         },
            //         {
            //             "摆渡" = "0.3625582158565521";
            //         },
            //      ]
            //      [
            //         {
            //             "一下" = "0.7665404081344604";
            //         }
            //      ],
            //   ]
            NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
            NSLog(@"EVoiceRecognitionClientWorkStatusReceiveData--%@",tmpString);
            break;
        }
            
        case EVoiceRecognitionClientWorkStatusEnd:{
            NSLog(@"说话完成");
            printf("说话完成");
            
            //            UITextField *t = [self.view viewWithTag:100];
            //
            //            t.text = @"正在处理";
            break;
        }
            
//             case EVoiceRecognitionClientWorkStatusEnd: // 用户说话完成，等待服务器返回识别结果
//             {
//             
//             if ([BDVRSConfig sharedInstance].voiceLevelMeter)
//             {
//             [self freeVoiceLevelMeterTimerTimer];
//             }
//             [self createRecognitionView];
//             break;
//             }
            
//             case EVoiceRecognitionClientWorkStatusCancel:
//             {
//             if ([BDVRSConfig sharedInstance].voiceLevelMeter)
//             {
//             [self freeVoiceLevelMeterTimerTimer];
//             }
//             [self createRunLogWithStatus:aStatus];
//             
//             if (self.view.superview)
//             {
//             [self.view removeFromSuperview];
//             }
//             break;
//             }
             case EVoiceRecognitionClientWorkStatusStartWorkIng: // 识别库开始识别工作，用户可以说话
             {
             if ([BDVRSConfig sharedInstance].voiceLevelMeter)  // 开启语音音量监听
             {
                 [self startVoiceLevelMeterTimer];
             }
             break;
             }
             case EVoiceRecognitionClientWorkStatusNone:
             case EVoiceRecognitionClientWorkPlayStartTone:
             case EVoiceRecognitionClientWorkPlayStartToneFinish:
             case EVoiceRecognitionClientWorkStatusStart:
             case EVoiceRecognitionClientWorkPlayEndToneFinish:
//             case EVoiceRecognitionClientWorkPlayEndTone:
//             {
//             [self createRunLogWithStatus:aStatus];
//             break;
//             }
             case EVoiceRecognitionClientWorkStatusNewRecordData:
             {
             break;
             }
        default:
            
            break;
    }
    
}              //aStatus TVoiceRecognitionClientWorkStatus


- (void)VoiceRecognitionClientErrorStatus:(int) aStatus subStatus:(int)aSubStatus{
    
    NSLog(@"errorstatus--%d  asubstatus--%d",aStatus,aSubStatus);
    printf("VoiceRecognitionClientErrorStatus\n");
    
}//aStatus TVoiceRecognitionClientErrorStatusClass;aSubStatus TVoiceRecognitionClientErrorStatus

- (void)VoiceRecognitionClientNetWorkStatus:(int) aStatus{
    NSLog(@"network --%d",aStatus);
    printf("VoiceRecognitionClientNetWorkStatus\n");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
