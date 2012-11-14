//
//  MyPath2Effect.m
//  MyGame
//
//  Created by numata on 2012/11/14.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "MyPath2Effect.h"
#import <GLKit/GLKit.h>


@implementation MyPath2Effect

- (id)init
{
    self = [super init];
    if (self) {
        [self loadShadersWithName:@"path2_shader"];

        _transform = [[GLKEffectPropertyTransform alloc] init];

        _texture2d0 = [[GLKEffectPropertyTexture alloc] init];
        _texture2d0.enabled = false;

        glUseProgram(program);
        glUniform1i(uniforms[MyPath2Effect_uniform_texture0], 0);
    }
    return self;
}

- (void)dealloc
{
    _transform = nil;
    _texture2d0 = nil;
}

- (void)updateUniformValues
{
    GLKMatrix4 modelViewProjectionMatrix =
        GLKMatrix4Multiply(_transform.projectionMatrix,
                           _transform.modelviewMatrix);
    glUniformMatrix4fv(uniforms[MyPath2Effect_uniform_mvp_matrix], 1, 0, modelViewProjectionMatrix.m);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(_texture2d0.target, _texture2d0.name);

    glUniform1i(uniforms[MyPath2Effect_uniform_mode], _mode);
    glUniform1f(uniforms[MyPath2Effect_uniform_depth_nearz], _depthNearZ);
    glUniform1f(uniforms[MyPath2Effect_uniform_depth_farz], _depthFarZ);
}

- (void)bindAttribLocations
{
    glBindAttribLocation(program, MyPath2Effect_attrib_position, "a_position");
    glBindAttribLocation(program, MyPath2Effect_attrib_tex_coord0, "a_texture_coord");
}

- (void)configureUniformLocations
{
    uniforms[MyPath2Effect_uniform_mvp_matrix] = glGetUniformLocation(program, "u_mvp_matrix");
    uniforms[MyPath2Effect_uniform_texture0] = glGetUniformLocation(program, "u_texture0");
    uniforms[MyPath2Effect_uniform_mode] = glGetUniformLocation(program, "u_mode");
    uniforms[MyPath2Effect_uniform_depth_nearz] = glGetUniformLocation(program, "u_depth_nearz");
    uniforms[MyPath2Effect_uniform_depth_farz] = glGetUniformLocation(program, "u_depth_farz");
}

@end

