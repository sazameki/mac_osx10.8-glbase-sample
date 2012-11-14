#version 150

///// Uniform Variables
uniform mat4        u_mvp_matrix;
uniform sampler2D   u_texture0;
uniform int         u_mode;
uniform float       u_depth_nearz;
uniform float       u_depth_farz;

///// Varying Variables
in vec2     v_texture_coord;

out vec4    fragColor;

vec4 toSepia(vec4 color)
{
    const vec3 rgb_to_yuv = vec3(0.299, 0.587, 0.114);
    const vec3 i_to_rgb = vec3(0.956, -0.272, -1.108);
    const vec3 q_to_rgb = vec3(0.620, -0.647, 1.705);
    const float i = 0.2;
    const float q = 0.0;

    float y = dot(rgb_to_yuv, color.rgb);
    y *= 1.4;
    y = clamp(y, 0.0, 1.0);
    return vec4(y+i_to_rgb*i+q_to_rgb*q, color.a);
}

vec4 getDepthColor()
{
    vec4 tex = texture(u_texture0, v_texture_coord);
    float value = (tex.r - (1.0-u_depth_nearz)) * u_depth_farz;
    return vec4(vec3(value), 1.0);
}

vec4 getTexColor()
{
    vec4 tex = texture(u_texture0, v_texture_coord);
    return tex;
}

vec4 getMirrorTexColor()
{
    vec4 tex = texture(u_texture0, vec2(1.0-v_texture_coord.x, v_texture_coord.y));
    return tex;
}

void main()
{
    if (u_mode == 0) {
        fragColor = getDepthColor();
    } else if (u_mode == 1) {
        fragColor = toSepia(getTexColor());
    } else if (u_mode == 2) {
        fragColor = getTexColor();
    } else {
        fragColor = getMirrorTexColor();
    }
}

