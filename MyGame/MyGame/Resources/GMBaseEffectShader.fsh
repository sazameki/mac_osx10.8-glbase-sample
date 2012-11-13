#version 150

///// Uniform Variables
uniform mat4    u_mvp_matrix;
uniform mat3    u_normal_matrix;
uniform vec4    u_light_ambient_color;
uniform vec3    u_light0_position;
uniform vec4    u_light0_diffuseColor;
uniform sampler2D   u_texture0;
uniform bool        u_texture0_enabled;

///// Varying Variables
in vec4     v_color;
in vec2     v_texture_coord;

out vec4    fragColor;


void main()
{
    vec4 c0 = vec4(1.0);
    if (u_texture0_enabled) {
        c0 = texture(u_texture0, v_texture_coord);
    }
    vec4 color = v_color;
    color = color * c0;
    fragColor = color;
}

