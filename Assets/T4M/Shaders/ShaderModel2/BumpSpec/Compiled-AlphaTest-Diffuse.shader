// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 477.3KB

// Skipping shader variants that would not be included into build of current scene.

Shader "Legacy Shaders/Mobile/Diffuse" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
 _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }


 // Stats for Vertex shader:
 //       d3d11 : 46 avg math (34..58)
 //    d3d11_9x : 48 avg math (34..63)
 //        d3d9 : 44 avg math (27..62)
 //      opengl : 10 avg math (9..12), 2 avg texture (2..3), 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 10 avg math (8..12), 1 avg texture (1..2)
 //    d3d11_9x : 10 avg math (8..13), 1 texture
 //        d3d9 : 11 avg math (9..13), 2 avg texture (2..3)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ColorMask RGB
  GpuProgramID 2513
Program "vp" {
SubProgram "opengl " {
// Stats: 9 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  vec3 x2_6;
  vec3 x1_7;
  x1_7.x = dot (unity_SHAr, tmpvar_5);
  x1_7.y = dot (unity_SHAg, tmpvar_5);
  x1_7.z = dot (unity_SHAb, tmpvar_5);
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_4.xyzz * tmpvar_4.yzzx);
  x2_6.x = dot (unity_SHBr, tmpvar_8);
  x2_6.y = dot (unity_SHBg, tmpvar_8);
  x2_6.z = dot (unity_SHBb, tmpvar_8);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_6 + (unity_SHC.xyz * 
    ((tmpvar_4.x * tmpvar_4.x) - (tmpvar_4.y * tmpvar_4.y))
  )) + x1_7);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = tmpvar_1.w;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_1.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 27 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_MainTex_ST]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c18, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c18.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2

"
}
SubProgram "d3d11 " {
// Stats: 34 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedakapadpdmanfnenmgkhidcfnfefdajfgabaaaaaaaaahaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcdeafaaaaeaaaabaaenabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 34 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedgogjlhljcdhcgppegfkfgmnohkpfbejjabaaaaaaaaakaaaaaeaaaaaa
daaaaaaacmadaaaagiaiaaaagaajaaaaebgpgodjpeacaaaapeacaaaaaaacpopp
jmacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaakaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaafaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
acaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabbaaaaka
afaaaaadaaaaaciaacaaaajabcaaaakaafaaaaadaaaaaeiaacaaaajabdaaaaka
afaaaaadabaaabiaacaaffjabbaaffkaafaaaaadabaaaciaacaaffjabcaaffka
afaaaaadabaaaeiaacaaffjabdaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabbaakkkaafaaaaadabaaaciaacaakkjabcaakkka
afaaaaadabaaaeiaacaakkjabdaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeia
ajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabeaaaakaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
abaaaaacabaaahoaabaaoeiaacaaaaadadaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcdeafaaaaeaaaabaaenabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
// Stats: 10 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  vec4 o_10;
  vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_1 * 0.5);
  vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
  xlv_TEXCOORD4 = o_10;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_1.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = tmpvar_1.w;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_1.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 33 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 19 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c20, 1, 0.5, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c19, c19.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c15, r2
