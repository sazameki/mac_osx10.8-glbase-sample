//
//  MyRenderer.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "GMBaseEffect.h"
#import "GMFrameBufferObject.h"
#import "GMVertexArrayObject.h"
#import "MyPath2Effect.h"


@interface MyRenderer : NSObject {
    GMBaseEffect*   effect;
    MyPath2Effect*  effect2;
    GLKTextureInfo* texInfo;
    GMVertexArrayObject*    vao;
    GMVertexArrayObject*    vao2;

    double          angle;

    GMFrameBufferObject*    fbo;
}

- (void)drawView:(NSSize)viewSize;
- (void)updateModel:(double)deltaTime;

@end

