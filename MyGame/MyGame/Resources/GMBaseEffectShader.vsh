#version 150

///// Attribute Variables
in vec3 a_position;
in vec2 a_texture_coord;
in vec3 a_normal;

///// Uniform Variables
uniform mat4    u_mvp_matrix;
uniform mat3    u_normal_matrix;
uniform vec4    u_light_ambient_color;
uniform bool    u_light0_enabled;
uniform vec4    u_light0_position;
uniform vec4    u_light0_diffuse_color;

///// Varying Variables
out vec4    v_color;
out vec2    v_texture_coord;


void main()
{
    vec3 normal = normalize(u_normal_matrix * a_normal);
    
    float nDotVP = max(0.0, dot(normal, normalize(u_light0_position).xyz));
    v_color = u_light_ambient_color;
    if (u_light0_enabled) {
        v_color = v_color + (u_light0_diffuse_color * nDotVP);
    }
   
    v_texture_coord = a_texture_coord;

    gl_Position = u_mvp_matrix * vec4(a_position, 1.0);
}
