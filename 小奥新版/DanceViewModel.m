//
//  DanceViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/17.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DanceViewModel.h"

@implementation DanceViewModel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if (self = [super init]) {
//        self.songsNameList = [NSArray array];
//        self.songsPathList = [NSArray array];
    }
    return self;
}

-(NSArray *)songsNameList{
    NSArray *temp = _songsNameList;
    if (!temp) {
        NSString *path = [NSString stringWithFormat:@"%@/%@",[NSBundle mainBundle].bundlePath,@"song_name_list.plist"];
        NSLog(@"path:%@",path);
        temp = [NSArray arrayWithContentsOfFile:path];
    }
    return temp;
}

-(NSArray *)songsPathList{
    NSArray *temp = _songsPathList;
    if (!temp) {
        NSArray *nameList = self.songsNameList;
        NSMutableArray *temp_m = [NSMutableArray array];
        for (int i = 0 ;i < nameList.count ; i++) {
            [temp_m addObject:nameList[i]];
        }
        temp = [temp_m copy];
    }
    return temp;
}


@end
