float4 HDRParam: register(c1);
float4 TESR_ToneMapping: register(c19);

sampler2D ScreenSpace: register(s0);
sampler2D DestBlend: register(s1);
sampler2D AvgLum: register(s2);

#include "Includes/Color.hlsl"

float to_luma(float3 color) {
	return dot(color, float3(0.299, 0.587, 0.114));
}

float3 tonemap_aces(float3 color, float3 white) {
    static const float A = 0.0245786;
	static const float B = 0.000090537;
	static const float C = 0.983729;
	static const float D = 0.4329510;
	static const float E = 0.238081;

    color = (color * (color + A) - B) / (color * (C * color + D) + E);
    white = (white * (white + A) - B) / (white * (C * white + D) + E);
    return saturate(color / white);
}

float2 get_resolution() {
    float width = trunc(TESR_ToneMapping.z);
    float height = (TESR_ToneMapping.z - width) * 10000;
    return float2(width, height);
}

float4 main(float2 uv: TEXCOORD1, float2 bloom_uv: TEXCOORD0): COLOR0 {
    // Some game objects (specially darker skin colors) go to negative values,
    // so we need to clip that before tonemapping.
    float4 color = max(tex2D(DestBlend, uv), 0);

    float2 res = get_resolution();
    bloom_uv.y *= res.y / res.x;

    float4 bloom = tex2D(ScreenSpace, bloom_uv);
    color = (
        lerp(color, bloom, TESR_ToneMapping.y) +
        max(color, bloom * TESR_ToneMapping.y)
    ) * 0.5;

    float adapt = to_luma(tex2D(AvgLum, uv).rgb);
    color /= clamp(adapt * TESR_ToneMapping.x, 0.5, 2.0);

    color.rgb = tonemap_aces(color.rgb, GetWhitePoint());

    return color;
}
