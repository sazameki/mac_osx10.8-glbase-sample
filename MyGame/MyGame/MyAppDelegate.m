//
//  MyAppDelegate.m
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "MyAppDelegate.h"


@implementation MyAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_window setContentSize:NSMakeSize(SCREEN_SIZE_X, SCREEN_SIZE_Y)];

    [_window center];
    [_window makeKeyAndOrderFront:self];
    [_window makeFirstResponder:_glView];
}

- (NSSize)window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
{
    float aspect = (float)SCREEN_SIZE_X / SCREEN_SIZE_Y;
    NSSize ret;
    if (proposedSize.width / proposedSize.height < aspect) {
        ret = NSMakeSize(proposedSize.width, (int)(proposedSize.width / aspect));
    } else {
        ret = NSMakeSize((int)(proposedSize.height * aspect), proposedSize.height);
    }
    [_glView willUseFullScreenWithSize:ret];
    return ret;
}

- (void)windowWillEnterFullScreen:(NSNotification *)notification
{
    [_glView willEnterFullScreen];
}

- (void)windowDidEnterFullScreen:(NSNotification *)notification
{
    [_glView didEnterFullScreen];
}

- (void)windowWillExitFullScreen:(NSNotification *)notification
{
    [_glView willExitFullScreen];
}

- (void)windowDidExitFullScreen:(NSNotification *)notification
{
    [_glView didExitFullScreen];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [NSApp terminate:self];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication*)sender
{
    if (gIsAppFinished) {
        return NSTerminateNow;
    } else {
        [_glView stopGame];
        return NSTerminateLater;
    }
}

@end

