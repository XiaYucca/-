//
//  FaceView.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 16/7/1.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import "FaceView.h"
#import "LittleItem.h"

#define ItemRect 0.4
#define defalutColor  [UIColor colorWithRed:0x00/255.0 green: 0x80/255.0 blue:0xdd/255.0 alpha:1]
#define selectColor  [UIColor colorWithRed:0xff/255.0 green: 0x8b/255.0 blue:0x98/255.0 alpha:1]

unsigned char font[8]= {0};
/************************
 
 
 ***********************/
@implementation FaceView
{
    CGFloat lineWidth;
    CGFloat blockWidth;
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
////        self
//    }
//}

- (void)drawRect:(CGRect)rect {

    [self setUp];
    
}
-(void)setUp
{
    for (int i = 0; i < 8; i++ ) {
       
        for (int j = 0; j < 8; j++ ) {
            
            CGFloat blockW = self.frame.size.width/(9 * ItemRect + 8);
            CGFloat lineW = blockW * ItemRect;
            CGFloat blockX = lineW + (blockW + lineW) * j;
            CGFloat blockY = lineW + (blockW + lineW) * i;
            
            lineWidth = lineW;
            blockWidth = blockW;
            
            CGRect r = CGRectMake(blockX, blockY, blockW, blockW);
            LittleItem *itemV = [[LittleItem alloc]initWithFrame:r];
            itemV.tag = (i+1) * 8 + j;
            itemV.backgroundColor = defalutColor;
            
            itemV.layer.cornerRadius = blockW * 0.5;
            itemV.layer.masksToBounds = YES;
            
            [self addSubview:itemV];
        }
    }
}
-(void)clear{
    for(int i= 0 ; i < 8; i++)
    {
        for(int j = 0 ; j < 8 ; j++)
        {
            int tag = (i + 1)  * 8 + (j);
            LittleItem *item = [self viewWithTag:tag];
            item.setOn = NO;

        }
    }
    self.fontHexValue = [self hexFont];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    CGPoint r = [self progressPositionWithPos:p];
    
    int tag = (r.y + 1)  * 8 + (r.x);
    
    LittleItem *item = [self viewWithTag:tag];
    item.setOn = !item.isOn;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.fontHexValue = [self hexFont];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int oldTag;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint p = [touch locationInView:self];
    
    CGPoint r = [self progressPositionWithPos:p];

    int tag = (r.y + 1)  * 8 + (r.x);
    
    if(oldTag == tag){
        return;
    }
    
    LittleItem *item = [self viewWithTag:tag];
    
    item.setOn = !item.setOn;
    
    oldTag = tag;

    
    
    NSLog(@"touch Moved");
    
}
-(CGPoint)progressPositionWithPos:(CGPoint)p
{
    CGFloat realW = p.x ;
    CGFloat realH = p.y ;
    
    CGFloat indexX = ( realW / (lineWidth + blockWidth));
    CGFloat indexY = ( realH / (lineWidth + blockWidth));

    if (indexX >= 8.0 || indexY >= 8.0) {
        indexX = 100;
        indexY = 100;
    }else
    {
        CGFloat dx =1.0 + indexX - ceilf(indexX);
        
        if (dx > ItemRect / (1.0 + ItemRect) ) {
            indexX = ceilf(indexX);
        }
        else
        {
            indexX = 100;
        }
        
        CGFloat dy =1.0 + indexY - ceilf(indexY);
        
        if (dy > ItemRect / (1.0 + ItemRect) ) {
            indexY = ceilf(indexY);
        }
        else
        {
            indexY = 100;
        }
        
    }
    return CGPointMake((int)indexX - 1, (int)indexY - 1);
}


-(NSData *)hexFont
{
    for (int i = 0; i < 8; i++ ) {
        unsigned char temp = 0;
        for (int j = 0; j < 8; j++ ) {
           
            int tag = (i+1) * 8 + j;
            LittleItem *item = [self viewWithTag:tag];
         
            
            BOOL on = item.isOn;
            
            temp = temp*2 + on;
        }
        font[i] = temp;
        printf("++++++++++%02x",temp);
        
    }
    return [NSData dataWithBytes:font length:8];
}








@end
