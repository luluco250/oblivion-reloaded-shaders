//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
// Parameters:

float4 AmbientColor : register(c0);
float3 EyePosition : register(c1);
float3 HairTint : register(c2);
float3 MatAlpha : register(c3);
float4 ToggleADTS : register(c5);
float4 ToggleNumLights : register(c6);
float4 TESR_ShadowData : register(c8);
float4 LightData[8] : register(c9);

sampler2D BaseMap : register(s0);
sampler2D NormalMap : register(s1);
sampler2D AnisoMap : register(s4);
sampler2D LayerMap : register(s5);
sampler2D TESR_ShadowMapBufferNear : register(s6) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
sampler2D TESR_ShadowMapBufferFar : register(s7) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };

// Registers:
//
//   Name            Reg   Size
//   --------------- ----- ----
//   AmbientColor    const_0       1
//   EyePosition     const_1       1
//   HairTint        const_2       1
//   MatAlpha        const_3       1
//   ToggleADTS      const_5       1
//   ToggleNumLights const_6       1
//   LightData[0]       const_9        1
//   LightData[1]       const_10        1
//   LightData[2]       const_11        1
//   LightData[3]       const_12        1
//   LightData[4]       const_13        1
//   LightData[5]       const_14        1
//   LightData[6]       const_15        1
//   LightData[7]       const_16        1
//   BaseMap         texture_0       1
//   NormalMap       texture_1       1
//   AnisoMap        texture_4       1
//   LayerMap        texture_5       1
//


// Structures:

struct VS_INPUT {
    float2 LCOLOR_0 : COLOR0;
	float2 LTEXCOORD_0 : TEXCOORD0;
	float4 LTEXCOORD_1 : TEXCOORD1;
	float4 LTEXCOORD_2 : TEXCOORD2;
    float3 LTEXCOORD_3 : TEXCOORD3_centroid;
    float3 LTEXCOORD_4 : TEXCOORD4_centroid;
    float3 LTEXCOORD_5 : TEXCOORD5_centroid;
    float3 LTEXCOORD_6 : TEXCOORD6_centroid;
    float4 LTEXCOORD_7 : TEXCOORD7_centroid;
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
#define	shades(n, l)		saturate(dot(n, l))
#define	weight(v)		dot(v, 1)
#define	sqr(v)			((v) * (v))

    const int4 const_18 = {-1, -2, 0, 2};
    const int4 const_19 = {-2, -3, -4, 0};
    const int4 const_20 = {-4, -5, -6, 0};
    const float4 const_4 = {-0.05, 0, 0.7, 4};
    const float4 const_7 = {-0.5, 0, 1, 0.5};
    const int4 const_8 = {2, -6, -7, 0};

    float3 eye103;
    float1 l11;
    float3 l132;
    float3 l14;
    float3 l15;
    float1 l17;
    float3 l20;
    float3 l21;
    float1 l23;
    float3 l28;
    float1 l366;
    float3 l5;
    float3 l9;
    float3 m108;
    float3 m118;
    float3 m126;
    float3 m133;
    float3 q10;
    float1 q13;
    float3 q16;
    float1 q19;
    float3 q2;
    float3 q22;
    float1 q25;
    float3 q3;
    float3 q4;
    float3 q45;
    float3 q52;
    float3 q58;
    float1 q6;
    float3 q62;
    float3 q64;
    float3 q8;
    float4 r0;
    float4 r1;
    float3 r10;
    float3 r11;
    float3 r12;
    float3 r13;
    float3 r14;
    float3 r15;
    float2 r16;
    float4 r2;
    float4 r3;
    float4 r4;
    float4 r5;
    float3 r6;
    float4 r7;
    float3 r8;
    float3 r9;

#define	TanSpaceProj	float3x3(r12.xyz, r11.xyz, r10.xyz)
#define	TanSpaceProj	float3x3(r12.xyz, r11.xyz, r10.xyz)

