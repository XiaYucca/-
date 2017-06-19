/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/

#import "OpenGLView.h"
#import "AppDelegate.h"

#include <iostream>
#include "ar.hpp"
#include "renderer.hpp"
#include <stdlib.h>
/*
* Steps to create the key for this sample:
*  1. login www.easyar.com
*  2. create app with
*      Name: HelloARVideo
*      Bundle ID: cn.easyar.samples.helloarvideo
*  3. find the created item in the list and show key
*  4. set key string bellow
*/
NSString* key = @"7H3gIDVvJhtCbjISkWhJN3GBYWonpbdPTvunOLLZSDW3ksK836S9YEcgg8YB4MOjVWsFPkXukfCVXNKfD0iKN8ojOTMFNPVIMCTI0e2bde93a54db9b51276f041378edd2a8yEFEYwyw7fNnPZZOLAI66E0TcwosEHPWfboiIl3EKE6snM4idMn1sTSOtBqsQXvn8ru";

namespace EasyAR {
namespace samples {

class HelloARVideo : public AR
{
public:
    HelloARVideo();
    ~HelloARVideo();
    virtual void initGL();
    virtual void resizeGL(int width, int height);
    virtual void render();
    virtual bool clear();
 //   virtual void recognize_handle(int index,const std::string& info);
    virtual void regeistRecognize_handle(didRecognizeImage_Handle handle);
 // _recognizeImagehandle
    
private:
    Vec2I view_size;
    VideoRenderer* renderer[4];
    int tracked_target;
    int active_target;
    int texid[4];
    ARVideo* video;
    VideoRenderer* video_renderer;
    
    didRecognizeImage_Handle re_handle;
    
   };

HelloARVideo::HelloARVideo()
{
    view_size[0] = -1;
    tracked_target = 0;
    active_target = 0;
    for(int i = 0; i < 4; ++i) {
        texid[i] = 0;
        renderer[i] = new VideoRenderer;
    }
    video = NULL;
    video_renderer = NULL;
}

HelloARVideo::~HelloARVideo()
{
    for(int i = 0; i < 4; ++i) {
        delete renderer[i];
    }
}

//void HelloARVideo:: recognize_handle(int i ,const std::string &info){
//    
//}
    
void HelloARVideo:: regeistRecognize_handle(didRecognizeImage_Handle handle){
    
    re_handle = handle;
}
    
void HelloARVideo::initGL()
{
    augmenter_ = Augmenter();
    for(int i = 0; i < 4; ++i) {
        renderer[i]->init();
        texid[i] = renderer[i]->texId();
    }
}

void HelloARVideo::resizeGL(int width, int height)
{
    view_size = Vec2I(width, height);
}

void HelloARVideo::render()
{
    glClearColor(0.f, 0.f, 0.f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    Frame frame = augmenter_.newFrame();
    if(view_size[0] > 0){
        int width = view_size[0];
        int height = view_size[1];
        Vec2I size = Vec2I(1, 1);
        if (camera_ && camera_.isOpened())
            size = camera_.size();
        if(portrait_)
            std::swap(size[0], size[1]);
        float scaleRatio = std::max((float)width / (float)size[0], (float)height / (float)size[1]);
        Vec2I viewport_size = Vec2I((int)(size[0] * scaleRatio), (int)(size[1] * scaleRatio));
        if(portrait_)
            viewport_ = Vec4I(0, height - viewport_size[1], viewport_size[0], viewport_size[1]);
        else
            viewport_ = Vec4I(0, width - height, viewport_size[0], viewport_size[1]);
        if(camera_ && camera_.isOpened())
            view_size[0] = -1;
    }
    
    augmenter_.setViewPort(viewport_);
    augmenter_.drawVideoBackground();
    glViewport(viewport_[0], viewport_[1], viewport_[2], viewport_[3]);

    AugmentedTarget::Status status = frame.targets()[0].status();
    if(status == AugmentedTarget::kTargetStatusTracked){
        int id = frame.targets()[0].target().id();
        if(active_target && active_target != id) {
            video->onLost();
            delete video;
            video = NULL;
            tracked_target = 0;
            active_target = 0;
        }
        if (!tracked_target) {
            if (video == NULL) {
                if(frame.targets()[0].target().name() == std::string("argame") && texid[0]) {
//                    video = new ARVideo;
//                    video->openVideoFile("video.mp4", texid[0]);
//                    video_renderer = renderer[0];
                    if(re_handle){
                        (*re_handle)(0,"argame");
                    }
                }
                else if(frame.targets()[0].target().name() == std::string("namecard") && texid[1]) {
//                    video = new ARVideo;
//                    video->openTransparentVideoFile("transparentvideo.mp4", texid[1]);
//                    video_renderer = renderer[1];
                    if(re_handle){
                        (*re_handle)(1,"namecard");
                    }
                }
                else if(frame.targets()[0].target().name() == std::string("idback") && texid[2]) {
//                    video = new ARVideo;
//                    video->openStreamingVideo("http://7xl1ve.com5.z0.glb.clouddn.com/sdkvideo/EasyARSDKShow201520.mp4", texid[2]);
//                    video->openTransparentVideoFile("transparentvideo.mp4", texid[2]);
//                    video_renderer = renderer[2];
                    if(re_handle){
                        (*re_handle)(2,"idback");
                    }
                }
                else if (frame.targets()[0].target().name() == std::string("namecard_re") && texid[3]){
//                    video = new ARVideo;
//                    video->openTransparentVideoFile("transparentvideo.mp4", texid[3]);
//                    video_renderer = renderer[3];
                    if(re_handle){
                        (*re_handle)(3,"namecard_re");
                    }
                }
                else if (frame.targets()[0].target().name() == std::string("xxxx") && texid[4])
                {
//                    video = new ARVideo;
//                    video->openTransparentVideoFile("transparentvideo.mp4", texid[3]);
//                    video_renderer = renderer[3];
                    if (recognizeImagehandle) {
                        recognizeImagehandle(4,"xxxx");
                    }
                }
            }
            if (video) {
                video->onFound();
                tracked_target = id;
                active_target = id;
            }
        }
        Matrix44F projectionMatrix = getProjectionGL(camera_.cameraCalibration(), 0.2f, 500.f);
        Matrix44F cameraview = getPoseGL(frame.targets()[0].pose());
        ImageTarget target = frame.targets()[0].target().cast_dynamic<ImageTarget>();
        
        if(tracked_target) {
            video->update();
            video_renderer->render(projectionMatrix, cameraview, target.size());
        }
    }else{
        if (tracked_target) {
            video->onLost();
            tracked_target = 0;
        }
    }
}

bool HelloARVideo::clear()
{
    AR::clear();
    if(video){
        delete video;
        video = NULL;
        tracked_target = 0;
        active_target = 0;
    }
    return true;
}


    
    

}
}

EasyAR::samples::HelloARVideo ar;
@interface OpenGLView ()
{

}

@property(nonatomic, strong) CADisplayLink * displayLink;

- (void)displayLinkCallback:(CADisplayLink*)displayLink;

@end


@implementation OpenGLView

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size.width = frame.size.height = MAX(frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if(self){
        [self setupGL];
        EasyAR::initialize([key UTF8String]);
        ar.initGL();
    }
    return self;
}

- (void)dealloc
{
    ar.clear();
}

- (void)setupGL
{
    /*
     buffer分为frame buffer和render buffer两大类，其中frame buffer相当于render buffer的管理者，
     frame buffer object即称为FBO，常用于做离屏渲染缓冲等。render buffer则又可分为三类，
     color buffer / depth buffer / stencil buffer。
     */
    
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;

    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context)
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
    if (![EAGLContext setCurrentContext:_context])
        NSLog(@"Failed to set current OpenGL context");

