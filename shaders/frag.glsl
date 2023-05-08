#version 330 core

uniform vec2 iResolution;
uniform float iTime;

out vec4 out_color;
in vec4 gl_FragCoord;

void main()
{
    vec2 fragCoord = gl_FragCoord.xy;
    vec2 uv = fragCoord/iResolution.xy;
    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    // Output to screen
    out_color = vec4(col,1.0);
}