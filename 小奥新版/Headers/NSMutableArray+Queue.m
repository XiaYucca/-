//
//  NSMutableArray+Queue.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/1/11.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

-(NSInteger)unshift:(id)obj {
    [self insertObject:obj atIndex:0];
    return self.count;
}

-(id)pop{
    id temp = [self lastObject];
    
    if(!temp){
        NSLog(@"queue is empty");
    }
    
    [self removeLastObject];
    return temp;
}

-(NSInteger)push:(id)obj{
    [self addObject:obj];
    return self.count;
}


@end
