//
//  EditFaceViewModel.m
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "EditFaceViewModel.h"

@implementation EditFaceViewModel

-(NSArray<NSData *> *)faceHexData{
    if (!_faceHexData) {
        _faceHexData = @[[[NSData alloc]init], [[NSData alloc]init] ];
    }
    return _faceHexData;
}

-(void)closeClick:(void (^)(void))callback{
    self.close = callback;
}
-(void)clearClick:(void (^)(void))callback{
    self.clear = callback;
}
-(void)sendClick:(void (^)(void))callback{
    self.send = callback;
}

@end
