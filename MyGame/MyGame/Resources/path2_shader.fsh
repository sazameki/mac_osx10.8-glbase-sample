#version 150

///// Uniform Variables
uniform mat4        u_mvp_matrix;
uniform sampler2D   u_texture0;

///// Varying Variables
in vec2     v_texture_coord;

out vec4    fragColor;

vec4 convertToSepia(vec4 color)
{
    const vec3 rgb_to_yuv = vec3(0.299, 0.587, 0.114);
    const vec3 i_to_rgb = vec3(0.956, -0.272, -1.108);
    const vec3 q_to_rgb = vec3(0.620, -0.647, 1.705);
    const float i = 0.2;
    const float q = 0.0;

    float y = dot(rgb_to_yuv, color.rgb);
    y *= 1.4;
    if (y > 1.0) {
        y = 1.0;
    }
    return vec4(y+i_to_rgb*i+q_to_rgb*q, color.a);
}

void main()
{
    vec4 color = texture(u_texture0, v_texture_coord);
    fragColor = convertToSepia(color);
}