    r1.xyzw = tex2D(NormalMap, IN.LTEXCOORD_0).xyzw;
    r5.xyz = normalize(expand(r1.xyz));
    r0.xyz = r5.xyz * 0.5;
    q2.xyz = r0.xyz + const_7.yyz;
    r0.w = r0.z + 1;
    r0.xyz = q2.xyz / sqrt(dot(r0.xyw, q2.xyz));
    r0.w = r0.x - 0.05;
    q3.xyz = r0.xyz + const_4.xyy;
    r8.xyz = q3.xyz / sqrt(dot(r0.wyz, q3.xyz));
    r10.xyz = normalize(IN.LTEXCOORD_5.xyz);
    r11.xyz = normalize(IN.LTEXCOORD_4.xyz);
    r12.xyz = normalize(IN.LTEXCOORD_3.xyz);
    r4.xyz = mul(TanSpaceProj, LightData[1].xyz);
    eye103.xyz = mul(TanSpaceProj, EyePosition.xyz - IN.LTEXCOORD_6.xyz);
    r9.xyz = normalize(eye103.xyz);
    q4.xyz = normalize(r4.xyz + r9.xyz);
    r2.x = dot(r8.xyz, r4.xyz);
    r2.y = dot(r8.xyz, q4.xyz);
    r2.xyzw = tex2D(AnisoMap, r2.xy);
    r3.x = dot(r0.xyz, r4.xyz);
    r3.y = dot(r0.xyz, q4.xyz);
    r3.xyzw = tex2D(AnisoMap, r3.xy);
    r6.xyz = const_7.xyz;
    r4.w = (ToggleNumLights.x <= 0.0 ? r6.y : r6.z);

    if (r4.w != 0) {
      r0.w = 1;
	  q6.x = GetLightAmount(IN.LTEXCOORD_1, IN.LTEXCOORD_2);
      l5.xyz = ((r2.w * (2 * ((IN.LCOLOR_0.y * (r6.x + HairTint.rgb)) + 0.5))) + (r3.w * 0.7)) * LightData[0].xyz;
      r1.xyz = max(r4.z, 0) * l5.xyz * q6.x;
      r4.xyz = q6.x * shade(r5.xyz, r4.xyz) * LightData[0].xyz;
    }
    else {
      r0.w = 0;
      r4.xyz = r0.w;
      r1.xyz = r0.w;
    }

    q6.x = min(ToggleNumLights.y, 4 - ToggleNumLights.x);
    r13.x = 2 * r0.w;
    r13.yz = r13.x + const_18.xy;
    q8.xyz = r13.x + const_18.zxy;
    r14.xyz = (q8.xyz >= 0.0 ? q8.xyz : -r13.xyz);
    l9.xyz = (r14.z <= 0.0 ? LightData[3].xyz : (r14.y <= 0.0 ? LightData[2].xyz : (r14.x <= 0.0 ? LightData[1].xyz : r6.y)));
    r15.xyz = l9.xyz - IN.LTEXCOORD_6.xyz;
    m108.xyz = mul(TanSpaceProj, r15.xyz);
    r7.xyz = normalize(m108.xyz);
    q10.xyz = normalize(r9.xyz + r7.xyz);
    r16.x = dot(r8.xyz, r7.xyz);
    r16.y = dot(r8.xyz, q10.xyz);
    r2.xyzw = tex2D(AnisoMap, r16.xy);
    r3.x = dot(r0.xyz, r7.xyz);
    r3.y = dot(r0.xyz, q10.xyz);
    r3.xyzw = tex2D(AnisoMap, r3.xy);
    r4.w = ((q6.x >= 0.0 ? 0 : 1) * (frac(q6.x) <= 0.0 ? 0 : 1)) + (q6.x - frac(q6.x));
    r5.w = (r4.w <= 0.0 ? 0 : 1);

