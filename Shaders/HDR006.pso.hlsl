float4 TimingData: register(c0);
float4 HDRParam: register(c1);
float4 TESR_ToneMapping: register(c19);

sampler2D ScreenSpace: register(s0);
sampler2D AvgLum: register(s1);

// We don't really care for adjustable gamma through the "Linearization"
// setting, let's use a constant instead which helps optimize the calculation.
static const float Gamma = 2.2;
static const float4 MinColor = 0.001;
static const float4 MaxColor = 3.0;
static const float TimeScale = 0.333;

float4 main(float2 uv: TEXCOORD0): COLOR0 {
    float4 color = tex2D(AvgLum, uv);
    float4 last = tex2D(ScreenSpace, uv);

    // Linearize.
    last = pow(abs(last), Gamma);

    // Interpolation between the current and last colors.
    float t = 1.0 - pow(abs(HDRParam.z), TimingData.z);
    color = lerp(last, color, saturate(t * TimeScale));

    // Clamping to avoid sudden big changes like when quicksaving or looking at
    // a very bright object.
    color = clamp(color, MinColor, MaxColor);

    // Delinearize.
    color = pow(abs(color), 1.0 / Gamma);

    return color;
}