    GLuint frameBuffer;
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);

    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);

    int width, height;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &width);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &height);

    GLuint depthRenderBuffer;
    glGenRenderbuffers(1, &depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderBuffer);
    
}

- (void)start{
    //开始加载 ar 组件
    ar.initCamera();
    ar.loadAllFromJsonFile("targets.json");
//    ar.loadFromImage("namecard_old.png");
//    ar.loadFromImage("namecard_re.jpg");
    ar.start();
    
    [self regist];

    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

static OpenGLView *THIS;

-(void)regist{
    ar.regeistRecognize_handle(regist);
    THIS = self;
}

void regist(int index, char *str){
    NSString *nsStr = [NSString stringWithUTF8String:str];
    if (THIS.didRecognizeImage) {
        THIS.didRecognizeImage(index, nsStr);
    }
}

-(ImageData)imageDataFromFile:(NSString *)filepath{
    
    CGImageRef imageRef =[UIImage imageNamed:filepath].CGImage;
    if (!imageRef) {
        NSLog(@"load image:%@ failed",filepath);
    }
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    uint8_t *image_data_ = (uint8_t *)calloc(width * height *4,sizeof(uint8_t));
    CGContextRef context = CGBitmapContextCreate(image_data_, width, height, 8, width *4, CGImageGetColorSpace(imageRef), kCGImageAlphaLast);
    CGImageRelease(imageRef);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    CGImageRelease(imageRef);
    
    ImageData d;
    d.data = image_data_;
    
    d.size = (GLuint)(width *height *4);
    return d;
}

- (void)stop
{
    ar.clear();
}

- (void)displayLinkCallback:(CADisplayLink*)displayLink
{
    if (!((AppDelegate*)[[UIApplication sharedApplication]delegate]).active)
        return;
    ar.render();

    (void)displayLink;
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)resize:(CGRect)frame orientation:(UIInterfaceOrientation)orientation
{
    BOOL isPortrait = FALSE;
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            isPortrait = TRUE;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            isPortrait = FALSE;
            break;
        default:
            break;
    }
    ar.setPortrait(isPortrait);
    ar.resizeGL(frame.size.width, frame.size.height);
    
    
}

- (void)setOrientation:(UIInterfaceOrientation)orientation
{
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
            EasyAR::setRotationIOS(270);
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            EasyAR::setRotationIOS(90);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            EasyAR::setRotationIOS(180);
            break;
        case UIInterfaceOrientationLandscapeRight:
            EasyAR::setRotationIOS(0);
            break;
        default:
            break;
    }
}

@end