    if (r5.w != 0) {
      r2.xyz = r13.x + const_18.zxy;
      r5.w = r0.w + 1;
      l14.xyz = (r2.z == 0.0 ? LightData[2].xyz : (r2.y == 0.0 ? LightData[1].xyz : (r2.x == 0.0 ? LightData[0].xyz : r6.y)));
      q45.xyz = (r2.w * ((0.3 * ((IN.LCOLOR_0.y * (r6.x + HairTint.rgb)) + 0.5)) + 0.2)) + (r3.w * 0.7);
      l11.x = (r14.z <= 0.0 ? LightData[3].w : (r14.y <= 0.0 ? LightData[2].w : (r14.x <= 0.0 ? LightData[1].w : r6.y)));
      q13.x = 1.0 - sqr(saturate(length(r15.xyz) / l11.x));
      r1.xyz = (max(r7.z, 0) * ((q13.x * l14.xyz) * q45.xyz)) + r1.xyz;
      r4.xyz = (max(dot(r5.xyz, r7.xyz) * q13.x, 0) * l14.xyz) + r4.xyz;
    }
    else {
      r5.w = r0.w;
    }

    r7.w = 2 * r5.w;
    r13.xyz = r7.w + const_19.xyz;
    l15.xyz = (r13.z == 0.0 ? LightData[5].xyz : (r13.y == 0.0 ? LightData[4].xyz : (r13.x == 0.0 ? LightData[3].xyz : r6.y)));
    r14.xyz = l15.xyz - IN.LTEXCOORD_6.xyz;
    m118.xyz = mul(TanSpaceProj, r14.xyz);
    r7.xyz = normalize(m118.xyz);
    q16.xyz = normalize(r9.xyz + r7.xyz);
    r15.x = dot(r8.xyz, r7.xyz);
    r15.y = dot(r8.xyz, q16.xyz);
    r2.xyzw = tex2D(AnisoMap, r15.xy);
    r3.x = dot(r0.xyz, r7.xyz);
    r3.y = dot(r0.xyz, q16.xyz);
    r3.xyzw = tex2D(AnisoMap, r3.xy);

    if (r4.w != 1) {
      r2.xyz = r7.w + const_19.xyz;
      r5.w = r5.w + 1;
      l20.xyz = (r2.z == 0.0 ? LightData[4].xyz : (r2.y == 0.0 ? LightData[3].xyz : (r2.x == 0.0 ? LightData[2].xyz : r6.y)));
      q52.xyz = (r2.w * ((0.3 * ((IN.LCOLOR_0.y * (r6.x + HairTint.rgb)) + 0.5)) + 0.2)) + (r3.w * 0.7);
      l17.x = (r13.z == 0.0 ? LightData[5].w : (r13.y == 0.0 ? LightData[4].w : (r13.x == 0.0 ? LightData[3].w : r6.y)));
      q19.x = 1.0 - sqr(saturate(length(r14.xyz) / l17.x));
      r1.xyz = (max(r7.z, 0) * ((q19.x * l20.xyz) * q52.xyz)) + r1.xyz;
      r4.xyz = (max(dot(r5.xyz, r7.xyz) * q19.x, 0) * l20.xyz) + r4.xyz;
    }

    r7.w = 2 * r5.w;
    r13.xyz = r7.w + const_20.xyz;
    l21.xyz = (r13.z == 0.0 ? LightData[7].xyz : (r13.y == 0.0 ? LightData[6].xyz : (r13.x == 0.0 ? LightData[5].xyz : r6.y)));
    r14.xyz = l21.xyz - IN.LTEXCOORD_6.xyz;
    m126.xyz = mul(TanSpaceProj, r14.xyz);
    r7.xyz = normalize(m126.xyz);
    q22.xyz = normalize(r9.xyz + r7.xyz);
    r15.x = dot(r8.xyz, r7.xyz);
    r15.y = dot(r8.xyz, q22.xyz);
    r2.xyzw = tex2D(AnisoMap, r15.xy);
    r3.x = dot(r0.xyz, r7.xyz);
    r3.y = dot(r0.xyz, q22.xyz);
    r3.xyzw = tex2D(AnisoMap, r3.xy);