dp4 r3.y, c16, r2
dp4 r3.z, c17, r2
mad r0.xyz, c18, r0.x, r3
mov r1.w, c20.x
dp4 r2.x, c12, r1
dp4 r2.y, c13, r1
dp4 r2.z, c14, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c20.y
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c20.y
mad oT4.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
// Stats: 37 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfhflkpphjkjicdlggklcdahphdhfjlnbabaaaaaamaahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
nmafaaaaeaaaabaahhabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaacaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaa
cjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaa
ckaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaa
claaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
cmaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
// Stats: 9 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10 = (unity_4LightPosX0 - tmpvar_1.x);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosY0 - tmpvar_1.y);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosZ0 - tmpvar_1.z);
  vec4 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * tmpvar_10) + (tmpvar_11 * tmpvar_11)) + (tmpvar_12 * tmpvar_12));
  vec4 tmpvar_14;
  tmpvar_14 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_10 * tmpvar_5.x) + (tmpvar_11 * tmpvar_5.y)) + (tmpvar_12 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_13)
  )) * (1.0/((1.0 + 
    (tmpvar_13 * unity_4LightAtten0)
  ))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = (((x2_7 + 
    (unity_SHC.xyz * ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y)))
  ) + x1_8) + ((
    ((unity_LightColor[0].xyz * tmpvar_14.x) + (unity_LightColor[1].xyz * tmpvar_14.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_14.z)
  ) + (unity_LightColor[3].xyz * tmpvar_14.w)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = tmpvar_1.w;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_1.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 55 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 25 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHAb]
Vector 19 [unity_SHAg]
Vector 18 [unity_SHAr]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_2_0
def c26, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.z, c6, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v2, c25, c25.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c21, r2
dp4 r3.y, c22, r2
dp4 r3.z, c23, r2
mad r0.xyz, c24, r0.x, r3
mov r1.w, c26.x
dp4 r2.x, c18, r1
dp4 r2.y, c19, r1
dp4 r2.z, c20, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c15
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c14
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c16
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c26.x
mad r1, r1, c17, r4.x
mul r2, r2, r3
max r2, r2, c26.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1

"
}
SubProgram "d3d11 " {
// Stats: 54 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedpmolknpndohdblooagkaahhoilffpcepabaaaaaammajaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaaaiaaaaeaaaabaaaaacaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaia
ebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaa
fgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaia
ebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 54 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedcdnnfgiaokmbpjnffacbipeleadebhjgabaaaaaajaaoaaaaaeaaaaaa
daaaaaaapaaeaaaapiamaaaapaanaaaaebgpgodjliaeaaaaliaeaaaaaaacpopp
feaeaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaakaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaaaaaeaabbaaaaaaaaaaacaaamaaahaabfaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbmaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaabiaacaaaajabjaaaaka
afaaaaadaaaaaciaacaaaajabkaaaakaafaaaaadaaaaaeiaacaaaajablaaaaka
afaaaaadabaaabiaacaaffjabjaaffkaafaaaaadabaaaciaacaaffjabkaaffka
afaaaaadabaaaeiaacaaffjablaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabjaakkkaafaaaaadabaaaciaacaakkjabkaakkka
afaaaaadabaaaeiaacaakkjablaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaanaaoekaacaaoeiaajaaaaadadaaaciaaoaaoekaacaaoeia
ajaaaaadadaaaeiaapaaoekaacaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabmaaaakaajaaaaadacaaabiaakaaoekaabaaoeia
ajaaaaadacaaaciaalaaoekaabaaoeiaajaaaaadacaaaeiaamaaoekaabaaoeia
acaaaaadaaaaahiaaaaaoeiaacaaoeiaafaaaaadacaaahiaaaaaffjabgaaoeka
aeaaaaaeacaaahiabfaaoekaaaaaaajaacaaoeiaaeaaaaaeacaaahiabhaaoeka
aaaakkjaacaaoeiaaeaaaaaeacaaahiabiaaoekaaaaappjaacaaoeiaacaaaaad
adaaapiaacaaffibadaaoekaafaaaaadaeaaapiaabaaffiaadaaoeiaafaaaaad
adaaapiaadaaoeiaadaaoeiaacaaaaadafaaapiaacaaaaibacaaoekaaeaaaaae
aeaaapiaafaaoeiaabaaaaiaaeaaoeiaaeaaaaaeadaaapiaafaaoeiaafaaoeia
adaaoeiaacaaaaadafaaapiaacaakkibaeaaoekaabaaaaacacaaahoaacaaoeia
aeaaaaaeacaaapiaafaaoeiaabaakkiaaeaaoeiaabaaaaacabaaahoaabaaoeia
aeaaaaaeabaaapiaafaaoeiaafaaoeiaadaaoeiaahaaaaacadaaabiaabaaaaia
ahaaaaacadaaaciaabaaffiaahaaaaacadaaaeiaabaakkiaahaaaaacadaaaiia
abaappiaabaaaaacaeaaabiabmaaaakaaeaaaaaeabaaapiaabaaoeiaafaaoeka
aeaaaaiaafaaaaadacaaapiaacaaoeiaadaaoeiaalaaaaadacaaapiaacaaoeia
bmaaffkaagaaaaacadaaabiaabaaaaiaagaaaaacadaaaciaabaaffiaagaaaaac
adaaaeiaabaakkiaagaaaaacadaaaiiaabaappiaafaaaaadabaaapiaacaaoeia
adaaoeiaafaaaaadacaaahiaabaaffiaahaaoekaaeaaaaaeacaaahiaagaaoeka
abaaaaiaacaaoeiaaeaaaaaeabaaahiaaiaaoekaabaakkiaacaaoeiaaeaaaaae
abaaahiaajaaoekaabaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeia
afaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
beaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcaaaiaaaaeaaaabaaaaacaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaadaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaa
diaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaa
afaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaaj
pcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaa
abaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
nbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
oaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 10 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  vec3 x2_8;
  vec3 x1_9;
  x1_9.x = dot (unity_SHAr, tmpvar_7);
  x1_9.y = dot (unity_SHAg, tmpvar_7);
  x1_9.z = dot (unity_SHAb, tmpvar_7);
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_10);
  x2_8.y = dot (unity_SHBg, tmpvar_10);
  x2_8.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_6.x) + (tmpvar_12 * tmpvar_6.y)) + (tmpvar_13 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_1 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (((x2_8 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_9) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD4 = o_16;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_1.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = tmpvar_1.w;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_1.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 61 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 27 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 22 [unity_SHAb]
Vector 21 [unity_SHAg]
Vector 20 [unity_SHAr]
Vector 25 [unity_SHBb]
Vector 24 [unity_SHBg]
Vector 23 [unity_SHBr]
Vector 26 [unity_SHC]
"vs_2_0
def c28, 1, 0, 0.5, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c27, c27.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c23, r2
dp4 r3.y, c24, r2
dp4 r3.z, c25, r2
mad r0.xyz, c26, r0.x, r3
mov r1.w, c28.x
dp4 r2.x, c20, r1
dp4 r2.y, c21, r1
dp4 r2.z, c22, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c17
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c16
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c18
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c28.x
mad r1, r1, c19, r4.x
mul r2, r2, r3
max r2, r2, c28.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c14.x
mul r1.w, r1.x, c28.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c28.z
mad oT4.xy, r1.z, c15.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
// Stats: 57 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedoibkpebdjoelmaknhadkadmicdidbcmbabaaaaaaimakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
kiaiaaaaeaaaabaackacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
ahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
icaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaacaaaaaa
egacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaajpcaabaaa
aeaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
pcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaa
agaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
acaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaacaaaaaakgakbaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaacaaaaaa
dcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 42 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefieceddldgljdelcmodipccgjklbfadfnhlceiabaaaaaaaiamaaaaaeaaaaaa
daaaaaaanaadaaaafiakaaaafaalaaaaebgpgodjjiadaaaajiadaaaaaaacpopp
deadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaakaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaiaaaeaaajaaaaaaaaaa
adaaaaaaaeaaanaaaaaaaaaaadaaamaaahaabbaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbiaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjabcaaoeka
aeaaaaaeaaaaahiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkjaaaaaoeiaaeaaaaaeacaaahoabeaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaabiaacaaaajabfaaaakaafaaaaadaaaaaciaacaaaajabgaaaakaafaaaaad
aaaaaeiaacaaaajabhaaaakaafaaaaadabaaabiaacaaffjabfaaffkaafaaaaad
abaaaciaacaaffjabgaaffkaafaaaaadabaaaeiaacaaffjabhaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabfaakkkaafaaaaad
abaaaciaacaakkjabgaakkkaafaaaaadabaaaeiaacaakkjabhaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaad
adaaaciaagaaoekaacaaoeiaajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabiaaaakaajaaaaad
acaaabiaacaaoekaabaaoeiaajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaad
acaaaeiaaeaaoekaabaaoeiaabaaaaacabaaahoaabaaoeiaacaaaaadadaaahoa
aaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaaeaaaaapia
bbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaadabaaapiaaaaaffia
akaaoekaaeaaaaaeabaaapiaajaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapia
alaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoaamaaoekaaaaappiaabaaoeia
afaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
baaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefciaagaaaaeaaaabaakaabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaajaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaakaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaacaaaaaa
alaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheopaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
nbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
oaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
// Stats: 62 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedbioijpljplhldlaobefghoggffjgfmibabaaaaaajibaaaaaaeaaaaaa
daaaaaaajeafaaaaoiaoaaaaoaapaaaaebgpgodjfmafaaaafmafaaaaaaacpopp
omaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaakaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaiaaaeaabbaaaaaaaaaaadaaaaaaaeaabfaaaaaaaaaaadaaamaaahaabjaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafcaaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaacaaaajabnaaaakaafaaaaadaaaaaciaacaaaajaboaaaakaafaaaaad
aaaaaeiaacaaaajabpaaaakaafaaaaadabaaabiaacaaffjabnaaffkaafaaaaad
abaaaciaacaaffjaboaaffkaafaaaaadabaaaeiaacaaffjabpaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabnaakkkaafaaaaad
abaaaciaacaakkjaboaakkkaafaaaaadabaaaeiaacaakkjabpaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaanaaoekaacaaoeiaajaaaaad
adaaaciaaoaaoekaacaaoeiaajaaaaadadaaaeiaapaaoekaacaaoeiaaeaaaaae
aaaaahiabaaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiacaaaaakaajaaaaad
acaaabiaakaaoekaabaaoeiaajaaaaadacaaaciaalaaoekaabaaoeiaajaaaaad
acaaaeiaamaaoekaabaaoeiaacaaaaadaaaaahiaaaaaoeiaacaaoeiaafaaaaad
acaaahiaaaaaffjabkaaoekaaeaaaaaeacaaahiabjaaoekaaaaaaajaacaaoeia
aeaaaaaeacaaahiablaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaahiabmaaoeka
aaaappjaacaaoeiaacaaaaadadaaapiaacaaffibadaaoekaafaaaaadaeaaapia
abaaffiaadaaoeiaafaaaaadadaaapiaadaaoeiaadaaoeiaacaaaaadafaaapia
acaaaaibacaaoekaaeaaaaaeaeaaapiaafaaoeiaabaaaaiaaeaaoeiaaeaaaaae
adaaapiaafaaoeiaafaaoeiaadaaoeiaacaaaaadafaaapiaacaakkibaeaaoeka
abaaaaacacaaahoaacaaoeiaaeaaaaaeacaaapiaafaaoeiaabaakkiaaeaaoeia
abaaaaacabaaahoaabaaoeiaaeaaaaaeabaaapiaafaaoeiaafaaoeiaadaaoeia
ahaaaaacadaaabiaabaaaaiaahaaaaacadaaaciaabaaffiaahaaaaacadaaaeia
abaakkiaahaaaaacadaaaiiaabaappiaabaaaaacaeaaabiacaaaaakaaeaaaaae
abaaapiaabaaoeiaafaaoekaaeaaaaiaafaaaaadacaaapiaacaaoeiaadaaoeia
alaaaaadacaaapiaacaaoeiacaaaffkaagaaaaacadaaabiaabaaaaiaagaaaaac
adaaaciaabaaffiaagaaaaacadaaaeiaabaakkiaagaaaaacadaaaiiaabaappia
afaaaaadabaaapiaacaaoeiaadaaoeiaafaaaaadacaaahiaabaaffiaahaaoeka
aeaaaaaeacaaahiaagaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaahiaaiaaoeka
abaakkiaacaaoeiaaeaaaaaeabaaahiaajaaoekaabaappiaabaaoeiaacaaaaad
adaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabkaaoekaaeaaaaae
aaaaapiabjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiablaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabmaaoekaaaaappjaaaaaoeiaafaaaaadabaaapia
aaaaffiabcaaoekaaeaaaaaeabaaapiabbaaoekaaaaaaaiaabaaoeiaaeaaaaae
abaaapiabdaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoabeaaoekaaaaappia
abaaoeiaafaaaaadaaaaapiaaaaaffjabgaaoekaaeaaaaaeaaaaapiabfaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiabiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcemajaaaaeaaaabaa
fdacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaadaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaa
diaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaa
afaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaaj
pcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaa
abaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaacaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
aiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaafaaaaaaegiocaaaacaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 11 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2.w;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_4.w;
  c_1.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 29 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_MainTex_ST]
Vector 17 [unity_FogParams]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c19, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c18, c18.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c19.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2
dp4 r0.x, c2, v0
mad oT5.x, r0.x, c17.z, c17.w
mov oPos.z, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 35 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefiecedieilkkepfgidcbpjihhgjmhlimhfghgeabaaaaaaheahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
jaafaaaaeaaaabaageabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaae
egiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaadaaaaaaabaaaaaadkiacaaaadaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaa
aaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 35 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefiecedackpmhkinimknplkfgmdgmgjnianenfmabaaaaaajeakaaaaaeaaaaaa
daaaaaaaemadaaaaoeaiaaaanmajaaaaebgpgodjbeadaaaabeadaaaaaaacpopp
laacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaakaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaadaaabaaabaabeaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaaoaaoeka
aeaaaaaeaaaaahiaanaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoeka
aaaakkjaaaaaoeiaaeaaaaaeacaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaabiaacaaaajabbaaaakaafaaaaadaaaaaciaacaaaajabcaaaakaafaaaaad
aaaaaeiaacaaaajabdaaaakaafaaaaadabaaabiaacaaffjabbaaffkaafaaaaad
abaaaciaacaaffjabcaaffkaafaaaaadabaaaeiaacaaffjabdaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabbaakkkaafaaaaad
abaaaciaacaakkjabcaakkkaafaaaaadabaaaeiaacaakkjabdaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaad
adaaaciaagaaoekaacaaoeiaajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabfaaaakaajaaaaad
acaaabiaacaaoekaabaaoeiaajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaad
acaaaeiaaeaaoekaabaaoeiaabaaaaacabaaahoaabaaoeiaacaaaaadadaaahoa
aaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapia
ajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaaeoaaaaakkia
beaakkkabeaappkaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcjaafaaaaeaaaabaageabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaleccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaadaaaaaaabaaaaaa
dkiacaaaadaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaa
aaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaa
afaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 12 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  vec4 o_10;
  vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_1 * 0.5);
  vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
  xlv_TEXCOORD4 = o_10;
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2.w;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_4.w;
  c_1.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 34 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 19 [unity_FogParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c21, 1, 0.5, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c20, c20.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c15, r2
dp4 r3.y, c16, r2
dp4 r3.z, c17, r2
mad r0.xyz, c18, r0.x, r3
mov r1.w, c21.x
dp4 r2.x, c12, r1
dp4 r2.y, c13, r1
dp4 r2.z, c14, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c21.y
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.y
mad oT4.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mad oT5.x, r0.z, c19.z, c19.w
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
// Stats: 38 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecedieeojgncpbfhapbbofokdihidioilphfabaaaaaacaaiaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcceagaaaaeaaaabaa
ijabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaaeaaaaaaabaaaaaadkiacaaaaeaaaaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaacaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaa
cjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaa
ckaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaa
claaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
cmaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
// Stats: 11 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  vec3 x2_8;
  vec3 x1_9;
  x1_9.x = dot (unity_SHAr, tmpvar_7);
  x1_9.y = dot (unity_SHAg, tmpvar_7);
  x1_9.z = dot (unity_SHAb, tmpvar_7);
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_10);
  x2_8.y = dot (unity_SHBg, tmpvar_10);
  x2_8.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_6.x) + (tmpvar_12 * tmpvar_6.y)) + (tmpvar_13 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (((x2_8 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_9) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2.w;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_4.w;
  c_1.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 57 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 26 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 25 [unity_FogParams]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHAb]
Vector 19 [unity_SHAg]
Vector 18 [unity_SHAr]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_2_0
def c27, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v2, c26, c26.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c21, r2
dp4 r3.y, c22, r2
dp4 r3.z, c23, r2
mad r0.xyz, c24, r0.x, r3
mov r1.w, c27.x
dp4 r2.x, c18, r1
dp4 r2.y, c19, r1
dp4 r2.z, c20, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c15
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c14
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c16
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c27.x
mad r1, r1, c17, r4.x
mul r2, r2, r3
max r2, r2, c27.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1
dp4 r0.x, c6, v0
mad oT5.x, r0.x, c25.z, c25.w
mov oPos.z, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 55 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefieceddgpbmbbecabmpcbmeocbppemjaieljaaabaaaaaaeaakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmaiaaaaeaaaabaabhacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaae
egiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaadaaaaaaabaaaaaadkiacaaaadaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaa
aaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaa
cmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaa
abaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
aaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaabaaaaaa
acaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaa
abaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaa
aaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaa
kgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaa
afaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
adaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
abaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 55 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefiecedocbdhfpfkjbppbhoinbdkdebglmkhbkaabaaaaaaceapaaaaaeaaaaaa
daaaaaaabaafaaaaheanaaaagmaoaaaaebgpgodjniaeaaaaniaeaaaaaaacpopp
giaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaakaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaaaaaeaabbaaaaaaaaaaacaaamaaahaabfaaaaaaaaaaadaaabaaabaabmaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbnaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaacaaaajabjaaaakaafaaaaadaaaaaciaacaaaajabkaaaakaafaaaaad
aaaaaeiaacaaaajablaaaakaafaaaaadabaaabiaacaaffjabjaaffkaafaaaaad
abaaaciaacaaffjabkaaffkaafaaaaadabaaaeiaacaaffjablaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabjaakkkaafaaaaad
abaaaciaacaakkjabkaakkkaafaaaaadabaaaeiaacaakkjablaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaanaaoekaacaaoeiaajaaaaad
adaaaciaaoaaoekaacaaoeiaajaaaaadadaaaeiaapaaoekaacaaoeiaaeaaaaae
aaaaahiabaaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabnaaaakaajaaaaad
acaaabiaakaaoekaabaaoeiaajaaaaadacaaaciaalaaoekaabaaoeiaajaaaaad
acaaaeiaamaaoekaabaaoeiaacaaaaadaaaaahiaaaaaoeiaacaaoeiaafaaaaad
acaaahiaaaaaffjabgaaoekaaeaaaaaeacaaahiabfaaoekaaaaaaajaacaaoeia
aeaaaaaeacaaahiabhaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaahiabiaaoeka
aaaappjaacaaoeiaacaaaaadadaaapiaacaaffibadaaoekaafaaaaadaeaaapia
abaaffiaadaaoeiaafaaaaadadaaapiaadaaoeiaadaaoeiaacaaaaadafaaapia
acaaaaibacaaoekaaeaaaaaeaeaaapiaafaaoeiaabaaaaiaaeaaoeiaaeaaaaae
adaaapiaafaaoeiaafaaoeiaadaaoeiaacaaaaadafaaapiaacaakkibaeaaoeka
abaaaaacacaaahoaacaaoeiaaeaaaaaeacaaapiaafaaoeiaabaakkiaaeaaoeia
abaaaaacabaaahoaabaaoeiaaeaaaaaeabaaapiaafaaoeiaafaaoeiaadaaoeia
ahaaaaacadaaabiaabaaaaiaahaaaaacadaaaciaabaaffiaahaaaaacadaaaeia
abaakkiaahaaaaacadaaaiiaabaappiaabaaaaacaeaaabiabnaaaakaaeaaaaae
abaaapiaabaaoeiaafaaoekaaeaaaaiaafaaaaadacaaapiaacaaoeiaadaaoeia
alaaaaadacaaapiaacaaoeiabnaaffkaagaaaaacadaaabiaabaaaaiaagaaaaac
adaaaciaabaaffiaagaaaaacadaaaeiaabaakkiaagaaaaacadaaaiiaabaappia
afaaaaadabaaapiaacaaoeiaadaaoeiaafaaaaadacaaahiaabaaffiaahaaoeka
aeaaaaaeacaaahiaagaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaahiaaiaaoeka
abaakkiaacaaoeiaaeaaaaaeabaaahiaajaaoekaabaappiaabaaoeiaacaaaaad
adaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaae
aaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaaeoa
aaaakkiabmaakkkabmaappkaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcfmaiaaaaeaaaabaabhacaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaadaaaaaa
abaaaaaadkiacaaaadaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
icaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaadaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaa
adaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaah
pcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaa
agaabaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaa
abaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaa
egaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaabaaaaaa
dcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
ajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaa
acaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aealaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
// Stats: 12 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  vec3 x2_8;
  vec3 x1_9;
  x1_9.x = dot (unity_SHAr, tmpvar_7);
  x1_9.y = dot (unity_SHAg, tmpvar_7);
  x1_9.z = dot (unity_SHAb, tmpvar_7);
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_10);
  x2_8.y = dot (unity_SHBg, tmpvar_10);
  x2_8.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_6.x) + (tmpvar_12 * tmpvar_6.y)) + (tmpvar_13 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_1 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (((x2_8 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_9) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD4 = o_16;
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2.w;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_4.w;
  c_1.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 62 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 28 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 27 [unity_FogParams]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 22 [unity_SHAb]
Vector 21 [unity_SHAg]
Vector 20 [unity_SHAr]
Vector 25 [unity_SHBb]
Vector 24 [unity_SHBg]
Vector 23 [unity_SHBr]
Vector 26 [unity_SHC]
"vs_2_0
def c29, 1, 0, 0.5, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c28, c28.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c23, r2
dp4 r3.y, c24, r2
dp4 r3.z, c25, r2
mad r0.xyz, c26, r0.x, r3
mov r1.w, c29.x
dp4 r2.x, c20, r1
dp4 r2.y, c21, r1
dp4 r2.z, c22, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c17
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c16
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c18
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c29.x
mad r1, r1, c19, r4.x
mul r2, r2, r3
max r2, r2, c29.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c14.x
mul r1.w, r1.x, c29.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c29.z
mad oT4.xy, r1.z, c15.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mad oT5.x, r0.z, c27.z, c27.w
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
// Stats: 58 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefieceddbkolcdpfdgchicpoapmnpikfpnechmiabaaaaaaomakaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpaaiaaaaeaaaabaa
dmacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaaeaaaaaaabaaaaaadkiacaaaaeaaaaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
icaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaacaaaaaa
egacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaajpcaabaaa
aeaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
pcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaa
agaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
acaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaacaaaaaakgakbaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaacaaaaaa
dcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 43 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedocdjnnfbemlelhekpbdbjopdcnofbchfabaaaaaajmamaaaaaeaaaaaa
daaaaaaapaadaaaaneakaaaammalaaaaebgpgodjliadaaaaliadaaaaaaacpopp
eiadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaakaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaiaaaeaaajaaaaaaaaaa
adaaaaaaaeaaanaaaaaaaaaaadaaamaaahaabbaaaaaaaaaaaeaaabaaabaabiaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbjaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaahiaaaaaffjabcaaoekaaeaaaaaeaaaaahiabbaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabdaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoabeaaoeka
aaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabfaaaakaafaaaaadaaaaacia
acaaaajabgaaaakaafaaaaadaaaaaeiaacaaaajabhaaaakaafaaaaadabaaabia
acaaffjabfaaffkaafaaaaadabaaaciaacaaffjabgaaffkaafaaaaadabaaaeia
acaaffjabhaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
acaakkjabfaakkkaafaaaaadabaaaciaacaakkjabgaakkkaafaaaaadabaaaeia
acaakkjabhaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaia
abaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeiaajaaaaadadaaabia
afaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeiaajaaaaadadaaaeia
ahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaac
abaaaiiabjaaaakaajaaaaadacaaabiaacaaoekaabaaoeiaajaaaaadacaaacia
adaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeiaabaaaaacabaaahoa
abaaoeiaacaaaaadadaaahoaaaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffja
bcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeia
afaaaaadabaaapiaaaaaffiaakaaoekaaeaaaaaeabaaapiaajaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiaalaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoa
amaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaae
aaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaaeoa
aaaakkiabiaakkkabiaappkaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcnmagaaaaeaaaabaalhabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaleccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaaeaaaaaaabaaaaaa
dkiacaaaaeaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaa
aaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaajaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaacaaaaaaalaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaa
acaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
// Stats: 63 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedpnnelpkheeioljejnedglgjfmjfhlpknabaaaaaacmbbaaaaaeaaaaaa
daaaaaaaleafaaaageapaaaafmbaaaaaebgpgodjhmafaaaahmafaaaaaaacpopp
aaafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaakaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaiaaaeaabbaaaaaaaaaaadaaaaaaaeaabfaaaaaaaaaaadaaamaaahaabjaa
aaaaaaaaaeaaabaaabaacaaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcbaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaacaaaajabnaaaakaafaaaaadaaaaacia
acaaaajaboaaaakaafaaaaadaaaaaeiaacaaaajabpaaaakaafaaaaadabaaabia
acaaffjabnaaffkaafaaaaadabaaaciaacaaffjaboaaffkaafaaaaadabaaaeia
acaaffjabpaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
acaakkjabnaakkkaafaaaaadabaaaciaacaakkjaboaakkkaafaaaaadabaaaeia
acaakkjabpaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaia
abaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeiaajaaaaadadaaabia
anaaoekaacaaoeiaajaaaaadadaaaciaaoaaoekaacaaoeiaajaaaaadadaaaeia
apaaoekaacaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaaaaiaadaaoeiaabaaaaac
abaaaiiacbaaaakaajaaaaadacaaabiaakaaoekaabaaoeiaajaaaaadacaaacia
alaaoekaabaaoeiaajaaaaadacaaaeiaamaaoekaabaaoeiaacaaaaadaaaaahia
aaaaoeiaacaaoeiaafaaaaadacaaahiaaaaaffjabkaaoekaaeaaaaaeacaaahia
bjaaoekaaaaaaajaacaaoeiaaeaaaaaeacaaahiablaaoekaaaaakkjaacaaoeia
aeaaaaaeacaaahiabmaaoekaaaaappjaacaaoeiaacaaaaadadaaapiaacaaffib
adaaoekaafaaaaadaeaaapiaabaaffiaadaaoeiaafaaaaadadaaapiaadaaoeia
adaaoeiaacaaaaadafaaapiaacaaaaibacaaoekaaeaaaaaeaeaaapiaafaaoeia
abaaaaiaaeaaoeiaaeaaaaaeadaaapiaafaaoeiaafaaoeiaadaaoeiaacaaaaad
afaaapiaacaakkibaeaaoekaabaaaaacacaaahoaacaaoeiaaeaaaaaeacaaapia
afaaoeiaabaakkiaaeaaoeiaabaaaaacabaaahoaabaaoeiaaeaaaaaeabaaapia
afaaoeiaafaaoeiaadaaoeiaahaaaaacadaaabiaabaaaaiaahaaaaacadaaacia
abaaffiaahaaaaacadaaaeiaabaakkiaahaaaaacadaaaiiaabaappiaabaaaaac
aeaaabiacbaaaakaaeaaaaaeabaaapiaabaaoeiaafaaoekaaeaaaaiaafaaaaad
acaaapiaacaaoeiaadaaoeiaalaaaaadacaaapiaacaaoeiacbaaffkaagaaaaac
adaaabiaabaaaaiaagaaaaacadaaaciaabaaffiaagaaaaacadaaaeiaabaakkia
agaaaaacadaaaiiaabaappiaafaaaaadabaaapiaacaaoeiaadaaoeiaafaaaaad
acaaahiaabaaffiaahaaoekaaeaaaaaeacaaahiaagaaoekaabaaaaiaacaaoeia
aeaaaaaeabaaahiaaiaaoekaabaakkiaacaaoeiaaeaaaaaeabaaahiaajaaoeka
abaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaffjabkaaoekaaeaaaaaeaaaaapiabjaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiablaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabmaaoekaaaaappja
aaaaoeiaafaaaaadabaaapiaaaaaffiabcaaoekaaeaaaaaeabaaapiabbaaoeka
aaaaaaiaabaaoeiaaeaaaaaeabaaapiabdaaoekaaaaakkiaabaaoeiaaeaaaaae
aeaaapoabeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjabgaaoeka
aeaaaaaeaaaaapiabfaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabhaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabiaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaaeoaaaaakkiacaaakkkacaaappkaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefckiajaaaaeaaaabaa
gkacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaaeaaaaaa
abaaaaaadkiacaaaaeaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
diaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
icaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaadaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaa
adaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaah
pcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaa
agaabaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaa
abaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaa
egaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaabaaaaaa
dcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
ajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
acaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaiaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
afaaaaaaegiocaaaacaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 9 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 2 [_Color]
Float 3 [_Cutoff]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c4, 0, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl_2d s0
texld r0, t0, s0
mov r1.w, c2.w
mad_pp r1, r0.w, r1.w, -c3.x
mul_pp r0, r0, c2
texkill r1
dp3_pp r1.x, t1, c0
max_pp r2.w, r1.x, c4.x
mul_pp r1.xyz, r0, c1
mul_pp r2.xyz, r0, t3
mad_pp r0.xyz, r1, r2.w, r2
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 8 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedokidkenbjeijdnfngffjagjmdbmjabdgabaaaaaaneacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmmabaaaaeaaaaaaahdaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaaibcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
deaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaai
ocaabaaaabaaaaaaagajbaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 8 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedkgfogdfplpkpglbjebjegchedefmkmneabaaaaaadaaeaaaaaeaaaaaa
daaaaaaaiiabaaaafmadaaaapmadaaaaebgpgodjfaabaaaafaabaaaaaaacpppp
piaaaaaafiaaaaaaaeaaciaaaaaafiaaaaaafiaaabaaceaaaaaafiaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaaaaaalaaabaaacaa
aaaaaaaaabaaaaaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkaecaaaaad
aaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpia
aaaappiaabaappiaacaaaakbafaaaaadaaaacpiaaaaaoeiaabaaoekaebaaaaab
abaaapiaaiaaaaadabaacbiaabaaoelaadaaoekaalaaaaadacaaciiaabaaaaia
aeaaaakaafaaaaadabaachiaaaaaoeiaaaaaoekaafaaaaadacaachiaaaaaoeia
adaaoelaaeaaaaaeaaaachiaabaaoeiaacaappiaacaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcmmabaaaaeaaaaaaahdaaaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaaibcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaa
abaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaaaaaaaaaaagijcaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaa
jgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 10 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 2 [_Color]
Float 3 [_Cutoff]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c4, 0, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl_pp t4
dcl_2d s0
dcl_2d s1
texld r0, t0, s1
mov r1.w, c2.w
mad_pp r1, r0.w, r1.w, -c3.x
mul_pp r0, r0, c2
texkill r1
texldp_pp r1, t4, s0
dp3_pp r1.y, t1, c0
max_pp r2.w, r1.y, c4.x
mul_pp r1.xyz, r1.x, c1
mul_pp r1.xyz, r0, r1
mul_pp r2.xyz, r0, t3
mad_pp r0.xyz, r1, r2.w, r2
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 10 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedcifmekkoeaaknmegfcpgiegokknimhhmabaaaaaahaadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaacaaaa
eaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaai
icaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 11 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0_level_9_1
eefiecedkncjdoadlcldcpeafjfaaeaapnamcoihabaaaaaajaafaaaaafaaaaaa
deaaaaaapeabaaaajeaeaaaakeaeaaaafmafaaaaebgpgodjliabaaaaliabaaaa
aaacppppfaabaaaagiaaaaaaafaacmaaaaaagiaaaaaagiaaacaaceaaaaaagiaa
apapaaaaaaaaabaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaa
aaaaalaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaabiaaabaaaeaa
aaaaaaaaaaacppppfbaaaaafafaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaabaioekaabaaaaacabaaaiia
abaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakbafaaaaadaaaacpia
aaaaoeiaabaaoekaebaaaaababaaapiaecaaaaadabaacpiaaeaaoelaaaaioeka
abaaaaacacaaaiiaafaaaakabcaaaaaeadaaciiaabaaaaiaacaappiaaeaaaaka
afaaaaadabaachiaadaappiaaaaaoekaafaaaaadabaachiaaaaaoeiaabaaoeia
aiaaaaadabaaciiaabaaoelaadaaoekaalaaaaadacaacbiaabaappiaafaaffka
afaaaaadacaacoiaaaaabliaadaabllaaeaaaaaeaaaachiaabaaoeiaacaaaaia
acaabliaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjiacaaaaeaaaaaaa
kgaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaapaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaa
alaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaehaaaaalbcaabaaaabaaaaaaegbabaaaafaaaaaa
aghabaaaapaaaaaaaagabaaaapaaaaaackbabaaaafaaaaaaaaaaaaajccaabaaa
abaaaaaaakiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaak
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaacaaaaaa
biaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaaiicaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabfdegejdaaiaaaaaaiaaaaaaa
aaaaaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 12 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Vector 3 [_Color]
Float 4 [_Cutoff]
Vector 2 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c5, 0, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl t5.x
dcl_2d s0
texld r0, t0, s0
mov r1.w, c3.w
mad_pp r1, r0.w, r1.w, -c4.x
mul_pp r0, r0, c3
texkill r1
dp3_pp r1.x, t1, c0
max_pp r2.w, r1.x, c5.x
mul_pp r1.xyz, r0, c2
mul_pp r2.xyz, r0, t3
mad_pp r1.xyz, r1, r2.w, r2
mov_sat r1.w, t5.x
lrp_pp r0.xyz, r1.w, r1, c1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 10 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedgakfpijanjdeicdmffjnadnbadfcdkaoabaaaaaagiadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiacaaaa
eaaaaaaajcaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaia
ebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaaibcaabaaaabaaaaaa
egbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaa
aaaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaak
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 10 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityFog" 2
"ps_4_0_level_9_1
eefiecedhjllnafdpkceinjelaiigkcieefhboipabaaaaaapaaeaaaaaeaaaaaa
daaaaaaaleabaaaaaeaeaaaalmaeaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
biabaaaageaaaaaaafaaciaaaaaageaaaaaageaaabaaceaaaaaageaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaaaaaalaaabaaacaa
aaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaaaaacpppp
fbaaaaafafaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaadaachlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiia
abaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakbafaaaaadaaaacpia
aaaaoeiaabaaoekaebaaaaababaaapiaaiaaaaadabaacbiaabaaoelaadaaoeka
alaaaaadacaaciiaabaaaaiaafaaaakaafaaaaadabaachiaaaaaoeiaaaaaoeka
afaaaaadacaachiaaaaaoeiaadaaoelaaeaaaaaeabaachiaabaaoeiaacaappia
acaaoeiaabaaaaacabaabiiaaaaakklabcaaaaaeaaaachiaabaappiaabaaoeia
aeaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefceiacaaaaeaaaaaaa
jcaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaa
aaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaaibcaabaaaabaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaaaaaaaaaa
agijcaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 13 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
Vector 3 [_Color]
Float 4 [_Cutoff]
Vector 2 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [unity_FogColor]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c5, 0, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl_pp t4
dcl t5.x
dcl_2d s0
dcl_2d s1
texld r0, t0, s1
mov r1.w, c3.w
mad_pp r1, r0.w, r1.w, -c4.x
mul_pp r0, r0, c3
texkill r1
texldp_pp r1, t4, s0
dp3_pp r1.y, t1, c0
max_pp r2.w, r1.y, c5.x
mul_pp r1.xyz, r1.x, c2
mul_pp r1.xyz, r0, r1
mul_pp r2.xyz, r0, t3
mad_pp r1.xyz, r1, r2.w, r2
mov_sat r1.w, t5.x
lrp_pp r0.xyz, r1.w, r1, c1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 12 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedfgceedcdabdogpmjahidkenfnbobfkliabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmacaaaaeaaaaaaaldaaaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaia
ebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
agaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaaiicaabaaaabaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 13 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityFog" 3
"ps_4_0_level_9_1
eefiecedkifjnhgbccbacikkgchajojnnnhoncmcabaaaaaafaagaaaaafaaaaaa
deaaaaaacaacaaaadmafaaaaemafaaaabmagaaaaebgpgodjoeabaaaaoeabaaaa
aaacpppphaabaaaaheaaaaaaagaacmaaaaaaheaaaaaaheaaacaaceaaaaaaheaa
apapaaaaaaaaabaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaa
aaaaalaaabaaacaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaabiaaabaaaeaa
aaaaaaaaadaaaaaaabaaafaaaaaaaaaaaaacppppfbaaaaafagaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaacplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoela
abaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappia
acaaaakbafaaaaadaaaacpiaaaaaoeiaabaaoekaebaaaaababaaapiaecaaaaad
abaacpiaaeaaoelaaaaioekaabaaaaacacaaaiiaagaaaakabcaaaaaeadaaciia
abaaaaiaacaappiaaeaaaakaafaaaaadabaachiaadaappiaaaaaoekaafaaaaad
abaachiaaaaaoeiaabaaoeiaaiaaaaadabaaciiaabaaoelaadaaoekaalaaaaad
acaacbiaabaappiaagaaffkaafaaaaadacaacoiaaaaabliaadaabllaaeaaaaae
abaachiaabaaoeiaacaaaaiaacaabliaabaaaaacabaabiiaaaaakklabcaaaaae
aaaachiaabaappiaabaaoeiaafaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcbeadaaaaeaaaaaaamfaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fjaaaaaeegiocaaaadaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaiaaad
aagabaaaapaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
apaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaia
ebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaehaaaaalbcaabaaaabaaaaaa
egbabaaaafaaaaaaaghabaaaapaaaaaaaagabaaaapaaaaaackbabaaaafaaaaaa
aaaaaaajccaabaaaabaaaaaaakiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaa
aaaaiadpdcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaacaaaaaabiaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaaiicaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaa
abaaaaaaaaaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaaeaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaaaaaaaaadgcaaaaf
icaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaaaaaaaaaadoaaaaabfdegejda
aiaaaaaaiaaaaaaaaaaaaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 23 avg math (23..24)
 //    d3d11_9x : 23 avg math (23..24)
 //        d3d9 : 15 avg math (14..16)
 //      opengl : 13 avg math (7..21), 3 avg texture (2..4), 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 15 avg math (7..24), 2 avg texture (1..3)
 //    d3d11_9x : 15 avg math (7..24), 2 avg texture (1..3)
 //        d3d9 : 17 avg math (8..26), 3 avg texture (2..4)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  Blend One One
  ColorMask RGB
  GpuProgramID 102844
Program "vp" {
SubProgram "opengl " {
// Stats: 13 math, 3 textures, 1 branches
Keywords { "POINT" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3).xyz;
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = ((tmpvar_1.xyz * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_4, tmpvar_4)
  )).w)) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_1.w;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednophaijpcjkhbcefiaooglnlhcpkdecaabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 23 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedhllkjadkodggoogckccnphpoodpampkgabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 7 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = tmpvar_1.w;
  c_3.w = c_4.w;
  c_3.xyz = c_4.xyz;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjkapaphijibjblghmlnlloipfbhfmpnpabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 23 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecednhmochkbpnefidoopnfiajlkpifdfhmcabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaakaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaa
ogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 19 math, 4 textures, 1 branches
Keywords { "SPOT" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3);
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = ((tmpvar_1.xyz * (_LightColor0.xyz * 
    ((float((tmpvar_4.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_4.xy / tmpvar_4.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_4.xyz, tmpvar_4.xyz))).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_1.w;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednophaijpcjkhbcefiaooglnlhcpkdecaabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 23 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedhllkjadkodggoogckccnphpoodpampkgabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 14 math, 4 textures, 1 branches
Keywords { "POINT_COOKIE" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3).xyz;
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = ((tmpvar_1.xyz * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_4, tmpvar_4))).w * textureCube (_LightTexture0, tmpvar_4).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_1.w;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednophaijpcjkhbcefiaooglnlhcpkdecaabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 23 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedhllkjadkodggoogckccnphpoodpampkgabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 10 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_1.xyz * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_3)
  .xy).w)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_1.w;
  c_4.w = c_5.w;
  c_4.xyz = c_5.xyz;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednophaijpcjkhbcefiaooglnlhcpkdecaabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 23 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedhllkjadkodggoogckccnphpoodpampkgabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 15 math, 3 textures, 1 branches
Keywords { "POINT" "FOG_LINEAR" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_5;
  tmpvar_5 = (_LightMatrix0 * tmpvar_4).xyz;
  vec4 c_6;
  vec4 c_7;
  c_7.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_5, tmpvar_5)
  )).w)) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_7.w = tmpvar_2.w;
  c_6.w = c_7.w;
  c_6.xyz = c_7.xyz;
  c_1.w = c_6.w;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_7.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "POINT" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mad oT4.x, r0.x, c10.z, c10.w
