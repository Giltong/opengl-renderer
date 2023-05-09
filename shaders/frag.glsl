#version 460 core
#extension GL_ARB_gpu_shader_fp64 : enable

uniform vec2 iResolution;
uniform float iTime;
uniform dvec2 offset;
uniform double scale;

out vec4 out_color;

#define MAX_ITERATIONS 1000

int get_iterations()
{
    vec2 uv = gl_FragCoord.xy / iResolution.xy - 0.5;
    double real = (uv.x * 4.0f + offset.x / scale) * scale;
    double imag = (uv.y * 4.0f + offset.y / scale) * scale;

    int iterations = 0;
    double const_real = real;
    double const_imag = imag;

    real = 0;
    imag = 0;

    double real2 = 0;
    double imag2 = 0;

    while(real2 + imag2 <= 4 && iterations < MAX_ITERATIONS)
    {
        imag = 2 * real * imag + const_imag;
        real = real2 - imag2 + const_real;
        real2 = real * real;
        imag2 = imag * imag;
        iterations++;
    }
    return iterations;
}

vec4 return_color()
{
    int iter = get_iterations();
    if (iter == MAX_ITERATIONS)
    {
        gl_FragDepth = 0.0f;
        return vec4(0.0f, 0.0f, 0.0f, 1.0f);
    }

    float iterations = float(iter) / MAX_ITERATIONS;
    return(vec4(vec3(iterations), 1.0f));
}

void main()
{
    out_color = return_color();
}