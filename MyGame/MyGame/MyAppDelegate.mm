//
//  MyAppDelegate.mm
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "MyAppDelegate.h"


@implementation MyAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_window center];
    [_window makeKeyAndOrderFront:self];
    [_window makeFirstResponder:_glView];
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

