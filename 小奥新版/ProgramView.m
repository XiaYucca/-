//
//  ProgramView.m
//  小奥新版
//
//  Created by RainPoll on 2017/7/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ProgramView.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"

#define H5_CMD_BACK     @"clickLogo"
#define H5_CMD_OPEN     @"openFile"
#define H5_CMD_RESET    @""
#define H5_CMD_COMPILE  @"compileFile"
#define H5_CMD_SAVE     @"saveFile"

@interface ProgramView ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic ,weak)IBOutlet WKWebView *webV;
@property (nonatomic ,weak)IBOutlet UIView *contentV;
@property (nonatomic ,strong)WKWebViewJavascriptBridge *webjsBridge;

@end

@implementation ProgramView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)initWKWebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
 //   preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    
    WKWebView * webV = [[WKWebView alloc] initWithFrame:self.contentV.frame configuration:configuration];

//    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
//    NSString *localHtml = [NSString stringWithContentsOfFile:urlStr encoding:NSUTF8StringEncoding error:nil];
//    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
//    [self.webV loadHTMLString:localHtml baseURL:fileURL];

    webV.navigationDelegate = self;
    webV.UIDelegate = self;
    [self.contentV addSubview:webV];
    self.webV = webV;
    
    _webjsBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webV];
    [_webjsBridge setWebViewDelegate:self];
    [WKWebViewJavascriptBridge enableLogging];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initWithNib];
    }
    return self;
}

-(void)initWithNib{
    [[NSBundle mainBundle]loadNibNamed:@"ProgramView" owner:self options:nil];
    [self setup];
    
}
-(void)setup{
    [self addSubview:self.contentV];

    [self initWKWebView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self loadExamplePage:self.webV];
    [self jsRegiste];
        
//        [self loadFileUrl];
//    });
//    [self loadExamplePage:self.webV];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
    NSLog(@"h5 内存过大 即将白屏");
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
   //  NSLog(@"%s",__func__);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    
    self.jsToIOSAlertCallback(alertController);
  //  [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
     NSLog(@"%s",__func__);
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler{
    NSLog(@"%s",__func__);
}

-(void)jsRegiste{

    [_webjsBridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
// =     NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"str:%@",data);
//        responseCallback = ^(id responseData){
//            responseData = @{@"res": @"callback"};
//        };
        NSString *cmd = data[@"fileCMD"];
        
        if([cmd isEqualToString:H5_CMD_BACK]){
            if (self.jsToBackCallback) {
                self.jsToBackCallback(^(id info){
                    NSLog(@"info:%@",info);
                });
            }
        }
        
        responseCallback(@{@"data":@"response"});
    }];
    
    [_webjsBridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" } responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExamplePage:(WKWebView*)webView {
    
    NSString *contentPath = [NSBundle mainBundle].bundlePath;
    
    NSString *newPath = [NSString stringWithFormat:@"%@/BlocklyDuino-pages/blockly/apps/blocklyduino/index.html",contentPath];
//    NSString *newPath = [NSString stringWithFormat:@"%@/command/index.html",contentPath];
    NSString *htmlString = [NSString stringWithContentsOfFile:newPath encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *baseurl = [NSURL fileURLWithPath:newPath];
    
    [webView loadFileURL:baseurl allowingReadAccessToURL:baseurl];
    
//    [webView loadHTMLString:htmlString baseURL:baseurl];
    
}

//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

-(void)loadFileUrl{
//调用逻辑
    NSString *contentPath = [NSBundle mainBundle].bundlePath;
    NSString *newPath = [NSString stringWithFormat:@"%@/BlocklyDuino-pages/blockly/apps/blocklyduino/index.html",contentPath];
    
  //  NSString *path = [[NSBundle mainBundle] pathForResource:newPath ofType:@"html"];
    NSString *path = newPath;
    
    if(path){
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        // iOS9. One year later things are OK.
            NSURL *fileURL = [NSURL fileURLWithPath:path];
            [self.webV loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        } else {
        // iOS8. Things can be workaround-ed
        //   Brave people can do just this
        //   fileURL = try! pathForBuggyWKWebView8(fileURL)
        //   webView.loadRequest(NSURLRequest(URL: fileURL))
        
            NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:path]];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [self.webV loadRequest:request];
        }
    }
}

@end
