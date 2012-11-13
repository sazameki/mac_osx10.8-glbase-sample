//
//  GMVertexArrayObject.h
//  MyGame
//
//  Created by numata on 2012/11/14.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import <GLKit/GLKit.h>


@interface GMVertexArrayObject : NSObject {
    GLuint  vao;
    GLuint  vbo;
    GLsizei vertexCount;
}

- (id)initWithBuffer:(const GLvoid *)buffer size:(GLsizeiptr)size isStatic:(BOOL)isStatic;

- (void)addVertexAttribWithType:(GLuint)type size:(GLint)size valueType:(GLenum)type stride:(GLsizei)stride start:(GLsizei)start;
- (void)setVertexCount:(GLsizei)count;

- (void)bind;
- (void)unbind;
- (void)draw;

@end

