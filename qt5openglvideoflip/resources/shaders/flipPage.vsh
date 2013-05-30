attribute highp vec4 qt_Vertex;
attribute highp vec4 qt_MultiTexCoord0;
uniform highp mat4 qt_Matrix;
varying highp vec2 qt_TexCoord0;
varying highp vec4 pos;

void main(void)
{
    gl_Position = qt_Matrix * qt_Vertex;
    pos = gl_Position;
    qt_TexCoord0 = qt_MultiTexCoord0.xy;
}
