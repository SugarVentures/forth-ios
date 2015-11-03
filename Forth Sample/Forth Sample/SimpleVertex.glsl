#ifdef GL_ES
precision highp float;
#endif

attribute vec3 Position;

attribute vec2 TexCoordIn; // New
varying vec2 TexCoordOut; // New

void main(void) {
    gl_Position = vec4(Position, 1.0);
    TexCoordOut = TexCoordIn;
}