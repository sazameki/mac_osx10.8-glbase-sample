//
//  GMEffect.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <GLKit/GLKit.h>


@interface GMEffect : NSObject <GLKNamedEffect> {
    GLuint  program;
}

- (void)prepareToDraw;

- (void)updateUniformValues;
- (void)bindAttribLocations;
- (void)configureUniformLocations;

- (BOOL)loadShadersWithName:(NSString *)shaderName;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type filepath:(NSString *)filepath;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;

@end

