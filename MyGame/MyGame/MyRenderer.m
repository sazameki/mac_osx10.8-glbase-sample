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

- (id)initWithSize:(NSSize)size scale:(float)scale
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

        fbo = [[GMFrameBufferObject alloc] initWithSize:NSMakeSize(size.width * scale, size.height * scale)];
    }
    return self;
}

/*
    @method     drawPath1:screenSize:scale
    @abstract   （パス1）FBOへの描画を行います。
    @param viewSize     ビューの大きさ（フルスクリーン時に変化する）
    @param screenSize   ゲーム画面の大きさ（固定）
    @param scale        通常解像度の時は1.0、Retina画面使用時は2.0
 */
- (void)drawPath1:(NSSize)viewSize screenSize:(NSSize)screenSize scale:(float)scale
{
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);

    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // FBOへの描画時にはスケーリングしない（画面への直接描画時にはスケーリング必要）
    //glViewport(0.0, 0.0, screenSize.width * scale, screenSize.height * scale);
    glViewport(0.0, 0.0, screenSize.width, screenSize.height);

    GLKMatrix4 projMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), viewSize.width/viewSize.height, 0.001, 1000.0);
    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(cos(angle) * 1.7, 2.0, sin(angle) * 1.7,
                                                 0.0, 0.0, 0.0,
                                                 0.0, 1.0, 0.0);

    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, -0.5, -0.5, -0.5);
    modelMatrix = GLKMatrix4Scale(modelMatrix, 1.5, 1.5, 1.5);
    //modelMatrix = GLKMatrix4Rotate(modelMatrix, angle, 0.0, 1.0, 0.0);

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

/*
    @method     drawPath2:screenSize:scale
    @abstract   （パス2）画面への直接描画を行います。
    @param viewSize     ビューの大きさ（フルスクリーン時に変化する）
    @param screenSize   ゲーム画面の大きさ（固定）
    @param scale        通常解像度の時は1.0、Retina画面使用時は2.0
 */
- (void)drawPath2:(NSSize)viewSize screenSize:(NSSize)screenSize scale:(float)scale
{
    glDisable(GL_DEPTH_TEST);
    glDisable(GL_CULL_FACE);

    effect2.texture2d0.target = GL_TEXTURE_2D;

    effect2.transform.projectionMatrix = GLKMatrix4MakeOrtho(0.0, 1.0, 0.0, 1.0, -100.0, 100.0);

    // FBOでない画面への直接描画時にはスケーリングする
    glViewport(0.0, 0.0, viewSize.width * scale, viewSize.height * scale);

    [vao2 bind];

    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Scale(modelMatrix, 0.5, 0.5, 1.0);

    effect2.transform.modelviewMatrix = modelMatrix;
    effect2.texture2d0.name = fbo.depthTex;
    effect2.mode = 0;
    effect2.depthNearZ = 0.001;
    effect2.depthFarZ = 1000.0;
    [effect2 prepareToDraw];
    [vao2 draw];

    modelMatrix = GLKMatrix4Translate(modelMatrix, 1.0, 0.0, 0.0);
    effect2.transform.modelviewMatrix = modelMatrix;
    effect2.texture2d0.name = fbo.colorTex;
    effect2.mode = 1;
    [effect2 prepareToDraw];
    [vao2 draw];

    modelMatrix = GLKMatrix4Translate(modelMatrix, -1.0, 1.0, 0.0);
    effect2.transform.modelviewMatrix = modelMatrix;
    effect2.texture2d0.name = fbo.colorTex;
    effect2.mode = 2;
    [effect2 prepareToDraw];
    [vao2 draw];

    modelMatrix = GLKMatrix4Translate(modelMatrix, 1.0, 0.0, 0.0);
    effect2.transform.modelviewMatrix = modelMatrix;
    effect2.mode = 3;
    [effect2 prepareToDraw];
    [vao2 draw];
}

/*
    @method     drawView:screenSize:scale
    @abstract   画面の描画を行います。
    @param viewSize     ビューの大きさ（フルスクリーン時に変化する）
    @param screenSize   ゲーム画面の大きさ（固定）
    @param scale        通常解像度の時は1.0、Retina画面使用時は2.0
 */
- (void)drawView:(NSSize)viewSize screenSize:(NSSize)screenSize scale:(float)scale
{
    // オフスクリーンレンダリング（FBOへの描画）
    [fbo bind];
    [self drawPath1:viewSize screenSize:screenSize scale:scale];

    // オンスクリーンレンダリング
    [GMFrameBufferObject unbind];
    [self drawPath2:viewSize screenSize:screenSize scale:scale];
}

- (void)updateModel:(double)deltaTime
{
    angle += deltaTime * GLKMathDegreesToRadians(90);
}

@end

