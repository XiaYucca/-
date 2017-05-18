//
//  VoicesViewController.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/1/10.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "VoicesViewController.h"

#import "BDRecognizerViewController.h"
#import "BDVRSConfig.h"

#import "BDVoiceRecognitionClient.h"
#import "BDVRRawDataRecognizer.h"
#import "NSMutableArray+Queue.h"
//#import "XYAudio.h"
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

#define label_1 2000
#define label_2 2001
#define label_3 2002

@interface VoicesViewController ()<MVoiceRecognitionClientDelegate>

@property(nonatomic , strong)NSTimer *timer;
@property(nonatomic , strong)UIImageView *btnIm;
@property(nonatomic , strong)UIImageView *voiceIm;

@property(nonatomic , copy) void(^callback)(DERICTION der) ;
@property(nonatomic , copy) void(^recongnitionString)(NSString *result);
@property(nonatomic , copy) void(^metchBlock)(NSArray *arr);


@end

@implementation VoicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView
{
    UIButton *ytn = [self.view viewWithTag:100];
    [ytn addTarget:self action:@selector(voiceStart) forControlEvents:UIControlEventTouchDown];
    [ytn addTarget:self action:@selector(voiceEnd) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnIm = [self.view viewWithTag:200];
    
    UIImageView *im = [self.view viewWithTag:300];
    im.image = [UIImage imageNamed:@"语音-点击"];
    
    //    [self.btnIm.layer setAnchorPoint:CGPointMake(0.5, 1)];
    //    self.btnIm.center = ytn.center;
    NSLog(@"开始加载%@ ",self.btnIm);
}

-(void)voiceEnd
{
    [_timer invalidate];
    _timer = nil;
    
    UIImageView *im = [self.view viewWithTag:300];
    im.image = [UIImage imageNamed:@"语音-点击"];
    //      self.btnIm.image = [UIImage imageNamed:@"语音-点击"];
    //      [self.btnIm.layer setAnchorPoint:CGPointMake(0, 0)];
}

-(void)voiceStart
{
    if (_timer) {
        [_timer invalidate];
    }
    self.btnIm.image = [UIImage imageNamed:@"语音-动画"];
    [self.btnIm.layer setAnchorPoint:CGPointMake(0.5, 1)];
    
    UIImageView *im = [self.view viewWithTag:300];
    
    self.btnIm.center = im.center;
    im.image = [UIImage imageNamed:@"语音-未点击"];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(voiceAnimate) userInfo:nil repeats:YES];

    [self startRecognitionWithoutUI];
}

-(void)voiceAnimate
{
    self.btnIm.transform = CGAffineTransformRotate(_btnIm.transform, M_PI_2 / 8.0);
}

-(void)setLableData:(NSString *)str{
    //static int t = 0;
    
    UILabel *l_1 = [self.view viewWithTag:label_1];
    UILabel *l_2 = [self.view viewWithTag:label_2];
    UILabel *l_3 = [self.view viewWithTag:label_3];
    
   // if (t<2) {
        l_3.text = l_2.text;
        l_2.text = l_1.text;
        l_1.text = str;
 
   // }
}


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
    
}

-(NSMutableArray *)realizeMuiltVoice:(NSString*)str andRules:(NSArray *)rulesArr{
    
    NSMutableArray *resultStr = [self splitStr:str andRules:rulesArr];
    NSString *temp =@"";
    NSMutableArray *resultCMD = [@[]mutableCopy];
    
    while ((temp = [resultStr pop])) {
        NSLog(@"---%@",temp);
        NSString *strTemp = [self realizeVoice:temp];
        [resultCMD unshift:strTemp];
        
    }
    return resultCMD;
}

