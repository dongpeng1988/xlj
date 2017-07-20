// Simplified Additive Particle shader. Differences from regular Additive Particle one:
// - no Tint color
// - no Smooth particle support
// - no AlphaTest
// - no ColorMask

Shader "Android/Mobile/Particles/Additive" {
Properties {
	_MainTex ("Particle Texture", 2D) = "white" {}
	_AlphaTex ("Base (RGB)", 2D) = "black" {}
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha One
	Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }
	
	BindChannels {
		Bind "Color", color
		Bind "Vertex", vertex
		Bind "TexCoord", texcoord
	}
	
	SubShader {
		Pass {
			SetTexture [_AlphaTex] {
				combine texture
			}
			SetTexture [_MainTex] {
				combine texture, previous alpha
			}
		}
	}
}
}