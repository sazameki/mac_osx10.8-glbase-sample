//
//  GMBaseEffect.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "GMEffect.h"


enum {
    GMBaseEffect_attrib_position,
    GMBaseEffect_attrib_tex_coord0,
    GMBaseEffect_attrib_normal,
    GMBaseEffect_attrib_light0,
};

enum {
    GMBaseEffect_uniform_mvp_matrix,
    GMBaseEffect_uniform_normal_matrix,
    GMBaseEffect_uniform_light_ambient_color,
    GMBaseEffect_uniform_light0_enabled,
    GMBaseEffect_uniform_light0_position,
    GMBaseEffect_uniform_light0_diffuse_color,
    GMBaseEffect_uniform_texture0,
    GMBaseEffect_uniform_texture0_enabled,
    GMBaseEffect_uniform_texture1,
    GMBaseEffect_uniform_texture1_enabled,
    GMBaseEffect_uniform_count
};


@interface GMBaseEffect : GMEffect {
    GLint uniforms[GMBaseEffect_uniform_count];
}

@property (nonatomic, readonly)        GLKEffectPropertyTransform          *transform;
@property (nonatomic, readonly)        GLKEffectPropertyLight              *light0;
@property (nonatomic, assign)          GLKVector4                          lightModelAmbientColor;
@property (nonatomic, readonly)        GLKEffectPropertyTexture            *texture2d0;

- (void)updateUniformValues;
- (void)bindAttribLocations;
- (void)configureUniformLocations;

@end

