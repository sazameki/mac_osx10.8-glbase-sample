//
//  GMVertexArrayObject.m
//  MyGame
//
//  Created by numata on 2012/11/14.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "GMVertexArrayObject.h"


@implementation GMVertexArrayObject

- (id)initWithBuffer:(const GLvoid *)buffer size:(GLsizeiptr)size isStatic:(BOOL)isStatic
{
    self = [super init];
    if (self) {
        glGenVertexArrays(1, &vao);
        glBindVertexArray(vao);

        glGenBuffers(1, &vbo);
        glBindBuffer(GL_ARRAY_BUFFER, vbo);
        glBufferData(GL_ARRAY_BUFFER, size, buffer, (isStatic? GL_STATIC_DRAW: GL_DYNAMIC_DRAW));
    }
    return self;
}

- (void)dealloc
{
    glDeleteBuffers(1, &vbo);
    glDeleteVertexArrays(1, &vao);
}

- (void)addVertexAttribWithType:(GLuint)attrType
                           size:(GLint)size
                      valueType:(GLenum)valueType
                         stride:(GLsizei)stride
                          start:(GLsizei)start
{
    glEnableVertexAttribArray(attrType);
    glVertexAttribPointer(attrType, size, valueType, GL_FALSE, stride, (char *)0 + start);
}

- (void)setVertexCount:(GLsizei)count
{
    vertexCount = count;
}

- (void)bind
{
    glBindVertexArray(vao);
}

- (void)unbind
{
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
}

- (void)draw
{
    glDrawArrays(GL_TRIANGLES, 0, vertexCount);
}

@end

