//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
// Parameters:

float4 AmbientColor : register(c1);
float4 PSLightColor[4] : register(c2);
float4 Toggles : register(c7);
float4 TESR_ShadowData : register(c8);

sampler2D BaseMap : register(s0);
sampler2D NormalMap : register(s1);
sampler2D TESR_ShadowMapBufferNear : register(s6) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
sampler2D TESR_ShadowMapBufferFar : register(s7) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };

// Registers:
//
//   Name         Reg   Size
//   ------------ ----- ----
//   AmbientColor const_1       1
//   PSLightColor[0] const_2        1
//   Toggles      const_7       1
//   BaseMap      texture_0       1
//   NormalMap    texture_1       1
//


// Structures:

struct VS_INPUT {
    float2 BaseUV : TEXCOORD0;
    float3 texcoord_1 : TEXCOORD1_centroid;
    float3 texcoord_3 : TEXCOORD3_centroid;
	float4 texcoord_6 : TEXCOORD6;
	float4 texcoord_7 : TEXCOORD7;
    float3 LCOLOR_0 : COLOR0;
    float4 LCOLOR_1 : COLOR1;
};

struct VS_OUTPUT {
    float4 color_0 : COLOR0;
};

#include "..\Includes\Shadow.hlsl"

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

#define	expand(v)		(((v) - 0.5) / 0.5)
#define	compress(v)		(((v) * 0.5) + 0.5)
#define	shade(n, l)		max(dot(n, l), 0)
#define	shades(n, l)	saturate(dot(n, l))

    float4 noxel0;
    float3 q10;
    float1 q2;
    float3 q3;
	float3 q4;
    float1 q7;
    float4 r0;
    float3 r1;
	float Shadow;
	
    noxel0.xyzw = tex2D(NormalMap, IN.BaseUV.xy);
    r0.xyzw = tex2D(BaseMap, IN.BaseUV.xy);
	q4.xyz = normalize(expand(noxel0.xyz));
    q7.x = noxel0.w * pow(abs(shades(q4.xyz, normalize(IN.texcoord_3.xyz))), Toggles.z);
    q2.x = dot(q4.xyz, IN.texcoord_1.xyz);
    q3.xyz = saturate((0.2 >= q2.x ? (q7.x * max(q2.x + 0.5, 0)) : q7.x) * PSLightColor[0].rgb);
    r1.xyz = (Toggles.x <= 0.0 ? r0.xyz : (r0.xyz * IN.LCOLOR_0.xyz));
	Shadow = GetLightAmount(IN.texcoord_6, IN.texcoord_7);
    q10.xyz = (r1.xyz * max((Shadow * saturate(q2.x) * PSLightColor[0].rgb) + AmbientColor.rgb, 0)) + (q3.xyz * Shadow);
    OUT.color_0.a = r0.w * AmbientColor.a;
    OUT.color_0.rgb = (Toggles.y <= 0.0 ? q10.xyz : lerp(q10.xyz, IN.LCOLOR_1.xyz, IN.LCOLOR_1.w));
    return OUT;
	
};

// approximately 33 instruction slots used (2 texture, 31 arithmetic)