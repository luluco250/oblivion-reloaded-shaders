float4 TimingData: register(c0);
float4 HDRParam: register(c1);
float4 TESR_ToneMapping: register(c19);

sampler2D ScreenSpace: register(s0);
sampler2D AvgLum: register(s1);

float4 main(float2 uv: TEXCOORD0): COLOR0 {
    float4 color = tex2D(ScreenSpace, uv);
    float4 avg = tex2D(AvgLum, uv);
    color = pow(abs(color), 2.2);
    color = lerp(avg, color, pow(abs(HDRParam.z), TimingData.z));
    color = clamp(color, 0.001, 3.0);
    color = pow(abs(color), 1.0 / 2.2);
    return color;
}