-(NSString *)realizeVoice:(NSString *)str{
    NSArray *statusNoArr = @[@"不",@"否",@"步",@"别",@"no"];
    NSArray *statusYesArr = @[@"走",@"揍",@"run",@"go"];
    
    NSArray *statusUpArr = @[@"前",@"直",@"进",@"近",@"钱",@"up",@"上"];
    NSArray *statusStopArr = @[@"停",@"止",@"不要动",@"老实",@"听",@"挺",@"stop",@"婷",@"站住"];
    NSArray *statusBackArr = @[@"后",@"退",@"到",@"倒",@"回",@"腿",@"back",@"下"];
    NSArray *statusLeftArr = @[@"左",@"左转",@"left"];
    NSArray *statusRightArr = @[@"右",@"右转",@"right"];
    
    BOOL statusNo = [self matchVoice:statusNoArr string:str];
    
    NSString *result = @"";
    
    DERICTION deri = WHEEL_ORIGOIN;
    
    
    NSLog(@"____________________计算指令______________________");
    if ( statusNo) {
        result = @"我不动";
        deri = WHEEL_ORIGOIN;
    }
    else if ([self matchVoice:statusUpArr string:str]){
        result = (@"我要向前走");
        deri = WHEEL_UP;
        
    }
    else if ([self matchVoice:statusStopArr string:str]){
        result = (@"我要停下");
        deri = WHEEL_ORIGOIN;
    }
    else if ([self matchVoice:statusBackArr string:str]){
        result = (@"我要后退");
        deri = WHEEL_DOWN;
    }
    else if ([self matchVoice:statusLeftArr string:str]){
        result = (@"我要左转");
        deri = WHEEL_LEFT;
    }
    else if ([self matchVoice:statusRightArr string:str]){
        result = (@"我要右转");
        deri = WHEEL_RIGHT;
    }
    else if ([self matchVoice:statusYesArr string:str]){
        result = (@"我要走");
        deri = WHEEL_UP;
        
    }else{
        result = @"没有相关指令";
        deri = WHEEL_ORIGOIN;
    }
    if(self.callback){
        self.callback(deri);
    }
    return result;
}

-(BOOL)matchVoice:(NSArray *)arr string:(NSString *)str{
    
    __block BOOL isTrue = NO ;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str containsString:(NSString *)obj]) {
            isTrue = YES;
            *stop = YES;
            
        }
    }];
    return isTrue;
}

-(NSMutableArray*)splitStr:(NSString *)str andRules:(NSArray *)rulesArr{
    
    NSArray *arrSplite = rulesArr;
    NSString *strOrg = str;
    
    NSMutableArray *arrmTmp = [@[]mutableCopy];
    [arrmTmp unshift:strOrg];
    
    for (int i = 0; i <arrSplite.count; i++) {
        
        // NSLog(@"arrmTmp === %@",arrmTmp);
        
        if ([strOrg containsString:arrSplite[i]]) {
            
            NSMutableArray *tempM = [@[]mutableCopy];
            
            NSString *strT = @"";
            
            while ((strT=[arrmTmp pop])) {
                
                //  NSLog(@"strT ---%@",strT);
                NSArray *temp = [strT componentsSeparatedByString:arrSplite[i]];
                
                // NSLog(@"temp ---%@",temp);
                [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [tempM unshift:obj];
                }];
                //                if (temp.count >1) {
                //                    tempM
                //                    [tempM unshift:temp.firstObject];
                //                    [tempM unshift:temp.lastObject];
                //                }else{
                //                    [tempM unshift:temp.firstObject];
                //                }
                // NSLog(@"tempM ---%@",tempM);
            }
            arrmTmp = [tempM mutableCopy];
         }
    }
    NSLog(@"++++++++++%@",arrmTmp);
    
    /*
     //    if(range1.length){
     //      NSArray *arr = [str componentsSeparatedByString:str1];
     //        NSLog(@"range_1-%@",arr);
     //        if(arr.count > 1){
     //        [arrm unshift:[arr firstObject]];
     //        [arrm unshift:[arr lastObject]];
     //        }else{
     //            [arrm unshift:arr.firstObject];
     //        }
     //    }
     //    if (range2.length) {
     //        NSString *_str = [arrm pop];
     //        NSString *str_ = [arrm pop];
     //
     //        NSArray *_arr = [_str componentsSeparatedByString:str2];
     //         NSLog(@"range_2_arr%@",_arr);
     //        if (_arr.count > 1) {
     //            [arrm unshift:_arr.firstObject];
     //            [arrm unshift:_arr.lastObject];
     //        }else{
     //            [arrm unshift:_arr.firstObject];
     //        }
     //
     //        NSArray *arr_ = [str_  componentsSeparatedByString:str2];
     //         NSLog(@"range2_arr_%@",arr_);
     //        if (arr_.count > 1) {
     //            [arrm unshift:arr_.firstObject];
     //            [arrm unshift:arr_.lastObject];
     //        }else{
     //            [arrm unshift:arr_.firstObject];
     //        }
     //
     //        
     //    }
     //    NSLog(@"arrm--%@",arrm);
     //    */
    return  arrmTmp;
}

