Shader "Custom/Model Bumped Specular Cubemap" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 0)
	_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
	_MainTex ("Base (RGB) TransGloss (A)", 2D) = "white" {}
	_BumpMap ("Normalmap", 2D) = "bump" {}
	_Cube ("Reflection Cubemap", Cube) = "" {}
	_SpecMap ("Specularmap", 2D) = "black" {} 
	
}

SubShader {
	Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
	LOD 400
	
CGPROGRAM
#pragma surface surf Lambert
#pragma target 3.0

sampler2D _MainTex;
sampler2D _BumpMap;
sampler2D _SpecMap;
fixed4 _Color;
half _Shininess;
samplerCUBE _Cube;
struct Input {
	float2 uv_MainTex;
	float2 uv_BumpMap;
	float3 worldRefl;
	INTERNAL_DATA
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
	o.Albedo = tex.rgb * _Color.rgb;
	//o.Gloss = Luminance(tex2D(_SpecMap,IN.uv_BumpMap));
 

	//o.Gloss =tex2D(_SpecMap,IN.uv_MainTex).r;
	
	o.Alpha = tex.a * _Color.a;
	o.Specular = _Shininess*2;
	//o.Specular =1- Luminance(tex2D(_SpecMap,IN.uv_BumpMap)) ;
	o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	 
	float3 worldRefl = WorldReflectionVector (IN, o.Normal);
	fixed4 reflcol = texCUBE (_Cube, worldRefl);
	reflcol *= tex.a;
	o.Emission = reflcol.rgb * _SpecColor.rgb*tex2D(_SpecMap,IN.uv_MainTex).r;
	
	

}
ENDCG
}

FallBack "Diffuse"
}
