//
//  EditFaceViewModel.h
//  小奥新版
//
//  Created by RainPoll on 2017/5/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EditFaceView;
@interface EditFaceViewModel : NSObject
@property(nonatomic,weak)EditFaceView *view;

@property(nonatomic,copy)void(^clear)(void);
@property(nonatomic ,copy)void(^send)(void);
@property(nonatomic ,copy)void(^close)(void);

@property(nonatomic ,copy)NSArray<NSData *> *faceHexData;

-(void)clearClick:(void(^)(void))callback;
-(void)sendClick:(void(^)(void))callback;
-(void)closeClick:(void(^)(void))callback;
@end