-(void)speakEnd{
    BDVoiceRecognitionClient *instance = [BDVoiceRecognitionClient sharedInstance];
    [instance speakFinish];
}

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
//                UITextField *t = [self.view viewWithTag:100];
//                t.text = text;
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
                
                if(self.recongnitionString){
                    self.recongnitionString(tmpString);
                }
                
                
                NSMutableArray *arr = [self realizeMuiltVoice:tmpString andRules:@[@"然后",@"接着",@"最后",@"再"]];
                __block NSString *str = @"";
                
                [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self setLableData:obj];
                    str = [[NSString alloc]initWithFormat:@"%@ ---指令:%@",str,obj];
                }];
                
                if(self.metchBlock){
                    self.metchBlock([arr copy]);
                }
            
                NSLog(@"%@",str);
                printf("%s",[str UTF8String]);
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
         /*
             case EVoiceRecognitionClientWorkStatusEnd: // 用户说话完成，等待服务器返回识别结果
             {
             
             if ([BDVRSConfig sharedInstance].voiceLevelMeter)
             {
             [self freeVoiceLevelMeterTimerTimer];
             }
             
             [self createRecognitionView];
             
             break;
             }
             case EVoiceRecognitionClientWorkStatusCancel:
             {
             if ([BDVRSConfig sharedInstance].voiceLevelMeter)
             {
             [self freeVoiceLevelMeterTimerTimer];
             }
             
             [self createRunLogWithStatus:aStatus];
             
             if (self.view.superview)
             {
             [self.view removeFromSuperview];
             }
             break;
             }
             case EVoiceRecognitionClientWorkStatusStartWorkIng: // 识别库开始识别工作，用户可以说话
             {
             if ([BDVRSConfig sharedInstance].playStartMusicSwitch) // 如果播放了提示音，此时再给用户提示可以说话
             {
             [self createRecordView];
             }
             
             if ([BDVRSConfig sharedInstance].voiceLevelMeter)  // 开启语音音量监听
             {
             [self startVoiceLevelMeterTimer];
             }
             
             [self createRunLogWithStatus:aStatus];
             
             break;
             }
             case EVoiceRecognitionClientWorkStatusNone:
             case EVoiceRecognitionClientWorkPlayStartTone:
             case EVoiceRecognitionClientWorkPlayStartToneFinish:
             case EVoiceRecognitionClientWorkStatusStart:
             case EVoiceRecognitionClientWorkPlayEndToneFinish:
             case EVoiceRecognitionClientWorkPlayEndTone:
             {
             [self createRunLogWithStatus:aStatus];
             break;
             }
             case EVoiceRecognitionClientWorkStatusNewRecordData:
             {
             break;
             } */
        default:
            
            break;
     }
    
}              //aStatus TVoiceRecognitionClientWorkStatus

-(void)endRecongnitionWithInstraction:(void(^)(DERICTION deric))callback{
    self.callback = callback;
}

-(void)endRecongnitionWithString:(void (^)(NSString *))recongnitionString{
    self.recongnitionString = recongnitionString;
}

-(void)endMetchWithString:(void(^)(NSArray *result))metchBlock{
    self.metchBlock = metchBlock;
}


- (void)VoiceRecognitionClientErrorStatus:(int) aStatus subStatus:(int)aSubStatus{
    
    NSLog(@"errorstatus--%d  asubstatus--%d",aStatus,aSubStatus);
    printf("VoiceRecognitionClientErrorStatus\n");
    
}//aStatus TVoiceRecognitionClientErrorStatusClass;aSubStatus TVoiceRecognitionClientErrorStatus

- (void)VoiceRecognitionClientNetWorkStatus:(int) aStatus{
    NSLog(@"network --%d",aStatus);
    printf("VoiceRecognitionClientNetWorkStatus\n");
}






@end
