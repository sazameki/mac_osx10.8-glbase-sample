//
//  MyRenderer.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#include "GMBaseEffect.h"


@interface MyRenderer : NSObject {
    GMBaseEffect*   effect;
    GLKTextureInfo* texInfo;

    double          angle;

    GLuint _vertexArray;
    GLuint _vertexBuffer;
}

- (void)drawView:(NSSize)viewSize;
- (void)updateModel:(double)deltaTime;

@end

