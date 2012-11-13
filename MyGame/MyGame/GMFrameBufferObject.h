//
//  GMFrameBufferObject.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import <GLKit/GLKit.h>


@interface GMFrameBufferObject : NSObject {
    GLuint  fbo;
    GLuint  colorTex;
    GLuint  depthTex;
}

+ (void)unbind;

- (id)initWithSize:(NSSize)size;

- (void)bind;

- (GLuint)colorTex;
- (GLuint)depthTex;

@end

