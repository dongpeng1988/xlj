// Unlit alpha-blended shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Unlit/Model" {
Properties {
	_MainTex ("Base (RGB) Trans (A)", 2D) = "black" {}
	_Color("add color",Color) = (0, 0, 0, 0)
	_Alpha("transparent",float) = 1
}

SubShader {
	Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	LOD 100
	
	ZWrite off
	Blend SrcAlpha OneMinusSrcAlpha
	
	Pass {  
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			half4 _MainTex_ST;
			half _Alpha;
			fixed4 _Color;
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
			 
				fixed4 col = tex2D(_MainTex, i.texcoord)+_Color;
				col.a =col.a*_Alpha;
				return col;
			}
		ENDCG
	}
}

}
