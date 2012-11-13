//
//  MyPath2Effect.h
//  MyGame
//
//  Created by numata on 2012/11/14.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "GMEffect.h"


enum {
    MyPath2Effect_attrib_position,
    MyPath2Effect_attrib_tex_coord0,
};

enum {
    MyPath2Effect_uniform_mvp_matrix,
    MyPath2Effect_uniform_texture0,
    MyPath2Effect_uniform_count
};


@interface MyPath2Effect : GMEffect {
    GLint uniforms[MyPath2Effect_uniform_count];
}

@property (nonatomic, readonly)        GLKEffectPropertyTransform          *transform;
@property (nonatomic, readonly)        GLKEffectPropertyTexture            *texture2d0;

- (void)updateUniformValues;
- (void)bindAttribLocations;
- (void)configureUniformLocations;

@end