mov oPos.z, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "POINT" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedcffdmbgmodajpehbhhdbegcalbolekbiabaaaaaaleafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoiadaaaaeaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaa
apaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
eccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaa
acaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 24 math
Keywords { "POINT" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedchebmkecmdjminflakhpfiendomdaeepabaaaaaaaaaiaaaaaeaaaaaa
daaaaaaahiacaaaagiagaaaagaahaaaaebgpgodjeaacaaaaeaacaaaaaaacpopp
oiabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaaeoaaaaakkiaanaakkkaanaappkaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoiadaaaa
eaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaaacaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaa
aaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
// Stats: 9 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2.w;
  c_4.w = c_5.w;
  c_4.xyz = c_5.xyz;
  c_1.w = c_4.w;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_5.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mad oT4.x, r0.x, c10.z, c10.w
mov oPos.z, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedafnpjgiobocamlicjfdnhmphcdcfjlgoabaaaaaaleafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoiadaaaaeaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
eccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaa
acaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 24 math
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecednphgpgbioifokcgbfbfbnmlejephidpjabaaaaaaaaaiaaaaaeaaaaaa
daaaaaaahiacaaaagiagaaaagaahaaaaebgpgodjeaacaaaaeaacaaaaaaacpopp
oiabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaakaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaaeoaaaaakkiaanaakkkaanaappkaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoiadaaaa
eaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaaacaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaa
aaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
// Stats: 21 math, 4 textures, 1 branches
Keywords { "SPOT" "FOG_LINEAR" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_5;
  tmpvar_5 = (_LightMatrix0 * tmpvar_4);
  vec4 c_6;
  vec4 c_7;
  c_7.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * 
    ((float((tmpvar_5.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_5.xy / tmpvar_5.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_5.xyz, tmpvar_5.xyz))).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_7.w = tmpvar_2.w;
  c_6.w = c_7.w;
  c_6.xyz = c_7.xyz;
  c_1.w = c_6.w;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_7.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "SPOT" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mad oT4.x, r0.x, c10.z, c10.w
mov oPos.z, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "SPOT" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedcffdmbgmodajpehbhhdbegcalbolekbiabaaaaaaleafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoiadaaaaeaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaa
apaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
eccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaa
acaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 24 math
Keywords { "SPOT" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedchebmkecmdjminflakhpfiendomdaeepabaaaaaaaaaiaaaaaeaaaaaa
daaaaaaahiacaaaagiagaaaagaahaaaaebgpgodjeaacaaaaeaacaaaaaaacpopp
oiabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaaeoaaaaakkiaanaakkkaanaappkaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoiadaaaa
eaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaaacaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaa
aaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
// Stats: 16 math, 4 textures, 1 branches
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_5;
  tmpvar_5 = (_LightMatrix0 * tmpvar_4).xyz;
  vec4 c_6;
  vec4 c_7;
  c_7.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_5, tmpvar_5))).w * textureCube (_LightTexture0, tmpvar_5).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_7.w = tmpvar_2.w;
  c_6.w = c_7.w;
  c_6.xyz = c_7.xyz;
  c_1.w = c_6.w;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_7.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mad oT4.x, r0.x, c10.z, c10.w
mov oPos.z, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedcffdmbgmodajpehbhhdbegcalbolekbiabaaaaaaleafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoiadaaaaeaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaa
apaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
eccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaa
acaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 24 math
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedchebmkecmdjminflakhpfiendomdaeepabaaaaaaaaaiaaaaaeaaaaaa
daaaaaaahiacaaaagiagaaaagaahaaaaebgpgodjeaacaaaaeaacaaaaaaacpopp
oiabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaaeoaaaaakkiaanaakkkaanaappkaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoiadaaaa
eaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaaacaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaa
aaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
// Stats: 12 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = xlv_TEXCOORD2;
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_4)
  .xy).w)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_6.w = tmpvar_2.w;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  c_1.w = c_5.w;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_6.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mad oT4.x, r0.x, c10.z, c10.w
