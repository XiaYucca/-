//
//  OperationView.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//



#import "OperationView.h"
#import "NSMutableArray+Queue.h"
#import "SteeringWheel.h"
#import "HandleSlider.h"
#import "ConnectView.h"
#import "SaveOpration.h"


#import "Route.h"


typedef enum {
      touchDown,
      touchUp,
      dragIn
} TASK_STATUS;


#define TASK_FRENQUENCY 50

/*************** 任务 ****************/
#pragma mark - task item

@interface TaskRecode :NSObject

@property (nonatomic ,copy)NSString *info;
@property (nonatomic ,assign)CGFloat intervalTime;
@property (nonatomic ,assign)NSUInteger startTime;

@property (nonatomic ,assign)TASK_STATUS statuts;

@property (nonatomic ,copy)void(^taskBlock)();

@end

@implementation TaskRecode

+(instancetype)taskRecode{
    TaskRecode *temp = [[TaskRecode alloc]init];
    if (temp) {
        
    }
    return temp;
}

@end
/*************************************/


/**************** 任务管理 *********************/
#pragma mark - task manage
@interface RecodeManage : NSObject

//@property (nonatomic ,readonly ,assign)NSUInteger startTime;   //任务开始时间
@property (nonatomic ,readonly ,assign)NSUInteger taskIndex;   //任务索引
@property (nonatomic ,assign ,readonly) NSTimeInterval timeTick;         //任务时长
@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic ,copy) NSMutableArray<TaskRecode *>*taskQueue;   //任务队列

@property (nonatomic ,copy) void(^timeTickBlock)(NSUInteger index);

@end

static NSUInteger gloab_time = 0;

@implementation RecodeManage

-(NSMutableArray<TaskRecode *> *)taskQueue{
    if (!_taskQueue) {
        _taskQueue = [NSMutableArray array];
    }
    return _taskQueue;
}

+(instancetype)shared{
    static RecodeManage * manage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage= [[RecodeManage alloc]init];
    });
    return manage;
}

+(instancetype)recodeManage{
    RecodeManage *manage= [[RecodeManage alloc]init];
    if (manage) {
        
    }
    return manage;
}

+(void)addTaskToManage:(TaskRecode *)task{
    task.startTime = gloab_time;
    [[RecodeManage shared].taskQueue unshift:task];
}

-(void)addTaskToManage:(TaskRecode *)task{
    task.startTime = gloab_time;
    [self.taskQueue unshift:task];
}

+(void)createTeskRecode:(TASK_STATUS)status withInfo:(NSString *)info{
    
    XLog(@"info:%@--gloabTime:%ld",info,gloab_time);
    
    TaskRecode *task = [TaskRecode taskRecode];
    task.startTime = gloab_time;
    task.info = info;
    [[RecodeManage shared].taskQueue unshift:task];
//    task.intervalTime = ;
}

+(void)startRecode{
    gloab_time = 0;
    [[RecodeManage shared].taskQueue removeAllObjects];
    [[RecodeManage shared].timer invalidate];
    [RecodeManage shared].timer = nil;
    
    [RecodeManage shared].timer = [NSTimer scheduledTimerWithTimeInterval:(float)(1.0/TASK_FRENQUENCY) repeats:YES block:^(NSTimer * _Nonnull timer) {
        gloab_time ++;
        NSUInteger index = gloab_time;
        if ([RecodeManage shared].timeTickBlock) {
            [RecodeManage shared].timeTickBlock(index);
        }
        XLog(@"time tick time:%ld",gloab_time);
    }];
}

+(void)stopRecode{
    [[RecodeManage shared].timer invalidate];
    [RecodeManage shared].timer = nil;
    
    [[RecodeManage shared]setValue:[NSNumber numberWithInt:gloab_time] forKey:@"timeTick"];
}

+(void)playRecode{
    [self stopRecode];
    gloab_time = 0;
    if (![RecodeManage shared].timer) {
        
         __block TaskRecode* task = [[RecodeManage shared].taskQueue pop];

        [RecodeManage shared].timer = [NSTimer scheduledTimerWithTimeInterval:(float)(1.0/TASK_FRENQUENCY)  repeats:YES block:^(NSTimer * _Nonnull timer) {
            gloab_time ++;
            XLog(@"play time tick time:%ld",gloab_time);
            while ( abs(task.startTime - gloab_time)<1 ) {
                XLog(@"执行一个任务info:%@",task.info);
                task = [[RecodeManage shared].taskQueue pop];
                if (task.taskBlock) {
                    task.taskBlock();
                }
            }
//          if(!task){
//               [timer invalidate];
//               [RecodeManage shared].timer = nil;
//               gloab_time = 0;
//          }
            if(gloab_time > [RecodeManage shared].timeTick)
            {
                [timer invalidate];
                [RecodeManage shared].timer = nil;
                gloab_time = 0;
            }
        }];
    }
}

