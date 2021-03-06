//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
// Parameters:

row_major float4x4 ModelViewProj : register(c0);
row_major float4x4 WorldMat : register(c4);
float Tile : register(c8);
float4 QPosAdjust : register(c9);
float4 DepthOffset : register(c10);

// Registers:
//
//   Name          Reg   Size
//   ------------- ----- ----
//   ModelViewProj[0] const_0        1
//   ModelViewProj[1] const_1        1
//   ModelViewProj[2] const_2        1
//   ModelViewProj[3] const_3        1
//   WorldMat[0]      const_4        1
//   WorldMat[1]      const_5        1
//   WorldMat[2]      const_6        1
//   WorldMat[3]      const_7        1
//   Tile          const_8       1
//   QPosAdjust    const_9       1
//   DepthOffset   const_10      1
//


// Structures:

struct VS_INPUT {
    float4 LPOSITION : POSITION;
    float4 LTEXCOORD_0 : TEXCOORD0;
};

struct VS_OUTPUT {
    float4 position : POSITION;
    float4 texcoord_0 : TEXCOORD0;
    float4 texcoord_1 : TEXCOORD1;
    float4 texcoord_2 : TEXCOORD2;
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

    OUT.position.xyzw = mul(ModelViewProj, IN.LPOSITION.xyzw);
	OUT.texcoord_0.xyzw = IN.LTEXCOORD_0.xyzw;
    OUT.texcoord_1.xyzw = mul(WorldMat, IN.LPOSITION.xyzw);
    OUT.texcoord_2.xyzw = QPosAdjust.xyzw;
    return OUT;
	
};

// approximately 25 instruction slots used