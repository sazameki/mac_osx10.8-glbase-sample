//
//  MyAppDelegate.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyOpenGLView.h"


@interface MyAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet MyOpenGLView *glView;

@end

