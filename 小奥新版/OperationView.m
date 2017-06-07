//
//  OperationView.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//



#import "OperationView.h"
#import "NSMutableArray+Queue.h"

typedef enum {
      touchDown,
      touchUp,
      dragIn
} TASK_STATUS;

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
    
    [RecodeManage shared].timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        gloab_time ++;
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

        [RecodeManage shared].timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
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
    UIView *item;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


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
    item = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    item.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:item];
    item.layer.cornerRadius = 25;
    item.layer.masksToBounds = YES;
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
    
    [self test];
}

-(void)awakeFromNib
{
    XLog(@"awake");

}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView * temp = [super hitTest:point withEvent:event];

//    XLog(@"point %@,event:%@",NSStringFromCGPoint(point),event);
//
//    TaskRecode *task = [TaskRecode taskRecode];
//    task.taskBlock = ^() {
//        item.center = point;
//        item.alpha = 0.7;
//        [UIView animateWithDuration:0.3 animations:^{
//            item.alpha = 1.0;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3 animations:^{
//                item.alpha = 0.5;
//            } completion:^(BOOL finished) {
//                 item.alpha = 0;
//            }];
//        }];
//        
//    };
//    [RecodeManage addTaskToManage:task];
//    
    return temp;
}


-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    static int pointInsideHandleIndex = 1;
    

    BOOL temp =  [super pointInside:point withEvent:event];
    if((pointInsideHandleIndex ++) % 2)
    {
        XLog(@"return point %@,event:%@",NSStringFromCGPoint(point),event);
        TaskRecode *task = [TaskRecode taskRecode];
        
        task.taskBlock = ^() {
            item.center = point;
            item.alpha = 0.7;
            [UIView animateWithDuration:0.3 animations:^{
                item.alpha = 1.0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    item.alpha = 0.5;
                } completion:^(BOOL finished) {
                    item.alpha = 0;
                }];
            }];
            
        };
        
        [RecodeManage addTaskToManage:task];

    }
    
    return temp;
}


-(IBAction)btnTaskStartClick:(id)sender{
    [RecodeManage startRecode];
    
}

-(IBAction)btnTaskStopClick:(id)sender{
    [RecodeManage stopRecode];
}

-(IBAction)btnTaskPlay:(id)sender{
    [RecodeManage playRecode];
}


-(IBAction)actionClick:(id)sender{
    static int i;
  //  [RecodeManage createTeskRecode:0 withInfo:[NSString stringWithFormat:@"info -index:%d",i++]];
    UIButton *btu = sender;
    TaskRecode *task = [TaskRecode taskRecode];
    task.taskBlock = ^() {
        btu.selected = !btu.selected;
       // btu.state =
//        [UIView animateWithDuration:0.2 animations:^{
//            btu.transform = CGAffineTransformMakeScale(1.2, 1.2);
//        } completion:^(BOOL finished) {
//            btu.transform = CGAffineTransformIdentity;
//        }];
    };
    [RecodeManage addTaskToManage:task];
}
/*
// Only override drawRect: if you perf-orm custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