    if (r4.w != 2) {
      r2.xyz = r7.w + const_20.xyz;
      r5.w = r5.w + 1;
      l132.xyz = (r2.z == 0.0 ? LightData[6].xyz : (r2.y == 0.0 ? LightData[5].xyz : (r2.x == 0.0 ? LightData[4].xyz : r6.y)));
      q58.xyz = (r2.w * ((0.3 * ((IN.LCOLOR_0.y * (r6.x + HairTint.rgb)) + 0.5)) + 0.2)) + (r3.w * 0.7);
      l23.x = (r13.z == 0.0 ? LightData[7].w : (r13.y == 0.0 ? LightData[6].w : (r13.x == 0.0 ? LightData[5].w : r6.y)));
      q25.x = 1.0 - sqr(saturate(length(r14.xyz) / l23.x));
      r1.xyz = (max(r7.z, 0) * ((q25.x * l132.xyz) * q58.xyz)) + r1.xyz;
      r4.xyz = (max(dot(r5.xyz, r7.xyz) * q25.x, 0) * l132.xyz) + r4.xyz;
    }

    r7.xyz = LightData[7].xyz - IN.LTEXCOORD_6.xyz;
    m133.xyz = mul(TanSpaceProj, r7.xyz);
    r3.xyz = normalize(m133.xyz);
    r9.xyz = r9.xyz + r3.xyz;
    r2.xyz = normalize(r9.xyz);
    r9.x = dot(r8.xyz, r3.xyz);
    r9.y = dot(r8.xyz, r2.xyz);
    r2.y = dot(r0.xyz, r2.xyz);
    r2.x = dot(r0.xyz, r3.xyz);
    r0.xyzw = tex2D(AnisoMap, r9.xy);
    r2.xyzw = tex2D(AnisoMap, r2.xy);

    if (r4.w != 3) {
      r3.w = dot(r5.xyz, r3.xyz);
      l366.x = 1.0 - sqr(saturate(length(r7.xyz) / LightData[7].w));
      q62.xyz = (r0.w * ((0.3 * ((IN.LCOLOR_0.y * (r6.x + HairTint.rgb)) + 0.5)) + 0.2)) + (r2.w * 0.7);
      r3.xy = (2 * r5.w) + const_8.yz;
      l28.xyz = (r3.y == 0.0 ? LightData[7].xyz : (r3.x == 0.0 ? LightData[6].xyz : r6.y));
      r1.xyz = (max(r3.z, 0) * ((l366.x * l28.xyz) * q62.xyz)) + r1.xyz;
      r4.xyz = (max(r3.w * l366.x, 0) * l28.xyz) + r4.xyz;
    }

    r2.xyzw = tex2D(LayerMap, IN.LTEXCOORD_0);
    r0.xyzw = tex2D(BaseMap, IN.LTEXCOORD_0);
    r3.xyz = r1.xyz * IN.LCOLOR_0.y;
    r1.xyz = lerp(r0.xyz, r2.xyz, r2.w);
    r0.xyz = r4.xyz + ((ToggleADTS.x * AmbientColor.rgb) + (r6.z - ToggleADTS.x));
    q64.xyz = (((2 * ((IN.LCOLOR_0.y * (r6.x + HairTint.rgb)) + 0.5)) * r1.xyz) * r0.xyz) + (r1.w * r3.xyz);
    OUT.color_0.a = r0.w * MatAlpha.x;
    OUT.color_0.rgb = (IN.LTEXCOORD_7.w * (IN.LTEXCOORD_7.xyz - q64.xyz)) + q64.xyz;
    return OUT;
	
};

// approximately 300 instruction slots used (13 texture, 287 arithmetic)