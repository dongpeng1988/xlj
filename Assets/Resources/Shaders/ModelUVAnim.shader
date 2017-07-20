Shader "Custom/Model UV Anim" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_2Color ("Tex2 Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) TransGloss (A)", 2D) = "white" {}
	_TEX2 ("Base (RGB) TransGloss (A)", 2D) = "white" {}
 
	
}

SubShader {
	Tags { "IgnoreProjector"="True" "RenderType"="Opaque" "Queue"="Opaque"}
	LOD 400
	Lighting Off
	
CGPROGRAM
#pragma surface surf NoLight noforwardadd
#pragma target 3.0

sampler2D _MainTex;
sampler2D _TEX2; 
fixed4 _Color;
fixed4 _2Color;
struct Input {
	float2 uv_MainTex;
	float2 uv_TEX2; 
	INTERNAL_DATA
};
fixed4 LightingNoLight(SurfaceOutput s, fixed3 lightDir, fixed atten)
{
 fixed4 c;
 c.rgb = s.Albedo; 
 c.a = s.Alpha;
 return c;
}
void surf (Input IN, inout SurfaceOutput o) {
	fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
	o.Albedo = tex.rgb * _Color.rgb;
	
	
	o.Alpha =_Color.a+tex.a;
	fixed4 uvtex = tex2D(_TEX2, IN.uv_TEX2);
	 
	
	o.Emission = _2Color.rgb*uvtex.rgb * tex.a;
	
	

}
ENDCG
}

FallBack "Diffuse"
}
