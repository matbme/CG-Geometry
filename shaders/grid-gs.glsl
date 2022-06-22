#version 450 core

layout (points) in;
layout (triangle_strip, max_vertices = 4) out;

in VS_OUT {
    vec3 color;
} gs_in[];

out vec3 fColor;

uniform vec2 offsets;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void build_house(vec4 position)
{
    fColor = gs_in[0].color; // gs_in[0] since there's only one input vertex
    gl_Position = position;
    EmitVertex();

    vec4 newPoint = projection * view * model * vec4(0.0,offsets.y,0.0,0.0);
    gl_Position = position + newPoint;
    EmitVertex();

    newPoint = projection * view * model * vec4(offsets.x,0.0,0.0,0.0);
    gl_Position = position + newPoint;
    EmitVertex();

    newPoint = projection * view * model * vec4(offsets.x,offsets.y,0.0,0.0);
    gl_Position = position + newPoint;
    EmitVertex();

    EndPrimitive();
}

void main() {
    build_house(gl_in[0].gl_Position);
}
