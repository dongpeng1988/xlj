Shader "Custom/CameraEffect" {
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_FloatPer("FloatPer",Float) = 0.0
		_Radios("Radios",Float)=0.0  
	}
	SubShader 
	{
		Tags{"Queue" = "Transparent" "RenderType"="Transparent"}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			uniform sampler2D _MainTex;
			uniform float _FloatPer; 
			uniform float _Radios; 
			float4 _MainTex_ST;
			struct v2f   
			{   
				float4 pos : SV_POSITION;   
				half2 uv : TEXCOORD0;   
			};   
			
			v2f vert (appdata_base v)   
			{   
				v2f o;   
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);   
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);   
				return o; 
			}
			
			half4 frag (v2f i) : COLOR
			{
				float retia;
				
				float dis=distance(i.uv,(0.5,0.5));
				dis=dis-_Radios;
				dis=clamp(dis,0,abs(dis));
				retia=dis/_Radios;
				half4 SourceColor = tex2D(_MainTex,i.uv);
				half ColorT = (SourceColor.x + SourceColor.y + SourceColor.z)/3; 
				
				half4 redBloodColor = half4(ColorT*1.5,0,0,SourceColor.w);
				if(_FloatPer==1)
				{
					return ColorT;
				}
				else
				{
					half4 dest=lerp(SourceColor,redBloodColor,_FloatPer*retia);
					return dest;
				}
			}
		ENDCG
		}
	} 
	FallBack "Diffuse"
}