mov oPos.z, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedcffdmbgmodajpehbhhdbegcalbolekbiabaaaaaaleafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoiadaaaaeaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaa
apaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
eccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaa
acaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 24 math
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 224 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedchebmkecmdjminflakhpfiendomdaeepabaaaaaaaaaiaaaaaeaaaaaa
daaaaaaahiacaaaagiagaaaagaahaaaaebgpgodjeaacaaaaeaacaaaaaaacpopp
oiabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaoaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaaeoaaaaakkiaanaakkkaanaappkaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoiadaaaa
eaaaabaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaacaaaaaaabaaaaaadkiacaaaacaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaa
aaaaaaaaaoaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
abaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 19 math, 3 textures
Keywords { "POINT" }
Matrix 0 [_LightMatrix0] 3
Vector 5 [_Color]
Float 6 [_Cutoff]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c7, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld r0, t0, s1
mov r1.w, c5.w
mad_pp r1, r0.w, r1.w, -c6.x
mul_pp r0, r0, c5
mov r2.xyz, t2
mov r2.w, c7.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
dp4_pp r3.z, c2, r2
dp3_pp r2.xy, r3, r3
texkill r1
texld_pp r1, r2, s0
mul_pp r1.xyz, r1.x, c4
mul_pp r1.xyz, r0, r1
add r2.xyz, -t2, c3
nrm_pp r3.xyz, r2
dp3_pp r1.w, t1, r3
max_pp r2.x, r1.w, c7.y
mul_pp r0.xyz, r1, r2.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 17 math, 2 textures
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedfnkdibikiapickfhadnkodojocmhacokabaaaaaaamaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbmadaaaaeaaaaaaamhaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
agaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaa
abaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 17 math, 2 textures
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedpkejekekohgpbcegkliefgmdibcohncnabaaaaaapiafaaaaaeaaaaaa
daaaaaaabiacaaaadmafaaaameafaaaaebgpgodjoaabaaaaoaabaaaaaaacpppp
ieabaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaaaaaapaa
abaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaafaiaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaabaioekaabaaaaac
abaaaiiaafaappkaaeaaaaaeabaacpiaaaaappiaabaappiaagaaaakbafaaaaad
aaaacpiaaaaaoeiaafaaoekaafaaaaadacaachiaacaafflaacaaoekaaeaaaaae
acaachiaabaaoekaacaaaalaacaaoeiaaeaaaaaeacaachiaadaaoekaacaakkla
acaaoeiaacaaaaadacaachiaacaaoeiaaeaaoekaaiaaaaadacaacdiaacaaoeia
acaaoeiaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaaaaioekaafaaaaad
abaachiaabaaaaiaaaaaoekaafaaaaadabaachiaaaaaoeiaabaaoeiaacaaaaad
acaaahiaacaaoelbahaaoekaceaaaaacadaachiaacaaoeiaaiaaaaadabaaciia
abaaoelaadaaoeiaalaaaaadacaacbiaabaappiaaiaaaakaafaaaaadaaaachia
abaaoeiaacaaaaiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbmadaaaa
eaaaaaaamhaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaia
ebaaaaaaaaaaaaaaapaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaanaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaadaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
amaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 8 math, 2 textures
Keywords { "DIRECTIONAL" }
Vector 2 [_Color]
Float 3 [_Cutoff]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c4, 0, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_2d s0
texld r0, t0, s0
mov r1.w, c2.w
mad_pp r1, r0.w, r1.w, -c3.x
mul_pp r0, r0, c2
texkill r1
mul_pp r1.xyz, r0, c1
dp3_pp r1.w, t1, c0
max_pp r2.w, r1.w, c4.x
mul_pp r0.xyz, r1, r2.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 7 math, 1 textures
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedndkefjiahgfakfbegajoppjnageldpaaabaaaaaaimacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjmabaaaaeaaaaaaaghaaaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 7 math, 1 textures
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecednmnmeedfdgpjoamjlnbmdefkijommaimabaaaaaamiadaaaaaeaaaaaa
daaaaaaagiabaaaaamadaaaajeadaaaaebgpgodjdaabaaaadaabaaaaaaacpppp
niaaaaaafiaaaaaaaeaaciaaaaaafiaaaaaafiaaabaaceaaaaaafiaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaaaaaalaaabaaacaa
aaaaaaaaabaaaaaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapiaaaaaoelaaaaioeka
abaaaaacabaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakb
afaaaaadaaaacpiaaaaaoeiaabaaoekaebaaaaababaaapiaafaaaaadabaachia
aaaaoeiaaaaaoekaaiaaaaadabaaciiaabaaoelaadaaoekaalaaaaadacaaciia
abaappiaaeaaaakaafaaaaadaaaachiaabaaoeiaacaappiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcjmabaaaaeaaaaaaaghaaaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 24 math, 4 textures
Keywords { "SPOT" }
Matrix 0 [_LightMatrix0]
Vector 6 [_Color]
Float 7 [_Cutoff]
Vector 5 [_LightColor0]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c8, 1, 0.5, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld r0, t0, s2
mov r1.w, c6.w
mad_pp r1, r0.w, r1.w, -c7.x
mul_pp r0, r0, c6
mov r2.xyz, t2
mov r2.w, c8.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
dp4_pp r3.z, c2, r2
dp4_pp r3.w, c3, r2
rcp r3.w, r3.w
mad_pp r2.xy, r3, r3.w, c8.y
dp3_pp r3.xy, r3, r3
texkill r1
texld_pp r1, r2, s0
texld_pp r2, r3, s1
mul r1.x, r1.w, r2.x
mul_pp r1.xyz, r1.x, c5
cmp_pp r1.xyz, -r3.z, c8.z, r1
mul_pp r1.xyz, r0, r1
add r2.xyz, -t2, c4
nrm_pp r3.xyz, r2
dp3_pp r1.w, t1, r3
max_pp r2.x, r1.w, c8.z
mul_pp r0.xyz, r1, r2.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math, 3 textures
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedjdefanbogicpenjiapbcjgjgjhbjcflaabaaaaaaaaafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbaaeaaaaeaaaaaaaaeabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaadaaaaaaegiocaaaaaaaaaaaakaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaa
kgbkbaaaadaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaamaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaa
abaaaaaapgapbaaaabaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaagaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabaaaaahbcaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaa
acaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaa
akaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 23 math, 3 textures
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedhdjhfamclgeihnkefdpedellnfmmanhhabaaaaaafaahaaaaaeaaaaaa
daaaaaaahmacaaaajeagaaaabmahaaaaebgpgodjeeacaaaaeeacaaaaaaacpppp
oeabaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaabaaaaaa
acababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
aaaaapaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaad
aaaaapiaaaaaoelaacaioekaabaaaaacabaaaiiaafaappkaaeaaaaaeabaacpia
aaaappiaabaappiaagaaaakbafaaaaadaaaacpiaaaaaoeiaafaaoekaafaaaaad
acaacpiaacaafflaacaaoekaaeaaaaaeacaacpiaabaaoekaacaaaalaacaaoeia
aeaaaaaeacaacpiaadaaoekaacaakklaacaaoeiaacaaaaadacaacpiaacaaoeia
aeaaoekaagaaaaacacaaaiiaacaappiaaeaaaaaeadaacdiaacaaoeiaacaappia
aiaaaakaaiaaaaadacaacdiaacaaoeiaacaaoeiaebaaaaababaaapiaecaaaaad
abaacpiaadaaoeiaaaaioekaecaaaaadadaacpiaacaaoeiaabaioekaafaaaaad
abaaabiaabaappiaadaaaaiaafaaaaadabaachiaabaaaaiaaaaaoekafiaaaaae
abaachiaacaakkibaiaaffkaabaaoeiaafaaaaadabaachiaaaaaoeiaabaaoeia
acaaaaadacaaahiaacaaoelbahaaoekaceaaaaacadaachiaacaaoeiaaiaaaaad
abaaciiaabaaoelaadaaoeiaalaaaaadacaacbiaabaappiaaiaaffkaafaaaaad
aaaachiaabaaoeiaacaaaaiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
baaeaaaaeaaaaaaaaeabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaia
ebaaaaaaaaaaaaaaapaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaanaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaadaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaobaaa
abaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
amaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaaabaaaaaapgapbaaaabaaaaaa
aaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaa
ckaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaagaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaaabaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaa
adaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 20 math, 4 textures
Keywords { "POINT_COOKIE" }
Matrix 0 [_LightMatrix0] 3
Vector 5 [_Color]
Float 6 [_Cutoff]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c7, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_cube s0
dcl_2d s1
dcl_2d s2
texld r0, t0, s2
mov r1.w, c5.w
mad_pp r1, r0.w, r1.w, -c6.x
mul_pp r0, r0, c5
mov r2.xyz, t2
mov r2.w, c7.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
dp4_pp r3.z, c2, r2
dp3_pp r2.xy, r3, r3
texkill r1
texld r1, r3, s0
texld r2, r2, s1
mul_pp r1.x, r1.w, r2.x
mul_pp r1.xyz, r1.x, c4
mul_pp r1.xyz, r0, r1
add r2.xyz, -t2, c3
nrm_pp r3.xyz, r2
dp3_pp r1.w, t1, r3
max_pp r2.x, r1.w, c7.y
mul_pp r0.xyz, r1, r2.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 18 math, 3 textures
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedmfkpddffideladcjkbipjpjehlcodpkaabaaaaaagiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchiadaaaaeaaaaaaanoaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaa
kgbkbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegacbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 18 math, 3 textures
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefieceddlmdhcbgepnmnkiejmiocnmmkpnmdeenabaaaaaajaagaaaaaeaaaaaa
daaaaaaafeacaaaaneafaaaafmagaaaaebgpgodjbmacaaaabmacaaaaaaacpppp
lmabaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaacaaaaaa
abababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
aaaaapaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaji
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaad
aaaaapiaaaaaoelaacaioekaabaaaaacabaaaiiaafaappkaaeaaaaaeabaacpia
aaaappiaabaappiaagaaaakbafaaaaadaaaacpiaaaaaoeiaafaaoekaafaaaaad
acaachiaacaafflaacaaoekaaeaaaaaeacaachiaabaaoekaacaaaalaacaaoeia
aeaaaaaeacaachiaadaaoekaacaakklaacaaoeiaacaaaaadacaachiaacaaoeia
aeaaoekaaiaaaaadacaaciiaacaaoeiaacaaoeiaabaaaaacadaacdiaacaappia
ebaaaaababaaapiaecaaaaadabaaapiaacaaoeiaaaaioekaecaaaaadacaaapia
adaaoeiaabaioekaafaaaaadabaacbiaabaappiaacaaaaiaafaaaaadabaachia
abaaaaiaaaaaoekaafaaaaadabaachiaaaaaoeiaabaaoeiaacaaaaadacaaahia
acaaoelbahaaoekaceaaaaacadaachiaacaaoeiaaiaaaaadabaaciiaabaaoela
adaaoeiaalaaaaadacaacbiaabaappiaaiaaaakaafaaaaadaaaachiaabaaoeia
acaaaaiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchiadaaaaeaaaaaaa
noaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaa
apaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
anaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaadaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagbabaaaadaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegacbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaapgapbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaa
adaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 13 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_LightMatrix0] 2
Vector 4 [_Color]
Float 5 [_Cutoff]
Vector 3 [_LightColor0]
Vector 2 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c6, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld r0, t0, s1
mov r1.w, c4.w
mad_pp r1, r0.w, r1.w, -c5.x
mul_pp r0, r0, c4
mov r2.xyz, t2
mov r2.w, c6.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
texkill r1
texld_pp r1, r3, s0
mul_pp r1.xyz, r1.w, c3
mul_pp r1.xyz, r0, r1
dp3_pp r1.w, t1, c2
max_pp r2.x, r1.w, c6.y
mul_pp r0.xyz, r1, r2.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 12 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedejodobilmobigjfnajigpcbnbnoancenabaaaaaaieadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjeacaaaaeaaaaaaakfaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadiaaaaaidcaabaaaabaaaaaafgbfbaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegaabaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaa
egaabaaaabaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
abaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 12 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecediocbjkpenjflldnppokkhkckhaaebkpdabaaaaaaeeafaaaaaeaaaaaa
daaaaaaaomabaaaaiiaeaaaabaafaaaaebgpgodjleabaaaaleabaaaaaaacpppp
fiabaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaaaaaapaa
abaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaafaiaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaabaioekaabaaaaac
abaaaiiaafaappkaaeaaaaaeabaacpiaaaaappiaabaappiaagaaaakbafaaaaad
aaaacpiaaaaaoeiaafaaoekaafaaaaadacaacdiaacaafflaacaaoekaaeaaaaae
acaacdiaabaaoekaacaaaalaacaaoeiaaeaaaaaeacaacdiaadaaoekaacaakkla
acaaoeiaacaaaaadacaacdiaacaaoeiaaeaaoekaebaaaaababaaapiaecaaaaad
abaacpiaacaaoeiaaaaioekaafaaaaadabaachiaabaappiaaaaaoekaafaaaaad
abaachiaaaaaoeiaabaaoeiaaiaaaaadabaaciiaabaaoelaahaaoekaalaaaaad
acaacbiaabaappiaaiaaaakaafaaaaadaaaachiaabaaoeiaacaaaaiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcjeacaaaaeaaaaaaakfaaaaaafjaaaaae
egiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaafgbfbaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaabaaaabaaaaaaaaaaaaaidcaabaaa
abaaaaaaegaabaaaabaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_LINEAR" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 21 math, 3 textures
Keywords { "POINT" "FOG_LINEAR" }
Matrix 0 [_LightMatrix0] 3
Vector 5 [_Color]
Float 6 [_Cutoff]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c7, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_2d s0
dcl_2d s1
texld r0, t0, s1
mov r1.w, c5.w
mad_pp r1, r0.w, r1.w, -c6.x
mul_pp r0, r0, c5
mov r2.xyz, t2
mov r2.w, c7.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
dp4_pp r3.z, c2, r2
dp3_pp r2.xy, r3, r3
texkill r1
texld_pp r1, r2, s0
mul_pp r1.xyz, r1.x, c4
mul_pp r1.xyz, r0, r1
add r2.xyz, -t2, c3
nrm_pp r3.xyz, r2
dp3_pp r1.w, t1, r3
max_pp r2.x, r1.w, c7.y
mul_pp r1.xyz, r1, r2.x
mov_sat r1.w, t4.x
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 18 math, 2 textures
Keywords { "POINT" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedbjccnlnmoolpglpnalnnncmecmglfdncabaaaaaagaaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfiadaaaaeaaaaaaangaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaadaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
agaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaa
egiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 18 math, 2 textures
Keywords { "POINT" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedjdfifbfomndefkoeldacgdgnokmmacbmabaaaaaagiagaaaaaeaaaaaa
daaaaaaadeacaaaajeafaaaadeagaaaaebgpgodjpmabaaaapmabaaaaaaacpppp
kaabaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaaaaaapaa
abaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaafaiaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaabaioekaabaaaaac
abaaaiiaafaappkaaeaaaaaeabaacpiaaaaappiaabaappiaagaaaakbafaaaaad
aaaacpiaaaaaoeiaafaaoekaafaaaaadacaachiaacaafflaacaaoekaaeaaaaae
acaachiaabaaoekaacaaaalaacaaoeiaaeaaaaaeacaachiaadaaoekaacaakkla
acaaoeiaacaaaaadacaachiaacaaoeiaaeaaoekaaiaaaaadacaacdiaacaaoeia
acaaoeiaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaaaaioekaafaaaaad
abaachiaabaaaaiaaaaaoekaafaaaaadabaachiaaaaaoeiaabaaoeiaacaaaaad
acaaahiaacaaoelbahaaoekaceaaaaacadaachiaacaaoeiaaiaaaaadabaaciia
abaaoelaadaaoeiaalaaaaadacaacbiaabaappiaaiaaaakaafaaaaadabaachia
abaaoeiaacaaaaiaabaaaaacabaabiiaaaaakklaafaaaaadaaaachiaabaaoeia
abaappiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcfiadaaaaeaaaaaaa
ngaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
anaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 10 math, 2 textures
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
Vector 2 [_Color]
Float 3 [_Cutoff]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c4, 0, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t4.x
dcl_2d s0
texld r0, t0, s0
mov r1.w, c2.w
mad_pp r1, r0.w, r1.w, -c3.x
mul_pp r0, r0, c2
texkill r1
mul_pp r1.xyz, r0, c1
dp3_pp r1.w, t1, c0
max_pp r2.w, r1.w, c4.x
mul_pp r1.xyz, r1, r2.w
mov_sat r1.w, t4.x
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 8 math, 1 textures
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedeondakcfnmbcgplhgpkmbgaeiigfibbgabaaaaaaoaacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcniabaaaaeaaaaaaahgaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 8 math, 1 textures
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 176 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefieceddfbgpmkeiljfkhifdpmkjgchljhfjmoeabaaaaaadiaeaaaaaeaaaaaa
daaaaaaaieabaaaageadaaaaaeaeaaaaebgpgodjemabaaaaemabaaaaaaacpppp
peaaaaaafiaaaaaaaeaaciaaaaaafiaaaaaafiaaabaaceaaaaaafiaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaaaaaalaaabaaacaa
aaaaaaaaabaaaaaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapiaaaaaoelaaaaioeka
abaaaaacabaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakb
afaaaaadaaaacpiaaaaaoeiaabaaoekaebaaaaababaaapiaafaaaaadabaachia
aaaaoeiaaaaaoekaaiaaaaadabaaciiaabaaoelaadaaoekaalaaaaadacaaciia
abaappiaaeaaaakaafaaaaadabaachiaabaaoeiaacaappiaabaaaaacabaabiia
aaaakklaafaaaaadaaaachiaabaaoeiaabaappiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcniabaaaaeaaaaaaahgaaaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_LINEAR" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 26 math, 4 textures
Keywords { "SPOT" "FOG_LINEAR" }
Matrix 0 [_LightMatrix0]
Vector 6 [_Color]
Float 7 [_Cutoff]
Vector 5 [_LightColor0]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c8, 1, 0.5, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld r0, t0, s2
mov r1.w, c6.w
mad_pp r1, r0.w, r1.w, -c7.x
mul_pp r0, r0, c6
mov r2.xyz, t2
mov r2.w, c8.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
dp4_pp r3.z, c2, r2
dp4_pp r3.w, c3, r2
rcp r3.w, r3.w
mad_pp r2.xy, r3, r3.w, c8.y
dp3_pp r3.xy, r3, r3
texkill r1
texld_pp r1, r2, s0
texld_pp r2, r3, s1
mul r1.x, r1.w, r2.x
mul_pp r1.xyz, r1.x, c5
cmp_pp r1.xyz, -r3.z, c8.z, r1
mul_pp r1.xyz, r0, r1
add r2.xyz, -t2, c4
nrm_pp r3.xyz, r2
dp3_pp r1.w, t1, r3
max_pp r2.x, r1.w, c8.z
mul_pp r1.xyz, r1, r2.x
mov_sat r1.w, t4.x
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 24 math, 3 textures
Keywords { "SPOT" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedingibkpaocjjnafapfoklogdmjemkpcpabaaaaaafeafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcemaeaaaaeaaaaaaabdabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaadaaaaaaegiocaaaaaaaaaaa
akaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaaaoaaaaahdcaabaaaacaaaaaa
egaabaaaabaaaaaapgapbaaaabaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaah
icaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
agaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
adaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 24 math, 3 textures
Keywords { "SPOT" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedhddoolbelncnecggogeffiofkcmlkaloabaaaaaamaahaaaaaeaaaaaa
daaaaaaajiacaaaaomagaaaaimahaaaaebgpgodjgaacaaaagaacaaaaaaacpppp
aaacaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaabaaaaaa
acababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
aaaaapaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaad
aaaaapiaaaaaoelaacaioekaabaaaaacabaaaiiaafaappkaaeaaaaaeabaacpia
aaaappiaabaappiaagaaaakbafaaaaadaaaacpiaaaaaoeiaafaaoekaafaaaaad
acaacpiaacaafflaacaaoekaaeaaaaaeacaacpiaabaaoekaacaaaalaacaaoeia
aeaaaaaeacaacpiaadaaoekaacaakklaacaaoeiaacaaaaadacaacpiaacaaoeia
aeaaoekaagaaaaacacaaaiiaacaappiaaeaaaaaeadaacdiaacaaoeiaacaappia
aiaaaakaaiaaaaadacaacdiaacaaoeiaacaaoeiaebaaaaababaaapiaecaaaaad
abaacpiaadaaoeiaaaaioekaecaaaaadadaacpiaacaaoeiaabaioekaafaaaaad
abaaabiaabaappiaadaaaaiaafaaaaadabaachiaabaaaaiaaaaaoekafiaaaaae
abaachiaacaakkibaiaaffkaabaaoeiaafaaaaadabaachiaaaaaoeiaabaaoeia
acaaaaadacaaahiaacaaoelbahaaoekaceaaaaacadaachiaacaaoeiaaiaaaaad
abaaciiaabaaoelaadaaoeiaalaaaaadacaacbiaabaappiaaiaaffkaafaaaaad
abaachiaabaaoeiaacaaaaiaabaaaaacabaabiiaaaaakklaafaaaaadaaaachia
abaaoeiaabaappiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcemaeaaaa
eaaaaaaabdabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
anaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaadaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaa
adaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaamaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaaabaaaaaa
pgapbaaaabaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaabaaaaaa
abeaaaaaaaaaaaaackaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaagaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaaabaaaaahbcaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaa
aaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 22 math, 4 textures
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
Matrix 0 [_LightMatrix0] 3
Vector 5 [_Color]
Float 6 [_Cutoff]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c7, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_cube s0
dcl_2d s1
dcl_2d s2
texld r0, t0, s2
mov r1.w, c5.w
mad_pp r1, r0.w, r1.w, -c6.x
mul_pp r0, r0, c5
mov r2.xyz, t2
mov r2.w, c7.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
dp4_pp r3.z, c2, r2
dp3_pp r2.xy, r3, r3
texkill r1
texld r1, r3, s0
texld r2, r2, s1
mul_pp r1.x, r1.w, r2.x
mul_pp r1.xyz, r1.x, c4
mul_pp r1.xyz, r0, r1
add r2.xyz, -t2, c3
nrm_pp r3.xyz, r2
dp3_pp r1.w, t1, r3
max_pp r2.x, r1.w, c7.y
mul_pp r1.xyz, r1, r2.x
mov_sat r1.w, t4.x
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 19 math, 3 textures
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedmcnaibaojoajmejkcijimngpjahdkeeeabaaaaaalmaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcleadaaaaeaaaaaaaonaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegacbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
agaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaa
abaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 19 math, 3 textures
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedjlbndobfndibjdmiglipkkcmpholjbbpabaaaaaaaaahaaaaaeaaaaaa
daaaaaaahaacaaaacmagaaaammagaaaaebgpgodjdiacaaaadiacaaaaaaacpppp
niabaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaacaaaaaa
abababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
aaaaapaaabaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaji
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaad
aaaaapiaaaaaoelaacaioekaabaaaaacabaaaiiaafaappkaaeaaaaaeabaacpia
aaaappiaabaappiaagaaaakbafaaaaadaaaacpiaaaaaoeiaafaaoekaafaaaaad
acaachiaacaafflaacaaoekaaeaaaaaeacaachiaabaaoekaacaaaalaacaaoeia
aeaaaaaeacaachiaadaaoekaacaakklaacaaoeiaacaaaaadacaachiaacaaoeia
aeaaoekaaiaaaaadacaaciiaacaaoeiaacaaoeiaabaaaaacadaacdiaacaappia
ebaaaaababaaapiaecaaaaadabaaapiaacaaoeiaaaaioekaecaaaaadacaaapia
adaaoeiaabaioekaafaaaaadabaacbiaabaappiaacaaaaiaafaaaaadabaachia
abaaaaiaaaaaoekaafaaaaadabaachiaaaaaoeiaabaaoeiaacaaaaadacaaahia
acaaoelbahaaoekaceaaaaacadaachiaacaaoeiaaiaaaaadabaaciiaabaaoela
adaaoeiaalaaaaadacaacbiaabaappiaaiaaaakaafaaaaadabaachiaabaaoeia
acaaaaiaabaaaaacabaabiiaaaaakklaafaaaaadaaaachiaabaaoeiaabaappia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcleadaaaaeaaaaaaaonaaaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaia
ebaaaaaaaaaaaaaaapaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaanaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaadaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
amaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegacbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaa
aaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 15 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
Matrix 0 [_LightMatrix0] 2
Vector 4 [_Color]
Float 5 [_Cutoff]
Vector 3 [_LightColor0]
Vector 2 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c6, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_2d s0
dcl_2d s1
texld r0, t0, s1
mov r1.w, c4.w
mad_pp r1, r0.w, r1.w, -c5.x
mul_pp r0, r0, c4
mov r2.xyz, t2
mov r2.w, c6.x
dp4_pp r3.x, c0, r2
dp4_pp r3.y, c1, r2
texkill r1
texld_pp r1, r3, s0
mul_pp r1.xyz, r1.w, c3
mul_pp r1.xyz, r0, r1
dp3_pp r1.w, t1, c2
max_pp r2.x, r1.w, c6.y
mul_pp r1.xyz, r1, r2.x
mov_sat r1.w, t4.x
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 13 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefieceddgdkdpcflfojpncdcblappnbemnagcefabaaaaaaniadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnaacaaaaeaaaaaaaleaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaaaaaaaaaaapaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaanaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaafgbfbaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaabaaaabaaaaaaaaaaaaaidcaabaaa
abaaaaaaegaabaaaabaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 13 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
Float 240 [_Cutoff]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedanghcjgjedfebfgeakdnnafmaakpfigdabaaaaaaleafaaaaaeaaaaaa
daaaaaaaaiacaaaaoaaeaaaaiaafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
heabaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaaaaaapaa
abaaagaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaafaiaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaabaioekaabaaaaac
abaaaiiaafaappkaaeaaaaaeabaacpiaaaaappiaabaappiaagaaaakbafaaaaad
aaaacpiaaaaaoeiaafaaoekaafaaaaadacaacdiaacaafflaacaaoekaaeaaaaae
acaacdiaabaaoekaacaaaalaacaaoeiaaeaaaaaeacaacdiaadaaoekaacaakkla
acaaoeiaacaaaaadacaacdiaacaaoeiaaeaaoekaebaaaaababaaapiaecaaaaad
abaacpiaacaaoeiaaaaioekaafaaaaadabaachiaabaappiaaaaaoekaafaaaaad
abaachiaaaaaoeiaabaaoeiaaiaaaaadabaaciiaabaaoelaahaaoekaalaaaaad
acaacbiaabaappiaaiaaaakaafaaaaadabaachiaabaaoeiaacaaaaiaabaaaaac
abaabiiaaaaakklaafaaaaadaaaachiaabaaoeiaabaappiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcnaacaaaaeaaaaaaaleaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaakiacaiaebaaaaaa
aaaaaaaaapaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaanaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaafgbfbaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aaaaaaaaajaaaaaaagbabaaaadaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaabaaaabaaaaaa
aaaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
imaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 23 math
 //    d3d11_9x : 23 math
 //        d3d9 : 14 math
 //      opengl : 6 math, 2 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 3 math, 1 texture
 //    d3d11_9x : 3 math, 1 texture
 //        d3d9 : 5 math, 2 texture
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  GpuProgramID 154229
Program "vp" {
SubProgram "opengl " {
// Stats: 6 math, 2 textures, 1 branches
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
  float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  res_1.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjkapaphijibjblghmlnlloipfbhfmpnpabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 23 math
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecednhmochkbpnefidoopnfiajlkpifdfhmcabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaakaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaa
ogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 5 math, 2 textures
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, 0.5, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_2d s0
texld r0, t0, s0
mov r1.w, c0.w
mad_pp r0, r0.w, r1.w, -c1.x
texkill r0
mad_pp r0.xyz, t1, c2.x, c2.x
mov_pp r0.w, c2.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 3 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 144 [_Color]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedohahbagaggigigklcinmfofgakdgcjhdabaaaaaacaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaabaaaaeaaaaaaaemaaaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaa
alaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegbcbaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 3 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 144 [_Color]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkjcjjfdphofhjpkbkdbdlkanffhkehlhabaaaaaabeadaaaaaeaaaaaa
daaaaaaacaabaaaafiacaaaaoaacaaaaebgpgodjoiaaaaaaoiaaaaaaaaacpppp
kiaaaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaajaaabaaaaaaaaaaaaaaaaaaalaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
aaaaoelaaaaioekaabaaaaacabaaaiiaaaaappkaaeaaaaaeaaaacpiaaaaappia
abaappiaabaaaakbebaaaaabaaaaapiaaeaaaaaeaaaachiaabaaoelaacaaaaka
acaaaakaabaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcdaabaaaaeaaaaaaaemaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadcaaaaaphccabaaaaaaaaaaaegbcbaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 37 avg math (37..38)
 //    d3d11_9x : 37 avg math (37..38)
 //        d3d9 : 33 avg math (33..34)
 //      opengl : 7 avg math (5..9), 3 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 7 avg math (6..8), 2 texture
 //    d3d11_9x : 7 avg math (6..8), 2 texture
 //        d3d9 : 8 avg math (6..11), 3 texture
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  GpuProgramID 213615
Program "vp" {
SubProgram "opengl " {
// Stats: 7 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform sampler2D _LightBuffer;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 light_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 tmpvar_4;
  tmpvar_4 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD2)));
  light_1.w = tmpvar_4.w;
  light_1.xyz = (tmpvar_4.xyz + xlv_TEXCOORD4);
  vec4 c_5;
  c_5.xyz = (tmpvar_2.xyz * light_1.xyz);
  c_5.w = tmpvar_2.w;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 33 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 19 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c20, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c19, c19.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c20.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c20.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c20.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mov oPos, r0
mov oT2.zw, r0
mov oT3, c20.z

"
}
SubProgram "d3d11 " {
// Stats: 37 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcnicklgnmiabeimkjaeheiakhcdoadfmabaaaaaammahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 37 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedngkaammpkmebnfpgomliieacaneogfdgabaaaaaacealaaaaaeaaaaaa
daaaaaaaieadaaaaheajaaaagmakaaaaebgpgodjemadaaaaemadaaaaaaacpopp
oiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaakaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaapaaoeka
aeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabaaaoeka
aaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaacaaaakaafaaaaadabaaaiia
abaaaaiabfaaaakaafaaaaadabaaafiaaaaapeiabfaaaakaacaaaaadacaaadoa
abaakkiaabaaomiaafaaaaadabaaabiaacaaaajabcaaaakaafaaaaadabaaacia
acaaaajabdaaaakaafaaaaadabaaaeiaacaaaajabeaaaakaafaaaaadacaaabia
acaaffjabcaaffkaafaaaaadacaaaciaacaaffjabdaaffkaafaaaaadacaaaeia
acaaffjabeaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaadacaaabia
acaakkjabcaakkkaafaaaaadacaaaciaacaakkjabdaakkkaafaaaaadacaaaeia
acaakkjabeaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaacacaaahia
abaaoeiaafaaaaadabaaabiaacaaffiaacaaffiaaeaaaaaeabaaabiaacaaaaia
acaaaaiaabaaaaibafaaaaadadaaapiaacaacjiaacaakeiaajaaaaadaeaaabia
agaaoekaadaaoeiaajaaaaadaeaaaciaahaaoekaadaaoeiaajaaaaadaeaaaeia
aiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoekaabaaaaiaaeaaoeiaabaaaaac
acaaaiiabfaaffkaajaaaaadadaaabiaadaaoekaacaaoeiaajaaaaadadaaacia
aeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoekaacaaoeiaacaaaaadaeaaahoa
abaaoeiaadaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacadaaapoabfaakkka
ppppaaaafdeieefcoiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaa
acaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
// Stats: 5 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform sampler2D _LightBuffer;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 light_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_1.w = tmpvar_4.w;
  light_1.xyz = (tmpvar_4.xyz + xlv_TEXCOORD4);
  vec4 c_5;
  c_5.xyz = (tmpvar_2.xyz * light_1.xyz);
  c_5.w = tmpvar_2.w;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 33 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 19 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c20, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c19, c19.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c20.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c20.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c20.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mov oPos, r0
mov oT2.zw, r0
mov oT3, c20.z

"
}
SubProgram "d3d11 " {
// Stats: 37 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcnicklgnmiabeimkjaeheiakhcdoadfmabaaaaaammahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 37 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedngkaammpkmebnfpgomliieacaneogfdgabaaaaaacealaaaaaeaaaaaa
daaaaaaaieadaaaaheajaaaagmakaaaaebgpgodjemadaaaaemadaaaaaaacpopp
oiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaakaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaapaaoeka
aeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabaaaoeka
aaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaacaaaakaafaaaaadabaaaiia
abaaaaiabfaaaakaafaaaaadabaaafiaaaaapeiabfaaaakaacaaaaadacaaadoa
abaakkiaabaaomiaafaaaaadabaaabiaacaaaajabcaaaakaafaaaaadabaaacia
acaaaajabdaaaakaafaaaaadabaaaeiaacaaaajabeaaaakaafaaaaadacaaabia
acaaffjabcaaffkaafaaaaadacaaaciaacaaffjabdaaffkaafaaaaadacaaaeia
acaaffjabeaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaadacaaabia
acaakkjabcaakkkaafaaaaadacaaaciaacaakkjabdaakkkaafaaaaadacaaaeia
acaakkjabeaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaacacaaahia
abaaoeiaafaaaaadabaaabiaacaaffiaacaaffiaaeaaaaaeabaaabiaacaaaaia
acaaaaiaabaaaaibafaaaaadadaaapiaacaacjiaacaakeiaajaaaaadaeaaabia
agaaoekaadaaoeiaajaaaaadaeaaaciaahaaoekaadaaoeiaajaaaaadaeaaaeia
aiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoekaabaaaaiaaeaaoeiaabaaaaac
acaaaiiabfaaffkaajaaaaadadaaabiaadaaoekaacaaoeiaajaaaaadadaaacia
aeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoekaacaaoeiaacaaaaadaeaaahoa
abaaoeiaadaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacadaaapoabfaakkka
ppppaaaafdeieefcoiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaa
acaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
// Stats: 9 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform sampler2D _LightBuffer;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_4;
  x_4 = (tmpvar_3.w - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  vec4 tmpvar_5;
  tmpvar_5 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD2)));
  light_2.w = tmpvar_5.w;
  light_2.xyz = (tmpvar_5.xyz + xlv_TEXCOORD4);
  vec4 c_6;
  c_6.xyz = (tmpvar_3.xyz * light_2.xyz);
  c_6.w = tmpvar_3.w;
  c_1.w = c_6.w;
  c_1.xyz = mix (unity_FogColor.xyz, c_6.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 19 [unity_FogParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c20, c20.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mad oT5.x, r0.z, c19.z, c19.w
mov oPos, r0
mov oT2.zw, r0
mov oT3, c21.z

"
}
SubProgram "d3d11 " {
// Stats: 38 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecedaookdmbpnmbgjbakjjhpnfpembfjblpfabaaaaaacmaiaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaagaaaaeaaaabaa
imabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaaeaaaaaaabaaaaaadkiacaaaaeaaaaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 38 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedanmjdgdhbkicjaolkhjbblnfggniaonkabaaaaaakealaaaaaeaaaaaa
daaaaaaakeadaaaanmajaaaaneakaaaaebgpgodjgmadaaaagmadaaaaaaacpopp
pmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaakaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaeaaabaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoeka
aaaappjaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapia
akaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
acaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafiaaaaapeia
bgaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaabiaacaaaaja
bcaaaakaafaaaaadabaaaciaacaaaajabdaaaakaafaaaaadabaaaeiaacaaaaja
beaaaakaafaaaaadacaaabiaacaaffjabcaaffkaafaaaaadacaaaciaacaaffja
bdaaffkaafaaaaadacaaaeiaacaaffjabeaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaabiaacaakkjabcaakkkaafaaaaadacaaaciaacaakkja
bdaakkkaafaaaaadacaaaeiaacaakkjabeaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaceaaaaacacaaahiaabaaoeiaafaaaaadabaaabiaacaaffiaacaaffia
aeaaaaaeabaaabiaacaaaaiaacaaaaiaabaaaaibafaaaaadadaaapiaacaacjia
acaakeiaajaaaaadaeaaabiaagaaoekaadaaoeiaajaaaaadaeaaaciaahaaoeka
adaaoeiaajaaaaadaeaaaeiaaiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoeka
abaaaaiaaeaaoeiaabaaaaacacaaaiiabgaaffkaajaaaaadadaaabiaadaaoeka
acaaoeiaajaaaaadadaaaciaaeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoeka
acaaoeiaacaaaaadaeaaahoaabaaoeiaadaaoeiaaeaaaaaeaaaaaeoaaaaakkia
bfaakkkabfaappkaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacadaaapoabgaakkka
ppppaaaafdeieefcdaagaaaaeaaaabaaimabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaaeegiocaaaaeaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
dcaaaaaleccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaaeaaaaaaabaaaaaa
dkiacaaaaeaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaai
pccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaah
hccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheo
paaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaa
adaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
// Stats: 7 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform sampler2D _LightBuffer;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_4;
  x_4 = (tmpvar_3.w - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_2.w = tmpvar_5.w;
  light_2.xyz = (tmpvar_5.xyz + xlv_TEXCOORD4);
  vec4 c_6;
  c_6.xyz = (tmpvar_3.xyz * light_2.xyz);
  c_6.w = tmpvar_3.w;
  c_1.w = c_6.w;
  c_1.xyz = mix (unity_FogColor.xyz, c_6.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 19 [unity_FogParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c20, c20.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mad oT5.x, r0.z, c19.z, c19.w
mov oPos, r0
mov oT2.zw, r0
mov oT3, c21.z

"
}
SubProgram "d3d11 " {
// Stats: 38 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecedaookdmbpnmbgjbakjjhpnfpembfjblpfabaaaaaacmaiaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaagaaaaeaaaabaa
imabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaaleccabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaaeaaaaaaabaaaaaadkiacaaaaeaaaaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 38 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedanmjdgdhbkicjaolkhjbblnfggniaonkabaaaaaakealaaaaaeaaaaaa
daaaaaaakeadaaaanmajaaaaneakaaaaebgpgodjgmadaaaagmadaaaaaaacpopp
pmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaakaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaeaaabaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoeka
aaaappjaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapia
akaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
acaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafiaaaaapeia
bgaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaabiaacaaaaja
bcaaaakaafaaaaadabaaaciaacaaaajabdaaaakaafaaaaadabaaaeiaacaaaaja
beaaaakaafaaaaadacaaabiaacaaffjabcaaffkaafaaaaadacaaaciaacaaffja
bdaaffkaafaaaaadacaaaeiaacaaffjabeaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaabiaacaakkjabcaakkkaafaaaaadacaaaciaacaakkja
bdaakkkaafaaaaadacaaaeiaacaakkjabeaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaceaaaaacacaaahiaabaaoeiaafaaaaadabaaabiaacaaffiaacaaffia
aeaaaaaeabaaabiaacaaaaiaacaaaaiaabaaaaibafaaaaadadaaapiaacaacjia
acaakeiaajaaaaadaeaaabiaagaaoekaadaaoeiaajaaaaadaeaaaciaahaaoeka
adaaoeiaajaaaaadaeaaaeiaaiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoeka
abaaaaiaaeaaoeiaabaaaaacacaaaiiabgaaffkaajaaaaadadaaabiaadaaoeka
acaaoeiaajaaaaadadaaaciaaeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoeka
acaaoeiaacaaaaadaeaaahoaabaaoeiaadaaoeiaaeaaaaaeaaaaaeoaaaaakkia
bfaakkkabfaappkaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacadaaapoabgaakkka
ppppaaaafdeieefcdaagaaaaeaaaabaaimabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaaeegiocaaaaeaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
dcaaaaaleccabaaaabaaaaaackaabaaaaaaaaaaackiacaaaaeaaaaaaabaaaaaa
dkiacaaaaeaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaai
pccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaah
hccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheo
paaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaa
adaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 9 math, 3 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
mov r1.w, c0.w
mad_pp r1, r0.w, r1.w, -c1.x
mul_pp r0, r0, c0
texkill r1
texldp_pp r1, t2, s1
log_pp r2.x, r1.x
log_pp r2.y, r1.y
log_pp r2.z, r1.z
add_pp r1.xyz, -r2, t4
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 7 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaapaheimbpoonkichldpdojebomkigcaabaaaaaaomacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmabaaaa
eaaaaaaahdaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaafaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 7 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhmbebiclplcjhhlkdlkcdjfiikjfpbggabaaaaaaeeaeaaaaaeaaaaaa
daaaaaaaieabaaaafiadaaaabaaeaaaaebgpgodjemabaaaaemabaaaaaaacpppp
aiabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaajaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaaaaacpppp
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
aeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiiaaaaappkaaeaaaaaeabaacpia
aaaappiaabaappiaabaaaakbafaaaaadaaaacpiaaaaaoeiaaaaaoekaagaaaaac
acaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaabaioekaapaaaaacacaacbiaabaaaaiaapaaaaac
acaacciaabaaffiaapaaaaacacaaceiaabaakkiaacaaaaadabaachiaacaaoeib
aeaaoelaafaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcmmabaaaaeaaaaaaahdaaaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaa
aaaaaaaaamaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaa
afaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 6 math, 3 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
mov r1.w, c0.w
mad_pp r1, r0.w, r1.w, -c1.x
mul_pp r0, r0, c0
texkill r1
texldp_pp r1, t2, s1
add_pp r1.xyz, r1, t4
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 6 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedffoeibbjflbnmefmpgnpeleeeppelmgaabaaaaaaneacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleabaaaa
eaaaaaaagnaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 6 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedklnmfalfooahioopmnhpbadhjffaimjbabaaaaaaaiaeaaaaaeaaaaaa
daaaaaaagaabaaaabmadaaaaneadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
oeaaaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaajaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaaaaacpppp
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
aeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiiaaaaappkaaeaaaaaeabaacpia
aaaappiaabaappiaabaaaakbafaaaaadaaaacpiaaaaaoeiaaaaaoekaagaaaaac
acaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaabaioekaacaaaaadabaachiaabaaoeiaaeaaoela
afaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcleabaaaaeaaaaaaagnaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaa
amaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egbcbaaaafaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 11 math, 3 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
Vector 1 [_Color]
Float 2 [_Cutoff]
Vector 0 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl t5.x
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
mov r1.w, c1.w
mad_pp r1, r0.w, r1.w, -c2.x
mul_pp r0, r0, c1
texkill r1
texldp_pp r1, t2, s1
log_pp r2.x, r1.x
log_pp r2.y, r1.y
log_pp r2.z, r1.z
add_pp r1.xyz, -r2, t4
mad r1.xyz, r0, r1, -c0
mov_sat r1.w, t5.x
mad_pp r0.xyz, r1.w, r1, c0
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 8 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedpenlomicmmlmdemiphpjlhjelejacalpabaaaaaagmadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeacaaaaeaaaaaaainaaaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegbcbaaaafaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaa
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 8 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0_level_9_1
eefiecedcjbjdljlapnpdnjbiglcndhibegmmobbabaaaaaapeaeaaaaaeaaaaaa
daaaaaaaleabaaaapaadaaaamaaeaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
cmabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaaaaaaaaa
abababaaaaaaajaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaaabaaaaaa
abaaacaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiia
aaaappkaaeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbafaaaaadaaaacpia
aaaaoeiaaaaaoekaagaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappia
acaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaapaaaaac
acaacbiaabaaaaiaapaaaaacacaacciaabaaffiaapaaaaacacaaceiaabaakkia
acaaaaadabaachiaacaaoeibaeaaoelaaeaaaaaeabaaahiaaaaaoeiaabaaoeia
acaaoekbabaaaaacabaabiiaaaaakklaaeaaaaaeaaaachiaabaappiaabaaoeia
acaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdeacaaaaeaaaaaaa
inaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaaf
hcaabaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegbcbaaaafaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaa
abaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaa
laaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
abaaaaaaaeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
lmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaalmaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 8 math, 3 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
Vector 1 [_Color]
Float 2 [_Cutoff]
Vector 0 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl t5.x
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
mov r1.w, c1.w
mad_pp r1, r0.w, r1.w, -c2.x
mul_pp r0, r0, c1
texkill r1
texldp_pp r1, t2, s1
add_pp r1.xyz, r1, t4
mad r1.xyz, r0, r1, -c0
mov_sat r1.w, t5.x
mad_pp r0.xyz, r1.w, r1, c0
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 7 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedoggfalikilaanalnocodlinpbhlgagjjabaaaaaafeadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmacaaaaeaaaaaaaihaaaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaa
ckbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 7 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0_level_9_1
eefiecedlfimkdiofhegeofcddicjcnaapnpfdniabaaaaaaliaeaaaaaeaaaaaa
daaaaaaajaabaaaaleadaaaaieaeaaaaebgpgodjfiabaaaafiabaaaaaaacpppp
aiabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaaaaaaaaa
abababaaaaaaajaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaaabaaaaaa
abaaacaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiia
aaaappkaaeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbafaaaaadaaaacpia
aaaaoeiaaaaaoekaagaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappia
acaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaacaaaaad
abaachiaabaaoeiaaeaaoelaaeaaaaaeabaaahiaaaaaoeiaabaaoeiaacaaoekb
abaaaaacabaabiiaaaaakklaaeaaaaaeaaaachiaabaappiaabaaoeiaacaaoeka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbmacaaaaeaaaaaaaihaaaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaa
ckbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 34 math
 //    d3d11_9x : 34 math
 //        d3d9 : 28 math
 //      opengl : 11 avg math (10..12), 2 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 5 avg math (5..6), 1 texture
 //    d3d11_9x : 5 avg math (5..6), 1 texture
 //        d3d9 : 14 avg math (13..16), 2 texture
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  GpuProgramID 310479
Program "vp" {
SubProgram "opengl " {
// Stats: 12 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 outEmission_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  vec4 emission_4;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  emission_4.w = 1.0;
  emission_4.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  outEmission_1.w = emission_4.w;
  outEmission_1.xyz = exp2(-(emission_4.xyz));
  gl_FragData[0] = tmpvar_5;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = tmpvar_6;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 28 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_MainTex_ST]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c18, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c18.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT5.xyz, r0, r2
mov oT4, c18.y

"
}
SubProgram "d3d11 " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddadoneemaeiphfglmpgbndfbffcgdgieabaaaaaaeeahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
gaafaaaaeaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaa
aaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedjjaindmjhjaddncpolkblagfjmghpkciabaaaaaafaakaaaaaeaaaaaa
daaaaaaadiadaaaakaaiaaaajiajaaaaebgpgodjaaadaaaaaaadaaaaaaacpopp
kiacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaakaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaafaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
acaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabbaaaaka
afaaaaadaaaaaciaacaaaajabcaaaakaafaaaaadaaaaaeiaacaaaajabdaaaaka
afaaaaadabaaabiaacaaffjabbaaffkaafaaaaadabaaaciaacaaffjabcaaffka
afaaaaadabaaaeiaacaaffjabdaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabbaakkkaafaaaaadabaaaciaacaakkjabcaakkka
afaaaaadabaaaeiaacaakkjabdaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeia
ajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabeaaaakaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
abaaaaacabaaahoaabaaoeiaacaaaaadaeaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaapoabeaaffkappppaaaafdeieefcgaafaaaa
eaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 10 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Cutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  float x_2;
  x_2 = (tmpvar_1.w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  vec4 emission_3;
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  emission_3.w = 1.0;
  emission_3.xyz = (tmpvar_1.xyz * xlv_TEXCOORD5);
  gl_FragData[0] = tmpvar_4;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = tmpvar_5;
  gl_FragData[3] = emission_3;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 28 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_MainTex_ST]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c18, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c18.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT5.xyz, r0, r2
mov oT4, c18.y

"
}
SubProgram "d3d11 " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddadoneemaeiphfglmpgbndfbffcgdgieabaaaaaaeeahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
gaafaaaaeaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaa
aaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 160 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedjjaindmjhjaddncpolkblagfjmghpkciabaaaaaafaakaaaaaeaaaaaa
daaaaaaadiadaaaakaaiaaaajiajaaaaebgpgodjaaadaaaaaaadaaaaaaacpopp
kiacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaakaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaafaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
acaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabbaaaaka
afaaaaadaaaaaciaacaaaajabcaaaakaafaaaaadaaaaaeiaacaaaajabdaaaaka
afaaaaadabaaabiaacaaffjabbaaffkaafaaaaadabaaaciaacaaffjabcaaffka
afaaaaadabaaaeiaacaaffjabdaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabbaakkkaafaaaaadabaaaciaacaakkjabcaakkka
afaaaaadabaaaeiaacaakkjabdaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeia
ajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabeaaaakaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
abaaaaacabaaahoaabaaoeiaacaaaaadaeaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaapoabeaaffkappppaaaafdeieefcgaafaaaa
eaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 16 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, 1, 0, 0.5, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t5.xyz
dcl_2d s0
texld r0, t0, s0
mov r1.w, c0.w
mad_pp r1, r0.w, r1.w, -c1.x
mul_pp r0.xyz, r0, c0
texkill r1
mul_pp r1.xyz, r0, t5
mov_pp r0.w, c2.x
mov_pp oC0, r0
mov_pp r0, c2.y
mov_pp oC1, r0
mad_pp r0.xyz, t1, c2.z, c2.z
mov_pp r0.w, c2.x
mov_pp oC2, r0
exp_pp r0.x, -r1.x
exp_pp r0.y, -r1.y
exp_pp r0.z, -r1.z
mov_pp r0.w, c2.x
mov_pp oC3, r0

"
}
SubProgram "d3d11 " {
// Stats: 6 math, 1 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoiecfmambeepdpihhacjkkoepnibdghjabaaaaaahiadaaaaadaaaaaa
cmaaaaaaoeaaaaaagaabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoheaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaagiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaagiaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaagiaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcbaacaaaaeaaaaaaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaia
ebaaaaaaaaaaaaaaamaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeaddkaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
afaaaaaabjaaaaaghccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaaipccabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaaphccabaaaacaaaaaaegbcbaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadp
dgaaaaaficcabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 6 math, 1 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfhlibiolelpdkkaadmcbemlafjndfhbpabaaaaaaaeafaaaaaeaaaaaa
daaaaaaaliabaaaanaadaaaaiiaeaaaaebgpgodjiaabaaaaiaabaaaaaaacpppp
eaabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaajaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiiaaaaappka
aeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbafaaaaadaaaachiaaaaaoeia
aaaaoekaebaaaaababaaapiaafaaaaadabaachiaaaaaoeiaaeaaoelaabaaaaac
aaaaciiaacaaaakaabaaaaacaaaicpiaaaaaoeiaabaaaaacaaaacpiaacaaffka
abaaaaacabaicpiaaaaaoeiaaeaaaaaeaaaachiaabaaoelaacaakkkaacaakkka
abaaaaacaaaaciiaacaaaakaabaaaaacacaicpiaaaaaoeiaaoaaaaacaaaacbia
abaaaaibaoaaaaacaaaacciaabaaffibaoaaaaacaaaaceiaabaakkibabaaaaac
aaaaciiaacaaaakaabaaaaacadaicpiaaaaaoeiappppaaaafdeieefcbaacaaaa
eaaaaaaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaa
amaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeaddkaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaabjaaaaag
hccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadcaaaaaphccabaaaacaaaaaaegbcbaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaa
adaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheoheaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaagiaaaaaaabaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagiaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
giaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 13 math, 2 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, 1, 0, 0.5, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t5.xyz
dcl_2d s0
texld r0, t0, s0
mov r1.w, c0.w
mad_pp r1, r0.w, r1.w, -c1.x
mul_pp r0.xyz, r0, c0
texkill r1
mul_pp r1.xyz, r0, t5
mov_pp r0.w, c2.x
mov_pp oC0, r0
mov_pp r0, c2.y
mov_pp oC1, r0
mad_pp r0.xyz, t1, c2.z, c2.z
mov_pp r0.w, c2.x
mov_pp oC2, r0
mov_pp r1.w, c2.x
mov_pp oC3, r1

"
}
SubProgram "d3d11 " {
// Stats: 5 math, 1 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjhhkmannboffdgpdhcdfbolnpbljjapjabaaaaaagaadaaaaadaaaaaa
cmaaaaaaoeaaaaaagaabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoheaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaagiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaagiaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaagiaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiabaaaaeaaaaaaahoaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaia
ebaaaaaaaaaaaaaaamaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeaddkaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhccabaaaadaaaaaaegacbaaaaaaaaaaaegbcbaaa
afaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaaipccabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaaphccabaaa
acaaaaaaegbcbaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaaacaaaaaa
abeaaaaaaaaaiadpdgaaaaaficcabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 5 math, 1 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedoobabboiciodjghgeibnlkpllhhipdddabaaaaaamiaeaaaaaeaaaaaa
daaaaaaajeabaaaajeadaaaaemaeaaaaebgpgodjfmabaaaafmabaaaaaaacpppp
bmabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaajaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaabaaaaacabaaaiiaaaaappka
aeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbafaaaaadaaaachiaaaaaoeia
aaaaoekaebaaaaababaaapiaafaaaaadabaachiaaaaaoeiaaeaaoelaabaaaaac
aaaaciiaacaaaakaabaaaaacaaaicpiaaaaaoeiaabaaaaacaaaacpiaacaaffka
abaaaaacabaicpiaaaaaoeiaaeaaaaaeaaaachiaabaaoelaacaakkkaacaakkka
abaaaaacaaaaciiaacaaaakaabaaaaacacaicpiaaaaaoeiaabaaaaacabaaciia
acaaaakaabaaaaacadaicpiaabaaoeiappppaaaafdeieefcpiabaaaaeaaaaaaa
hoaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaajaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
dbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaead
dkaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaadaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadcaaaaaphccabaaaacaaaaaaegbcbaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaaf
iccabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheoheaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaagiaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaagiaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaagiaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback "Legacy Shaders/Transparent/Cutout/VertexLit"
}