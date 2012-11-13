//
//  MyOpenGLView.m
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "MyOpenGLView.h"
#import <QuartzCore/CVDisplayLink.h>
#include <sys/time.h>
#include "MyRenderer.h"


static double               prevTime;
static CGLPixelFormatObj    cglPixelFormat;
static CGLContextObj        cglContext;
static NSRect               viewFrame;


static double GetCurrentTime()
{
    static struct timeval tv;
    gettimeofday(&tv, NULL);
    return (double)tv.tv_sec + (double)tv.tv_usec / 1000000.0;
}


@interface MyOpenGLView () {
    CVDisplayLinkRef    displayLink;
}

@property(retain, nonatomic) MyRenderer*        renderer;

@end


@implementation MyOpenGLView

/*!
    @method     initWithFrame:
    @abstract   ビューの初期化を行います。
    IBでCustom Viewを貼り付けた場合、このメソッドが呼ばれます。
 */
- (id)initWithFrame:(NSRect)frame
{
    NSOpenGLPixelFormatAttribute attrs[] = {
        NSOpenGLPFAWindow,
        NSOpenGLPFAAccelerated,
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFANoRecovery,
        NSOpenGLPFAColorSize, (NSOpenGLPixelFormatAttribute)GM_COLOR_BUFFER_SIZE,
        NSOpenGLPFAAlphaSize, (NSOpenGLPixelFormatAttribute)GM_ALPHA_BUFFER_SIZE,
        NSOpenGLPFADepthSize, (NSOpenGLPixelFormatAttribute)GM_DEPTH_BUFFER_SIZE,

#if GM_USES_MSAA
        NSOpenGLPFAMultisample,
        NSOpenGLPFASampleBuffers, (NSOpenGLPixelFormatAttribute)1,
        NSOpenGLPFASamples, (NSOpenGLPixelFormatAttribute)4,
#endif  //#if GM_USES_MSAA

#if GM_USES_MSAA_SUPERSAMPLE
        NSOpenGLPFASupersample, (NSOpenGLPixelFormatAttribute)1,
#endif  //#if GM_USES_MSAA_SUPERSAMPLE

#if GM_USES_MSAA_ALPHA
        NSOpenGLPFASampleAlpha, (NSOpenGLPixelFormatAttribute)1,
#endif  //#if GM_USES_MSAA_ALPHA

        (NSOpenGLPixelFormatAttribute)0
    };
    NSOpenGLPixelFormat *pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];
    if (!pixelFormat) {
        [NSException raise:@"MyOpenGLView Error" format:@"Failed to create pixel format."];
    }

    self = [super initWithFrame:frame pixelFormat:pixelFormat];
    if (self) {
        [self setWantsBestResolutionOpenGLSurface:YES];

        viewFrame = [self convertRectToBacking:frame];
    }
    return self;
}

static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink,
                                      const CVTimeStamp* now,
                                      const CVTimeStamp* outputTime,
                                      CVOptionFlags flagsIn,
                                      CVOptionFlags* flagsOut,
                                      void* displayLinkContext)
{
    @autoreleasepool {
        MyOpenGLView* glView = (__bridge MyOpenGLView*)displayLinkContext;
        MyRenderer* renderer = glView.renderer;

        CGLLockContext(cglContext);
        CGLSetCurrentContext(cglContext);
        [renderer drawView:viewFrame.size];
        CGLFlushDrawable(cglContext);

        double time = GetCurrentTime();
        double deltaTime = time - prevTime;
        [renderer updateModel:deltaTime];
        prevTime = time;

        CGLUnlockContext(cglContext);

        return kCVReturnSuccess;
    }
}

- (void)prepareOpenGL
{
    cglContext = (CGLContextObj)[self openGLContext].CGLContextObj;
    cglPixelFormat = (CGLPixelFormatObj)[self pixelFormat].CGLPixelFormatObj;

    // 最初の時間の取得
    prevTime = GetCurrentTime();

    // ビューサイズの取得
    viewFrame = [self frame];

    // ゲームの作成
    _renderer = [[MyRenderer alloc] init];

    // ディスプレイリンクの作成
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
    CVDisplayLinkSetOutputCallback(displayLink, &MyDisplayLinkCallback, (__bridge void*)(self));
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
    CVDisplayLinkStart(displayLink);
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGLLockContext(cglContext);
    CGLSetCurrentContext(cglContext);

    [_renderer drawView:viewFrame.size];

    CGLFlushDrawable(cglContext);
    CGLUnlockContext(cglContext);
}

- (void)stopGame
{
    CVDisplayLinkStop(displayLink);
    CVDisplayLinkRelease(displayLink);

    _renderer = nil;

    gIsAppFinished = true;
    [NSApp replyToApplicationShouldTerminate:YES];
}

@end