@end
/**********************************************/



/**********************************************/
@interface recodeView :UIView


@end


@implementation recodeView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

@end
/**********************************************/

@implementation OperationView
{
    BOOL isRecord;
    
    UIView *itemView;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    UITouch * touch = [touches anyObject];
//    CGPoint p = [touch locationInView:self.contentView];
//    
//    TaskRecode *task = [TaskRecode taskRecode];
//    task.taskBlock = ^(TaskRecode *task) {
//        item.center = p;
//    };
//    [RecodeManage addTaskToManage:task];

    [super touchesMoved:touches withEvent:event];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    UITouch * touch = [touches anyObject];
//    CGPoint p = [touch locationInView:self.contentView];
//    
//    TaskRecode *task = [TaskRecode taskRecode];
//    task.taskBlock = ^(TaskRecode *task) {
//        item.center = p;
//    };
//    [RecodeManage addTaskToManage:task];
    
    [super touchesBegan:touches withEvent:event];
}

-(void)test {
    itemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    itemView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:itemView];
    itemView.layer.cornerRadius = 25;
    itemView.layer.masksToBounds = YES;
    itemView.hidden = YES;
    
    UIButton *btn = [self viewWithTag:100];
    btn.highlighted = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIButton *btn = [self viewWithTag:200];
        btn.highlighted = YES;
        
    });
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadFromNib];
    }
    return self;
}

-(void)loadFromNib
{
    [[NSBundle mainBundle]loadNibNamed:@"OperationView" owner:self options:nil];
    [self addSubview:self.contentView];
    
    SteeringWheel *wheel = [[SteeringWheel alloc]initWithFrame:CGRectMake(0, 0, self.steeringWheel.frame.size.width, self.steeringWheel.frame.size.height)];
    [self.steeringWheel addSubview:wheel];
    self.wheel = wheel;
    wheel.bgImage = [UIImage imageNamed:@"摇杆-大圆"];
    wheel.btnDrgImage = [UIImage imageNamed:@"摇杆-小圆"];
    wheel.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageLeft = [self viewWithTag:1000];
    if (imageLeft) {
        HandleSlider *sliderLeft = [HandleSlider handleSlider];
        [self addSubview:sliderLeft];
        sliderLeft.center = CGPointMake(imageLeft.center.x, imageLeft.center.y + 60);
        [imageLeft removeFromSuperview];
        
        
        [sliderLeft sliderDidChangleValue:^(CGFloat progress) {
            static CGFloat oldValue = 0;
            if ( fabs(oldValue - progress) > 0.1 )  {
                if(isRecord){
                    TaskRecode *task = [TaskRecode taskRecode];
                    task.taskBlock = ^(TaskRecode *task) {
                        sliderLeft.progress = progress;
                    };
                    [RecodeManage addTaskToManage:task];
                }
            }
        }];
    }
    
    UIImageView *imageRight = [self viewWithTag:2000];
    if (imageRight) {
        HandleSlider *sliderRight = [HandleSlider handleSlider];
        [self addSubview:sliderRight];
        sliderRight.center = CGPointMake(imageRight.center.x, imageRight.center.y + 60);
        [imageRight removeFromSuperview];
        
        
        [sliderRight sliderDidChangleValue:^(CGFloat progress) {
            static CGFloat oldValue = 0;
            if ( fabs(oldValue - progress) > 0.1 )  {
                if(isRecord){
                    TaskRecode *task = [TaskRecode taskRecode];
                    task.taskBlock = ^(TaskRecode *task) {
                        sliderRight.progress = progress;
                        
                    };
                    [RecodeManage addTaskToManage:task];
                }
            }
        }];
    }
    
    [wheel didDidDrag:^(DERICTION der) {
        CGFloat t_angle = -1.0;
        if (isRecord) {
            if (der == 0) {
                t_angle = -1.0;
            }
            else{
                t_angle = M_PI_2 * (der - 1);
            }
            TaskRecode *task = [TaskRecode taskRecode];
            task.taskBlock = ^(TaskRecode *task) {
                wheel.angle = t_angle;
            };
            [RecodeManage addTaskToManage:task];

        }
    }];
    
    [self test];
}


-(void)awakeFromNib
{
    XLog(@"awake");
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * temp = [super hitTest:point withEvent:event];
    return temp;
}

//点一次触发两次所以用了一个笨办法 过滤一次
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    static int pointInsideHandleIndex = 1;
    BOOL temp =  [super pointInside:point withEvent:event];
    if((pointInsideHandleIndex ++) % 2)
    {
        XLog(@"return point %@,event:%@",NSStringFromCGPoint(point),event);
        TaskRecode *task = [TaskRecode taskRecode];
        task.taskBlock = ^() {
            itemView.center = point;
            itemView.alpha = 0.7;
            [UIView animateWithDuration:0.3 animations:^{
                itemView.alpha = 1.0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    itemView.alpha = 0.5;
                } completion:^(BOOL finished) {
                    itemView.alpha = 0;
                }];
            }];
        };
        [RecodeManage addTaskToManage:task];
    }
    return temp;
}

