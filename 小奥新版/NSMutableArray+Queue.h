//
//  NSMutableArray+Queue.h
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/1/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Queue)

-(NSInteger)unshift:(id)obj;
-(id)pop;
-(NSInteger)push:(id)obj;

@end
