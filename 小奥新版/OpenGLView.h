/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

typedef void (*didRecognizeImage_Handle)(int index ,char *info);

static didRecognizeImage_Handle recognizeImagehandle;

@interface OpenGLView : UIView

@property(nonatomic, strong) CAEAGLLayer * eaglLayer;
@property(nonatomic, strong) EAGLContext *context;
@property(nonatomic) GLuint colorRenderBuffer;

@property(nonatomic ,copy)void(^didRecognizeImage)(NSUInteger index, NSString *info);

- (void)start;
- (void)stop;
- (void)resize:(CGRect)frame orientation:(UIInterfaceOrientation)orientation;
- (void)setOrientation:(UIInterfaceOrientation)orientation;


@end