-(IBAction)btnTaskStartClick:(id)sender{

    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.isSelected;
    UIView *view = [self viewWithTag:10];
    
    if (!btn.selected) {
        view.hidden = YES;
        isRecord = NO;
        [RecodeManage stopRecode];
        [self showSheet];
        [self clearTimeTick];
    }else{
        isRecord = YES;
        view.hidden = NO;
        [RecodeManage startRecode];
        [RecodeManage shared].timeTickBlock = ^(NSUInteger index){
            if (!(index % 10)) {
                [self showTimeTick];
            }
        };
    }
    
}
-(void)showSheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"储存录制动作" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"确定");
        // 取出文本
        UITextField *text = alertController.textFields.firstObject;
        
        XLog(@"%@",text.text);
    }];
    // 创建按钮
    // 注意取消按钮只能添加一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
        NSLog(@"注意学习");
    }];
    
    //    // 创建警告按钮
    //    UIAlertAction *structlAction = [UIAlertAction actionWithTitle:@"警告" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
    //        NSLog(@"注意学习");
    //    }];
    // 添加按钮 将按钮添加到UIAlertController对象上
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    //[alertController addAction:structlAction];
    // 只有在alert情况下才可以添加文本框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"文件名";
       // textField.secureTextEntry = YES;
    }];
    if (self.callBack) {
        self.callBack(alertController);
    }
}

-(void)showTimeTick{
    UILabel *label = [self viewWithTag:20];
    NSUInteger temp = gloab_time / TASK_FRENQUENCY;
    int s = temp % 60;
    int m = temp % 3600/ 60;
    int h = temp / 3600;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d",h,m,s];
    label.text = timeStr;
}

-(void)clearTimeTick{
    UILabel *label = [self viewWithTag:20];
    NSString *timeStr = @"00:00:00";
    label.text = timeStr;
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(IBAction)btnTaskStopClick:(id)sender{
    isRecord = NO;
    [RecodeManage stopRecode];
}

-(IBAction)btnTaskPlay:(id)sender{
    itemView.hidden = NO;
    isRecord = NO;
    [RecodeManage playRecode];
}

-(IBAction)actionClick:(id)sender{
    static int i;
  //  [RecodeManage createTeskRecode:0 withInfo:[NSString stringWithFormat:@"info -index:%d",i++]];
    UIButton *btu = sender;
    TaskRecode *task = [TaskRecode taskRecode];
    task.taskBlock = ^() {
        btu.selected = !btu.selected;
//        btu.state =
//        [UIView animateWithDuration:0.2 animations:^{
//            btu.transform = CGAffineTransformMakeScale(1.2, 1.2);
//        } completion:^(BOOL finished) {
//            btu.transform = CGAffineTransformIdentity;
//        }];
    };
    [RecodeManage addTaskToManage:task];
    
}

-(IBAction)helpBtnClick:(id)sender{
    
    [SaveOpration showOnWindow:nil];
    
}

-(IBAction)setBtnClick:(id)sender{
    
//    if (self.setBtnClickCallBack) {
//        self.setBtnClickCallBack();
//    }
    
//    [ConnectView showOnWindow:^{
//        XLog(@"-----connect load");
//        [appDelegate.siralManage blueToothAutoScaning:1 withTimeOut:15 autoConnectDistance:-100 didConnected:^(CBPeripheral *peripheral) {
//            XLog(@"did connect");
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSString *cmd = @"advance";
//                [appDelegate.siralManage writeData:[cmd dataUsingEncoding:NSUTF8StringEncoding]];
//            });
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [ConnectView dissmissOnWindow:nil];
//            });
//        } timeOutCallback:^{
//            XLog(@"timeout");
//        }];
//        
//    }];
    if (self.setBtnClickCallBack) {
        self.setBtnClickCallBack();
    }
}

-(IBAction)btnClick:(UIButton *)sender{
    
    if (isRecord) {
        TaskRecode *task = [TaskRecode taskRecode];
        task.taskBlock = ^(TaskRecode *task) {
            sender.highlighted = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                sender.highlighted = NO;
            });
        };
        [RecodeManage addTaskToManage:task];
    }
    switch (sender.tag) {
        case 100:
                    {
                        NSString *cmd = @"advance";
                        [appDelegate.siralManage writeData:[cmd dataUsingEncoding:NSUTF8StringEncoding]];
                    }
            break;
        case 200:
            
            break;
        case 300:
            
            break;
        case 400:
            
            break;
            
        default:
            break;
    }
}

-(IBAction)backBtnClick{
    !self.dissMissCallBack ?: self.dissMissCallBack();
}

/*
// Only override drawRect: if you perf-orm custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
