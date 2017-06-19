/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/

#include "renderer.hpp"
#if defined __APPLE__
#include <OpenGLES/ES2/gl.h>
#else
#include <GLES2/gl2.h>
#endif

#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>


const char* box_video_vert="uniform mat4 trans;\n"
        "uniform mat4 proj;\n"
        "attribute vec4 coord;\n"
        "attribute vec2 texcoord;\n"
        "varying vec2 vtexcoord;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    vtexcoord = texcoord;\n"
        "    gl_Position = proj*trans*coord;\n"
        "}\n"
        "\n"
;

const char* box_video_frag="#ifdef GL_ES\n"
        "precision highp float;\n"
        "#endif\n"
        "varying vec2 vtexcoord;\n"
        "uniform sampler2D texture;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    gl_FragColor = texture2D(texture, vtexcoord);\n"
        "}\n"
        "\n"
;

namespace EasyAR{
namespace samples{

void VideoRenderer::init()
{
    program_box = glCreateProgram(); // program
    
    GLuint vertShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertShader, 1, &box_video_vert, 0);       //加载向量 shader
    glCompileShader(vertShader);                             //编译向量 shader
    
    GLuint fragShader = glCreateShader(GL_FRAGMENT_SHADER);  //加载颜色
    glShaderSource(fragShader, 1, &box_video_frag, 0);
    glCompileShader(fragShader);
    
    glAttachShader(program_box, vertShader);    // 附着shader
    glAttachShader(program_box, fragShader);    // 附着shader
    
    glLinkProgram(program_box);    //链接
    glUseProgram(program_box);
    
    pos_coord_box = glGetAttribLocation(program_box, "coord");    //获取shader 文件属性
    pos_tex_box = glGetAttribLocation(program_box, "texcoord");   //
    pos_trans_box = glGetUniformLocation(program_box, "trans");   //
    pos_proj_box = glGetUniformLocation(program_box, "proj");     //

    glGenBuffers(1, &vbo_coord_box);
    glBindBuffer(GL_ARRAY_BUFFER, vbo_coord_box);
    const GLfloat cube_vertices[4][3] = {{1.0f / 2, 1.0f / 2, 0.f},
                                        {1.0f / 2, -1.0f / 2, 0.f},
                                        {-1.0f / 2, -1.0f / 2, 0.f},
                                        {-1.0f / 1, 1.0f / 2, 0.f}};
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(cube_vertices), cube_vertices, GL_DYNAMIC_DRAW);

    glGenBuffers(1, &vbo_tex_box);
    glBindBuffer(GL_ARRAY_BUFFER, vbo_tex_box);
    const GLubyte cube_vertex_texs[4][2] = {{0, 0},{0, 1},{1, 1},{1, 0}};
    glBufferData(GL_ARRAY_BUFFER, sizeof(cube_vertex_texs), cube_vertex_texs, GL_STATIC_DRAW);

    glGenBuffers(1, &vbo_faces_box);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vbo_faces_box);
    const GLushort cube_faces[] = {3, 2, 1, 0};
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(cube_faces), cube_faces, GL_STATIC_DRAW);

    glUniform1i(glGetUniformLocation(program_box, "texture"), 0);
    glGenTextures(1, &texture_id);
    glBindTexture(GL_TEXTURE_2D, texture_id);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
}
    
void VideoRenderer::render(const Matrix44F& projectionMatrix, const Matrix44F& cameraview, Vec2F size ,ImageData *data){
    
    
    
}


void VideoRenderer::render(const Matrix44F& projectionMatrix, const Matrix44F& cameraview, Vec2F size)
{
    glBindBuffer(GL_ARRAY_BUFFER, vbo_coord_box);
    const GLfloat cube_vertices[4][3] =
       {
        {size[0] / 2, size[1] / 2, 0.f},
        {size[0] / 2,-size[1] / 2, 0.f},
       {-size[0] / 2,-size[1] / 2, 0.f},
       {-size[0] / 2, size[1] / 2, 0.f}
       };
    glBufferData(GL_ARRAY_BUFFER, sizeof(cube_vertices), cube_vertices, GL_DYNAMIC_DRAW);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_DEPTH_TEST);
    glUseProgram(program_box);
    glBindBuffer(GL_ARRAY_BUFFER, vbo_coord_box);
    glEnableVertexAttribArray(pos_coord_box);   //使能顶点属性
    
    //规格化数据 3
    glVertexAttribPointer(pos_coord_box, 3, GL_FLOAT, GL_FALSE, 0, 0);   // 规格化数据
    glBindBuffer(GL_ARRAY_BUFFER, vbo_tex_box);
    glEnableVertexAttribArray(pos_tex_box);
    glVertexAttribPointer(pos_tex_box, 2, GL_UNSIGNED_BYTE, GL_FALSE, 0, 0);  //顶点更新的位置,大小偏移量等
    
    glUniformMatrix4fv(pos_trans_box, 1, 0, cameraview.data);     //给着色器的矩阵赋值
    glUniformMatrix4fv(pos_proj_box, 1, 0, projectionMatrix.data);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vbo_faces_box);
    
    //
    //当前活跃的纹理单元
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture_id);
    
  /*glDrawElements(GL_TRIANGLES,ntrivert,GL_UNSIGNED_INT,trivert);
     第一个参数是类型
     第二个点数目
     第三个指的是第四个参数的类型
     第四个参数是三角形的索引数据*/
    glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_SHORT, 0);
    glBindTexture(GL_TEXTURE_2D, 0);
}


    
unsigned int VideoRenderer::texId()
{
    return texture_id;
}

}
}
