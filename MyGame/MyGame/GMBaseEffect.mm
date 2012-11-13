//
//  GMBaseEffect.mm
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "GMBaseEffect.h"
#import <GLKit/GLKit.h>


@implementation GMBaseEffect

- (id)init
{
    self = [super init];
    if (self) {
        [self loadShadersWithName:@"GMBaseEffect"];

        _transform = [[GLKEffectPropertyTransform alloc] init];
        _light0 = [[GLKEffectPropertyLight alloc] init];

        _texture2d0 = [[GLKEffectPropertyTexture alloc] init];
        _texture2d0.enabled = false;

        glUseProgram(program);
        glUniform1i(uniforms[GMBaseEffect_uniform_texture0], 0);
    }
    return self;
}

- (void)dealloc
{
    _transform = nil;
    _light0 = nil;
    _texture2d0 = nil;
}

- (void)updateUniformValues
{
    GLKMatrix4 modelViewProjectionMatrix =
        GLKMatrix4Multiply(_transform.projectionMatrix,
                           _transform.modelviewMatrix);

    glUniformMatrix4fv(uniforms[GMBaseEffect_uniform_mvp_matrix], 1, 0, modelViewProjectionMatrix.m);

    GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(_transform.modelviewMatrix), NULL);
    glUniformMatrix3fv(uniforms[GMBaseEffect_uniform_normal_matrix], 1, 0, normalMatrix.m);

    glUniform4fv(uniforms[GMBaseEffect_uniform_light_ambient_color], 1, _lightModelAmbientColor.v);

    glUniform1i(uniforms[GMBaseEffect_uniform_light0_enabled], _light0.enabled);
    if (_light0.enabled) {
        glUniform4fv(uniforms[GMBaseEffect_uniform_light0_position], 1, _light0.position.v);
        glUniform4fv(uniforms[GMBaseEffect_uniform_light0_diffuse_color], 1, _light0.diffuseColor.v);
    }

    glUniform1i(uniforms[GMBaseEffect_uniform_texture0_enabled], _texture2d0.enabled);
    if (_texture2d0.enabled) {
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(_texture2d0.target, _texture2d0.name);
    }
}

- (void)bindAttribLocations
{
    glBindAttribLocation(program, GMBaseEffect_attrib_position, "a_position");
    glBindAttribLocation(program, GMBaseEffect_attrib_tex_coord0, "a_texture_coord");
    glBindAttribLocation(program, GMBaseEffect_attrib_normal, "a_normal");
}

- (void)configureUniformLocations
{
    uniforms[GMBaseEffect_uniform_mvp_matrix] = glGetUniformLocation(program, "u_mvp_matrix");
    uniforms[GMBaseEffect_uniform_normal_matrix] = glGetUniformLocation(program, "u_normal_matrix");
    uniforms[GMBaseEffect_uniform_light_ambient_color] = glGetUniformLocation(program, "u_light_ambient_color");
    uniforms[GMBaseEffect_uniform_light0_enabled] = glGetUniformLocation(program, "u_light0_enabled");
    uniforms[GMBaseEffect_uniform_light0_position] = glGetUniformLocation(program, "u_light0_position");
    uniforms[GMBaseEffect_uniform_light0_diffuse_color] = glGetUniformLocation(program, "u_light0_diffuse_color");

    uniforms[GMBaseEffect_uniform_texture0] = glGetUniformLocation(program, "u_texture0");
    uniforms[GMBaseEffect_uniform_texture0_enabled] = glGetUniformLocation(program, "u_texture0_enabled");

    uniforms[GMBaseEffect_uniform_texture1] = glGetUniformLocation(program, "u_texture1");
    uniforms[GMBaseEffect_uniform_texture1_enabled] = glGetUniformLocation(program, "u_texture1_enabled");
}

@end

