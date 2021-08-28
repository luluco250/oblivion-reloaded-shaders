float4 HDRParam: register(c1);
float4 TESR_ReciprocalResolution: register(c17);
float4 TESR_ToneMapping: register(c19);

sampler2D ScreenSpace: register(s0);

// Resolution is specified as 4 decimal places for width followed by 4 decimal
// places for height after the period.
// Heights below 1000 must be specified with a leading zero.
float2 get_resolution() {
    float width = trunc(TESR_ToneMapping.z);
    float height = (TESR_ToneMapping.z - width) * 10000;
    return float2(width, height);
}

float4 main(float2 uv: TEXCOORD0): COLOR0 {
    float2 res = get_resolution();
    uv.y *= res.x / res.y;
    float4 color = max(tex2D(ScreenSpace, uv), 0);

    return color;
}
