//
//  MyOpenGLView.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Globals.h"


@interface MyOpenGLView : NSOpenGLView

- (void)willUseFullScreenWithSize:(NSSize)size;
- (void)willEnterFullScreen;
- (void)didEnterFullScreen;
- (void)willExitFullScreen;
- (void)didExitFullScreen;

- (void)stopGame;

@end

