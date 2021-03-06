//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
// Parameters:

row_major float4x4 ModelViewProj : register(c0);
float4 FogParam : register(c15);
float4 FogColor : register(c16);
row_major float4x4 TESR_ShadowCameraToLightTransform[2] : register(c34);

// Registers:
//
//   Name          Reg   Size
//   ------------- ----- ----
//   ModelViewProj[0] const_0        1
//   ModelViewProj[1] const_1        1
//   ModelViewProj[2] const_2        1
//   ModelViewProj[3] const_3        1
//   FogParam      const_15      1
//   FogColor      const_16      1
//


// Structures:

struct VS_INPUT {
    float4 LPOSITION : POSITION;
    float3 LTANGENT : TANGENT;
    float3 LBINORMAL : BINORMAL;
    float3 LNORMAL : NORMAL;
    float4 LTEXCOORD_0 : TEXCOORD0;
    float4 LCOLOR_0 : COLOR0;
};

struct VS_OUTPUT {
    float4 LPOSITION : POSITION;
	float4 LCOLOR_0 : COLOR0;
    float2 LTEXCOORD_0 : TEXCOORD0;
	float4 LTEXCOORD_1 : TEXCOORD1;
	float4 LTEXCOORD_2 : TEXCOORD2;
    float3 LTEXCOORD_3 : TEXCOORD3;
    float3 LTEXCOORD_4 : TEXCOORD4;
    float3 LTEXCOORD_5 : TEXCOORD5;
    float3 LTEXCOORD_6 : TEXCOORD6;
    float4 LTEXCOORD_7 : TEXCOORD7;
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

    float1 q0;
    float4 r0;
	
	r0.xyzw = mul(ModelViewProj, IN.LPOSITION.xyzw);
	q0.x = 1 - saturate((FogParam.x - length(r0.xyz)) / FogParam.y);
    OUT.LPOSITION.xyzw = r0.xyzw;
	OUT.LCOLOR_0.xyzw = IN.LCOLOR_0.xyzw;
    OUT.LTEXCOORD_0.xy = IN.LTEXCOORD_0.xy;
	OUT.LTEXCOORD_1.xyzw = mul(r0, TESR_ShadowCameraToLightTransform[0]);
	OUT.LTEXCOORD_2.xyzw = mul(r0, TESR_ShadowCameraToLightTransform[1]);
    OUT.LTEXCOORD_3.xyz = IN.LTANGENT.xyz;
    OUT.LTEXCOORD_4.xyz = IN.LBINORMAL.xyz;
    OUT.LTEXCOORD_5.xyz = IN.LNORMAL.xyz;
    OUT.LTEXCOORD_6.xyz = IN.LPOSITION.xyz;
    OUT.LTEXCOORD_7.xyz = FogColor.rgb;
    OUT.LTEXCOORD_7.w = q0.x * FogParam.z;
    return OUT;
	
};

// approximately 20 instruction slots used