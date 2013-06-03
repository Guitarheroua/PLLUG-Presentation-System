#ifdef GL_ES
precision mediump float;
#else
#   define lowp
#   define mediump
#   define highp
#endif
varying highp vec2 qt_TexCoord0;
varying highp vec4 pos;
uniform highp float width;
uniform highp float height;
uniform highp float screenWidth;
uniform highp float screenHeight;
uniform highp float angle;
uniform sampler2D source;
uniform sampler2D source1;
uniform lowp float qt_Opacity;

void main()
{

//    highp float PI = 3.141592653589793238462643383279;
    highp vec2 point = qt_TexCoord0;
    highp vec2 oldPoint = qt_TexCoord0;
    highp float rAngle = radians(angle);
	
	//highp float widthCoeff = width*0.854;
	highp float widthCoeff = 800.0*0.854;
	highp float heightCoeff = 800.0*1.919;
	
    vec4 color = texture2D(source, point.xy);

    //           point.y = (-pos.y /((pos.w + 5.0 *( point.x - 0.5 )/15.0*tan(-rAngle))*1.61)+0.455);

    //float y = (-pos.y /((pos.w + 5.0 *( point.x - 0.5 )/tan(-rAngle))*(height*1.60/600.0))+0.455+0.014);
	float y = (-pos.y /((pos.w + 5.0 *( point.x - 0.5 )/tan(-rAngle))*(heightCoeff/screenHeight)) + widthCoeff/screenWidth);
    float x = point.x + (( point.x - 0.5 )/ tan(-rAngle));

    vec2 newPoint = vec2(x,y);

    if ( angle > 180.0 || point.x > 0.5)
    {
        if ( angle > 180.0 && point.x > 0.5 )
        {
            color = texture2D(source1, point.xy);
        }
        else
        {
            point = newPoint;
            color = texture2D(source, point.xy);
        }
        if ( angle > 180.0 && oldPoint.x < 0.5)
        {
            vec2 p;
            float x = oldPoint.x - (( oldPoint.x - 0.5 )/ tan(-rAngle));
            p.x = x;
            p.y = point.y;
            if ( p.x < 0.0)
            {
                color = texture2D(source, oldPoint);
            }
            else
            {
                color = texture2D(source1, p.xy);
            }

        }
    }

    if ( point.x > 1.0 && angle > 180.0 )
    {
        color = texture2D(source, vec2(oldPoint.x,oldPoint.y));
    }
    else
    if ( point.x < 0.0 || point.y < 0.0 || point.x > 1.0 || point.y > 1.0 )
        color = texture2D(source1, vec2(oldPoint.x,oldPoint.y));


    gl_FragColor = qt_Opacity *color/**(color.x+0.8)*/;

}
