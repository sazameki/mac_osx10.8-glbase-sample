//
//  MyRenderer.m
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "MyRenderer.h"


#define BUFFER_OFFSET(i) ((char *)NULL + (i))

GLfloat gVertexData[] = {
    0.0, 0.0, 1.0,   0.0, 0.0, 1.0,     1.0, 0.0,
    1.0, 0.0, 1.0,   0.0, 0.0, 1.0,     0.0, 0.0,
    1.0, 1.0, 1.0,   0.0, 0.0, 1.0,     0.0, 1.0,

    1.0, 1.0, 1.0,   0.0, 0.0, 1.0,     0.0, 1.0,
    0.0, 1.0, 1.0,   0.0, 0.0, 1.0,     1.0, 1.0,
    0.0, 0.0, 1.0,   0.0, 0.0, 1.0,     1.0, 0.0,

    1.0, 0.0, 0.0,   1.0, 0.0, 0.0,     0.0, 0.0,
    1.0, 1.0, 0.0,   1.0, 0.0, 0.0,     0.0, 1.0,
    1.0, 1.0, 1.0,   1.0, 0.0, 0.0,     1.0, 1.0,

    1.0, 1.0, 1.0,   1.0, 0.0, 0.0,     1.0, 1.0,
    1.0, 0.0, 1.0,   1.0, 0.0, 0.0,     1.0, 0.0,
    1.0, 0.0, 0.0,   1.0, 0.0, 0.0,     0.0, 0.0,
};


@implementation MyRenderer

- (id)init
{
    self = [super init];
    if (self) {
        effect = [[GMBaseEffect alloc] init];

        NSURL *texFileURL = [[NSBundle mainBundle] URLForResource:@"block" withExtension:@"png"];
        texInfo = [GLKTextureLoader textureWithContentsOfURL:texFileURL options:nil error:NULL];

        angle = 0.0;

        effect.texture2d0.enabled = YES;

        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        glEnable(GL_DEPTH_TEST);
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

        glGenVertexArrays(1, &_vertexArray);
        glBindVertexArray(_vertexArray);

        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, sizeof(gVertexData), gVertexData, GL_STATIC_DRAW);

        glEnableVertexAttribArray(GMBaseEffect_attrib_position);
        glVertexAttribPointer(GMBaseEffect_attrib_position, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(0));
        glEnableVertexAttribArray(GMBaseEffect_attrib_normal);
        glVertexAttribPointer(GMBaseEffect_attrib_normal, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(12));
        glEnableVertexAttribArray(GMBaseEffect_attrib_tex_coord0);
        glVertexAttribPointer(GMBaseEffect_attrib_tex_coord0, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(24));
        
        glBindVertexArray(0);
    }
    return self;
}

- (void)drawView:(NSSize)viewSize
{
    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    GLKMatrix4 projMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), viewSize.width/viewSize.height, 0.0001, 100000.0);
    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(cos(angle) * 2.5, 1.5, sin(angle) * 2.5,
                                                 0.0, 0.0, 0.0,
                                                 0.0, 1.0, 0.0);

    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, 0.0, 0.0, 0.0f);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, angle, 1.0f, 1.0f, 1.0f);

    effect.transform.projectionMatrix = projMatrix;
    effect.transform.modelviewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix);

    effect.lightModelAmbientColor = GLKVector4Make(0.3, 0.3, 0.3, 1.0);

    effect.light0.enabled = true;
    effect.light0.position = GLKVector4Make(0.0, 0.0, 1.0, 1.0);
    effect.light0.diffuseColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);

    effect.texture2d0.target = texInfo.target;
    effect.texture2d0.name = texInfo.name;

    [effect prepareToDraw];
    glEnable(GL_DEPTH_TEST);
    glBindVertexArray(_vertexArray);
    glDrawArrays(GL_TRIANGLES, 0, 12);
}

- (void)updateModel:(double)deltaTime
{
    angle += deltaTime * GLKMathDegreesToRadians(90);
}

@end

