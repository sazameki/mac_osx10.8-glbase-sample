#version 150

///// Attribute Variables
in vec3 a_position;
in vec2 a_texture_coord;

///// Uniform Variables
uniform mat4    u_mvp_matrix;

///// Varying Variables
out vec4    v_color;
out vec2    v_texture_coord;


void main()
{
    v_texture_coord = a_texture_coord;
    gl_Position = u_mvp_matrix * vec4(a_position, 1.0);
}
