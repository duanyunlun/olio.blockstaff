attribute highp vec3 _glesVertex;
attribute mediump vec2 _glesMultiTexCoord0;
attribute lowp vec4 _glesColor;

uniform lowp vec4 _MainColor;
uniform lowp float _alphaRate;
uniform lowp float _colorRate;

uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform lowp float _speedu;
uniform lowp float _speedv;
uniform lowp float glstate_timer;

varying mediump vec2 _base_uv;
varying lowp vec4 attcolor;


uniform lowp float glstate_fog_start;
uniform lowp float glstate_fog_end;
varying lowp float factor;

void main()
{
    lowp vec2 _speed= vec2(_speedu,_speedv);
	_base_uv = _glesMultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw+ _speed * glstate_timer;
	attcolor=_glesColor*_MainColor;
	attcolor.rgb=attcolor.rgb*_colorRate;
	attcolor.a=attcolor.a*_alphaRate;
	
	highp vec4 pos = glstate_matrix_mvp * vec4(_glesVertex.xyz, 1.0);
    factor = (glstate_fog_end - abs(pos.z))/(glstate_fog_end - glstate_fog_start); 
    factor = clamp(factor, 0.0, 1.0);  

	gl_Position = pos;
}

