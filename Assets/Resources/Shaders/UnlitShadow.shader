Shader "Custom/UnlitShadow" {
	Properties {
		
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_GlowColor ("Main Color", Color) = (0,0,0,0)
	}
	SubShader {
		Tags {"RenderType"="Opaque"}
		Pass 
		{
			Tags {"LightMode" = "ForwardBase"}
			Lighting off
		    CGPROGRAM
		   #pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				struct appdata_t
				{
					half4 vertex : POSITION;					
					half2 texcoord : TEXCOORD0;
					
				};

				struct v2f
				{
					half4 vertex : POSITION;
					
					half2 texcoord : TEXCOORD0;
				};

				sampler2D _MainTex;
				half4 _MainTex_ST;
				half4 _GlowColor;
				v2f vert (appdata_t v)
				{
					v2f o;
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
					 
					return o;
				}

				half4 frag (v2f i) : COLOR
				{
					half4 tex = tex2D(_MainTex, i.texcoord);
					tex.rgb = tex.rgb+_GlowColor.rgb;
					return tex;
				}

		    ENDCG
		}
	} 
	FallBack "Diffuse"
}
