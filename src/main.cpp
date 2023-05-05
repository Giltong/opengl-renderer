#include <iostream>
#include "glad/glad.h"
#include "GLFW/glfw3.h"

static void glfwError(int id, const char* description)
{
    std::cerr << description << std::endl;
}


const int WINDOW_WIDTH = 800;
const int WINDOW_HEIGHT = 800;

int main() {
    glfwSetErrorCallback(glfwError);
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    glfwWindowHint(GLFW_RESIZABLE, 0);

    GLFWwindow* window = glfwCreateWindow(WINDOW_WIDTH,WINDOW_HEIGHT,"Ray Tracer", nullptr, nullptr);

    if(window == nullptr)
    {
        std::cerr << "Failed to create GLFW window!" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    if(!gladLoadGLLoader((GLADloadproc) glfwGetProcAddress))
    {
        std::cerr << "Failed to initialize glad" << std::endl;
        return -1;
    }
    glViewport(0,0,WINDOW_WIDTH,WINDOW_HEIGHT);

    while(!glfwWindowShouldClose(window))
    {
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    return 0;
}
