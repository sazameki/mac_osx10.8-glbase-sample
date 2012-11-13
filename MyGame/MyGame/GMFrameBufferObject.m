//
//  GMFrameBufferObject.m
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "GMFrameBufferObject.h"


@implementation GMFrameBufferObject

+ (void)unbind
{
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
}

- (id)initWithSize:(NSSize)size
{
    self = [super init];
    if (self) {
        glGenFramebuffers(1, &fbo);
        
        glBindFramebuffer(GL_FRAMEBUFFER, fbo);

        // Color Texture
        glGenTextures(1, &colorTex);
        glBindTexture(GL_TEXTURE_2D, colorTex);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexImage2D(GL_TEXTURE_2D, 0,
                     GL_RGBA,       // internal format (GL_RGB, GL_RGBA, GL_RED, GL_RG)
                     size.width, size.height,      // size
                     0,             // border (must be 0)
                     GL_RGBA,       // format (GL_RED, GL_RG, GL_RGB, GL_BGR, GL_RGBA, and GL_BGRA)
                     GL_UNSIGNED_BYTE,
                     NULL);
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, colorTex, 0);

        // Depth Buffer
        glGenTextures(1, &depthTex);
        glBindTexture(GL_TEXTURE_2D, depthTex);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexImage2D(GL_TEXTURE_2D, 0,
                     GL_DEPTH_COMPONENT,
                     size.width, size.height,      // size
                     0,             // border (must be 0)
                     GL_DEPTH_COMPONENT,
                     GL_FLOAT,
                     NULL);
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_TEXTURE_2D, depthTex, 0);

        glBindFramebuffer(GL_FRAMEBUFFER, 0);
    }
    return self;
}

- (void)dealloc
{
    glDeleteFramebuffers(1, &fbo);
}

- (void)bind
{
    glBindFramebuffer(GL_FRAMEBUFFER, fbo);
}

- (GLuint)colorTex
{
    return colorTex;
}

- (GLuint)depthTex
{
    return depthTex;
}

@end

