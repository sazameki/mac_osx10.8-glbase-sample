//
//  MyRenderer.m
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#import "MyRenderer.h"


GLfloat gVertexData1[] = {
    // position      normal             tex-coord
    0.0, 0.0, 1.0,   0.0, 0.0, 1.0,     0.0, 1.0,
    1.0, 0.0, 1.0,   0.0, 0.0, 1.0,     1.0, 1.0,
    1.0, 1.0, 1.0,   0.0, 0.0, 1.0,     1.0, 0.0,
    1.0, 1.0, 1.0,   0.0, 0.0, 1.0,     1.0, 0.0,
    0.0, 1.0, 1.0,   0.0, 0.0, 1.0,     0.0, 0.0,
    0.0, 0.0, 1.0,   0.0, 0.0, 1.0,     0.0, 1.0,

    1.0, 0.0, 0.0,   1.0, 0.0, 0.0,     1.0, 1.0,
    1.0, 1.0, 0.0,   1.0, 0.0, 0.0,     1.0, 0.0,
    1.0, 1.0, 1.0,   1.0, 0.0, 0.0,     0.0, 0.0,
    1.0, 1.0, 1.0,   1.0, 0.0, 0.0,     0.0, 0.0,
    1.0, 0.0, 1.0,   1.0, 0.0, 0.0,     0.0, 1.0,
    1.0, 0.0, 0.0,   1.0, 0.0, 0.0,     1.0, 1.0,

    1.0, 1.0, 0.0,   0.0, 0.0, -1.0,    0.0, 0.0,
    0.0, 0.0, 0.0,   0.0, 0.0, -1.0,    1.0, 1.0,
    0.0, 1.0, 0.0,   0.0, 0.0, -1.0,    1.0, 0.0,
    1.0, 1.0, 0.0,   0.0, 0.0, -1.0,    0.0, 0.0,
    1.0, 0.0, 0.0,   0.0, 0.0, -1.0,    0.0, 1.0,
    0.0, 0.0, 0.0,   0.0, 0.0, -1.0,    1.0, 1.0,

    0.0, 0.0, 0.0,   -1.0, 0.0, 0.0,    0.0, 1.0,
    0.0, 1.0, 1.0,   -1.0, 0.0, 0.0,    1.0, 0.0,
    0.0, 1.0, 0.0,   -1.0, 0.0, 0.0,    0.0, 0.0,
    0.0, 0.0, 0.0,   -1.0, 0.0, 0.0,    0.0, 1.0,
    0.0, 0.0, 1.0,   -1.0, 0.0, 0.0,    1.0, 1.0,
    0.0, 1.0, 1.0,   -1.0, 0.0, 0.0,    1.0, 0.0,

    0.0, 1.0, 0.0,   0.0, 1.0, 0.0,     1.0, 0.0,
    1.0, 1.0, 1.0,   0.0, 1.0, 0.0,     0.0, 1.0,
    1.0, 1.0, 0.0,   0.0, 1.0, 0.0,     1.0, 1.0,
    0.0, 1.0, 0.0,   0.0, 1.0, 0.0,     1.0, 0.0,
    0.0, 1.0, 1.0,   0.0, 1.0, 0.0,     0.0, 0.0,
    1.0, 1.0, 1.0,   0.0, 1.0, 0.0,     0.0, 1.0,

    0.0, 0.0, 0.0,   0.0, -1.0, 0.0,    0.0, 0.0,
    1.0, 0.0, 0.0,   0.0, -1.0, 0.0,    0.0, 1.0,
    1.0, 0.0, 1.0,   0.0, -1.0, 0.0,    1.0, 1.0,
    0.0, 0.0, 0.0,   0.0, -1.0, 0.0,    0.0, 0.0,
    1.0, 0.0, 1.0,   0.0, -1.0, 0.0,    1.0, 1.0,
    0.0, 0.0, 1.0,   0.0, -1.0, 0.0,    1.0, 0.0,
};

GLfloat gVertexData2[] = {
    // position     tex-coord
    0.0, 0.0,       0.0, 0.0,
    1.0, 0.0,       1.0, 0.0,
    1.0, 1.0,       1.0, 1.0,

    1.0, 1.0,       1.0, 1.0,
    0.0, 1.0,       0.0, 1.0,
    0.0, 0.0,       0.0, 0.0,
};

@implementation MyRenderer

- (id)init
{
    self = [super init];
    if (self) {
#if DEBUG
        NSLog(@"GL_RENDERER: \"%s\"", glGetString(GL_RENDERER));
        NSLog(@"GL_VERSION: \"%s\"", glGetString(GL_VERSION));
#endif  //#if DEBUG

        NSURL *texFileURL = [[NSBundle mainBundle] URLForResource:@"block" withExtension:@"png"];
        texInfo = [GLKTextureLoader textureWithContentsOfURL:texFileURL options:nil error:NULL];

        angle = 0.0;

        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        effect = [[GMBaseEffect alloc] init];
        vao = [[GMVertexArrayObject alloc] initWithBuffer:gVertexData1 size:sizeof(gVertexData1) isStatic:YES];
        [vao addVertexAttribWithType:GMBaseEffect_attrib_position size:3 valueType:GL_FLOAT stride:32 start:0];
        [vao addVertexAttribWithType:GMBaseEffect_attrib_normal size:3 valueType:GL_FLOAT stride:32 start:12];
        [vao addVertexAttribWithType:GMBaseEffect_attrib_tex_coord0 size:2 valueType:GL_FLOAT stride:32 start:24];
        [vao setVertexCount:36];
        [vao unbind];

        effect2 = [[MyPath2Effect alloc] init];
        vao2 = [[GMVertexArrayObject alloc] initWithBuffer:gVertexData2 size:sizeof(gVertexData2) isStatic:YES];
        [vao2 addVertexAttribWithType:MyPath2Effect_attrib_position size:2 valueType:GL_FLOAT stride:16 start:0];
        [vao2 addVertexAttribWithType:MyPath2Effect_attrib_tex_coord0 size:2 valueType:GL_FLOAT stride:16 start:8];
        [vao2 setVertexCount:6];
        [vao2 unbind];

        fbo = [[GMFrameBufferObject alloc] init];
    }
    return self;
}

- (void)drawPath1:(NSSize)viewSize
{
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);

    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    GLKMatrix4 projMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), viewSize.width/viewSize.height, 0.0001, 100000.0);
    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(cos(0) * 1.7, 0.0, sin(0) * 1.7,
                                                 0.0, 0.0, 0.0,
                                                 0.0, 1.0, 0.0);

    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, -0.5, -0.5, -0.5);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, angle, 1.0, 1.0, 1.0);

    effect.transform.projectionMatrix = projMatrix;
    effect.transform.modelviewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix);

    effect.lightModelAmbientColor = GLKVector4Make(0.3, 0.3, 0.3, 1.0);

    effect.light0.enabled = true;
    effect.light0.position = GLKVector4Make(0.0, 0.0, 1.0, 1.0);
    effect.light0.diffuseColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);

    effect.texture2d0.enabled = YES;
    effect.texture2d0.target = texInfo.target;
    effect.texture2d0.name = texInfo.name;

    [effect prepareToDraw];
    [vao bind];
    [vao draw];
}

- (void)drawPath2:(NSSize)viewSize
{
    glDisable(GL_DEPTH_TEST);
    glDisable(GL_CULL_FACE);

    effect2.texture2d0.target = GL_TEXTURE_2D;
    effect2.texture2d0.name = fbo.colorTex;

    effect2.transform.projectionMatrix = GLKMatrix4MakeOrtho(0.0, 1.0, 0.0, 1.0, -100.0, 100.0);

    [vao2 bind];

    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Scale(modelMatrix, 0.5, 0.5, 1.0);
    effect2.transform.modelviewMatrix = modelMatrix;
    [effect2 prepareToDraw];
    [vao2 draw];

    modelMatrix = GLKMatrix4Translate(modelMatrix, 1.0, 0.0, 0.0);
    effect2.transform.modelviewMatrix = modelMatrix;
    [effect2 prepareToDraw];
    [vao2 draw];

    modelMatrix = GLKMatrix4Translate(modelMatrix, 0.0, 1.0, 0.0);
    effect2.transform.modelviewMatrix = modelMatrix;
    [effect2 prepareToDraw];
    [vao2 draw];

    modelMatrix = GLKMatrix4Translate(modelMatrix, -1.0, 0.0, 0.0);
    effect2.transform.modelviewMatrix = modelMatrix;
    [effect2 prepareToDraw];
    [vao2 draw];
}

- (void)drawView:(NSSize)viewSize
{
    // オフスクリーンレンダリング（FBOへの描画）
    [fbo bind];
    [self drawPath1:viewSize];

    // オンスクリーンレンダリング
    [GMFrameBufferObject unbind];
    [self drawPath2:viewSize];
}

- (void)updateModel:(double)deltaTime
{
    angle += deltaTime * GLKMathDegreesToRadians(90);
}

@end

