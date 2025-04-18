#ifndef THETOONSHADER_FUNCTION
#define THETOONSHADER_FUNCTION







        































struct GeneralStylingData
{
    half enableDistanceFade;
    float distanceFadeStartDistance;
    float distanceFadeFalloff;
    half adjustDistanceFadeValue;
    float distanceFadeValue;
};


struct StylingData
{
    half isEnabled;
    half style;
    half type;
    float4 color;
    float rotation;
    float rotationBetweenCells;
    float density;
    float offset;
    float size;
    float sizeControl;
    float sizeFalloff;
    float roundness;
    float roundnessFalloff;
    float hardness;
    float opacity;
    float opacityFalloff;
};

struct StylingRandomData
{
    float enableRandomizer;
    float perlinNoiseSize;
    float perlinNoiseSeed;
    float whiteNoiseSeed;
    
    float noiseIntensity;
    
    half spacingRandomMode;
    float spacingRandomIntensity;

    half opacityRandomMode; 
    float opacityRandomIntensity;

    half lengthRandomMode;
    float lengthRandomIntensity;

    half hardnessRandomMode;
    float hardnessRandomIntensity;

    half thicknessRandomMode; 
    float thicknesshRandomIntensity;
    
   
   

};

struct AdditionalStylingSpecularData
{
    
};

struct AdditionalStylingRimData
{
    
};

struct PositionAndBlendingData
{
    half position;
    half blending;
    half isInverted;
};

struct UVSpaceData
{
    half drawSpace;
    half coordinateSystem;
    half polarCenterMode;
    float4 polarCenter;
    half sSCameraDistanceScaled;
    half anchorSSToObjectsOrigin;
};


struct NoiseSampleData
{
    float perlinNoise;
    float perlinNoiseFloored;
    float whiteNoise;
    float whiteNoiseFloored;
};

struct RequiredNoiseData
{
    bool perlinNoise;
    bool perlinNoiseFloored;
    bool whiteNoise;
    bool whiteNoiseFloored;
};


#define UNITY_TWO_PI        6.28318530718f
float sum(
float3 ll0
)
{
   return dot(ll0, float3(1, 1, 1));
}
float invLerp(
float llll0, float lllll0, float llllll0
)
{
    return (llllll0 - llll0) / (lllll0 - llll0);
}
float4 invLerp(
float4 llll0, float4 lllll0, float4 llllll0
)
{
    return (llllll0 - llll0) / (lllll0 - llll0);
}
float remap(
float llllllllllll0, float lllllllllllll0, float llllllllllllll0, float lllllllllllllll0, float llllll0
)
{
    float lllllllllllllllll0 = invLerp(llllllllllll0, lllllllllllll0, llllll0);
    return lerp(llllllllllllll0, lllllllllllllll0, lllllllllllllllll0);
}
float2 GetScreenUV(
float2 lllllllllllllllllll0, float llllllllllllllllllll0
)
{
#if _URP
    float4 lllllllllllllllllllll0 = TransformObjectToHClip(float3(0, 0, 0));
#else
    float4 lllllllllllllllllllll0 = UnityObjectToClipPos(float3(0, 0, 0));
#endif
    float2 lllllllllllllllllllllll0 = float2(lllllllllllllllllll0.x, lllllllllllllllllll0.y);
    float llllllllllllllllllllllll0 = _ScreenParams.y / _ScreenParams.x;
    lllllllllllllllllllllll0.x -= lllllllllllllllllllll0.x / (lllllllllllllllllllll0.w);
    lllllllllllllllllllllll0.y -= lllllllllllllllllllll0.y / (lllllllllllllllllllll0.w);
    lllllllllllllllllllllll0.y *= llllllllllllllllllllllll0;
    lllllllllllllllllllllll0 *= 1 / llllllllllllllllllll0;
    lllllllllllllllllllllll0 *= lllllllllllllllllllll0.z;
    return lllllllllllllllllllllll0;
};
float2 toPolar(
float2 llllllllllllllllllllllllll0
)
{
    float lllllllllllllllllllllllllll0 = length(llllllllllllllllllllllllll0);
    float llllllllllllllllllllllllllll0 = atan2(llllllllllllllllllllllllll0.y, llllllllllllllllllllllllll0.x);
    return float2(llllllllllllllllllllllllllll0 / UNITY_TWO_PI, lllllllllllllllllllllllllll0);
}
float2 ConvertToDrawSpace(
#if _URP
    InputData inputData, 
#else
    float3 llllllllllllllllllllllllllllll0,
#endif
float2 lllllllllllllllllllllllllllllll0, UVSpaceData uvSpaceData , float4 lllllllllllllllllllllll0
)
{
    if (uvSpaceData.drawSpace == 0)    
    {
    }
    else if (uvSpaceData.drawSpace = 1)    
    {
#if _URP
        float3 llllllllllllllllllllllllllllll0 = inputData.positionWS;
#endif
        float4 lllllllllllllllllll0 = mul(UNITY_MATRIX_VP, float4(llllllllllllllllllllllllllllll0, 1.0));
        float4 llll1 = ComputeScreenPos(lllllllllllllllllll0);
        lllllllllllllllllllllllllllllll0 = ((llll1.xy) / llll1.w); 
        if (uvSpaceData.anchorSSToObjectsOrigin)
        {
            float4 lllll1 = mul(UNITY_MATRIX_VP, float4(_WorldSpaceCameraPos, 1.0));
            float2 llllll1 = lllll1.xy / lllll1.w;
            float2 lllllll1 = lllllllllllllllllllllll0.xy;
            lllllllllllllllllllllllllllllll0 = lllllllllllllllllllllllllllllll0 - lllllll1; 
        }
    }
    else 
    {
    }
    if (uvSpaceData.coordinateSystem == 1) 
    {
        if (uvSpaceData.drawSpace == 1)
        {
            if (uvSpaceData.polarCenterMode == 0) 
            {
                lllllllllllllllllllllllllllllll0.xy -= uvSpaceData.polarCenter.xy;
            }
            else 
            {
                uvSpaceData.polarCenter.a = 1;
                float4 llllllll1 = mul(UNITY_MATRIX_VP, uvSpaceData.polarCenter);
                float4 lllllllll1 = ComputeScreenPos(llllllll1);
                float2 llllllllll1 = lllllllll1.xy / lllllllll1.w;
                lllllllllllllllllllllllllllllll0.xy -= llllllllll1;
            }
        }
        else
        {
            lllllllllllllllllllllllllllllll0.xy -= uvSpaceData.polarCenter.xy;
        }
    }
    if (uvSpaceData.coordinateSystem == 1) 
    {
        lllllllllllllllllllllllllllllll0 = toPolar(lllllllllllllllllllllllllllllll0);
    }
    if (uvSpaceData.drawSpace == 1)
    {
        if (uvSpaceData.sSCameraDistanceScaled == 1)
        {
            float3 lllllllllll1 = mul(UNITY_MATRIX_M, float4(0, 0, 0, 1.0)).xyz;
            lllllllllllllllllllllllllllllll0.xy *= distance(_WorldSpaceCameraPos, lllllllllll1);
        }
        float llllllllllll1 = _ScreenParams.x / _ScreenParams.y;
        lllllllllllllllllllllllllllllll0.x *= llllllllllll1;
    }
    return lllllllllllllllllllllllllllllll0;
}
float CalculateSpecularMask(
float3 llllllllllllll1, float3 lllllllllllllll1, float3 llllllllllllllll1, float lllllllllllllllll1, float llllllllllllllllll1, float lllllllllllllllllll1
)
{
    float llllllllllllllllllll1 = 0;
    float3 lllllllllllllllllllll1 = normalize(lllllllllllllll1 + llllllllllllllll1);
    float llllllllllllllllllllll1 = dot(llllllllllllll1, lllllllllllllllllllll1);
    float lllllllllllllllllllllll1 = (1 - (lllllllllllllllll1)) * 10; 
    llllllllllllllllllllll1 = max(llllllllllllllllllllll1, 0); 
    float llllllllllllllllllllllll1 = pow(llllllllllllllllllllll1, lllllllllllllllllllllll1 * lllllllllllllllllllllll1);
    float lllllllllllllllllllllllll1 = smoothstep(0.8, 0.8 + llllllllllllllllll1 / 1, llllllllllllllllllllllll1);
    if (lllllllllllllllllll1 > 0.0)
    {
        llllllllllllllllllll1 = lllllllllllllllllllllllll1;
    }
    return llllllllllllllllllll1;
}
float CalculateRimMask(
float3 lllllllllllllllllllllllllll1, float3 lllllllllllllll1, float3 llllllllllllllll1, float llllllllllllllllllllllllllllll1, float lllllllllllllllllllllllllllllll1, float lllllllllllllllllll1,
                        half ll2, half lll2, half llll2, float lllll2
)
{
    float llllll2 = 0;         
    float lllllll2 = saturate(1 - dot(llllllllllllllll1, lllllllllllllllllllllllllll1));
    llllllllllllllllllllllllllllll1 = 1 - llllllllllllllllllllllllllllll1;
    float llllllll2 = smoothstep(saturate(llllllllllllllllllllllllllllll1 - lllllllllllllllllllllllllllllll1), llllllllllllllllllllllllllllll1, lllllll2);
    if ((ll2 == 0 && lllllllllllllllllll1 > 0.0 && ((lllll2 >= 0 || lll2 == 0) || llll2 == 0))
    || (ll2 == 1 && (lllllllllllllllllll1 <= 0.0 || (lllll2 <= 2 && lll2 == 1)))
    || ll2 == 2 )
    {
        if (ll2 == 1)
        {
            if (lll2)
            {
                llllll2 = llllllll2 * (1 - lllll2);
            }
            else
            {
                float lllllllll2 = 1 - abs(min(lllllllllllllllllll1 * 2 , 0)); 
                float ll0 = lerp(0, lllllllll2 * 4, lllllllllllllllllllllllllllllll1);
                llllll2 = llllllll2 * (1 - lllllllll2);
            }
        }
        else if (ll2 == 2)
        {
            llllll2 = llllllll2;
        }
        else
        {
            llllll2 = llllllll2 * (lllllllllllllllllll1* 2) * (lllll2);
        }
    }
    return llllll2;
}
float2 RotateUV(
float2 lllllllllllllllllllllllllllllll0, float llllllllllllllllllllllllllll0
)
{
    float llllllllllllll2 = radians(llllllllllllllllllllllllllll0);
    float lllllllllllllll2= cos(llllllllllllll2);
    float llllllllllllllll2= sin(llllllllllllll2);
    float2 lllllllllllllllll2;
    lllllllllllllllll2.x = lllllllllllllllllllllllllllllll0.x * lllllllllllllll2 - lllllllllllllllllllllllllllllll0.y * llllllllllllllll2;
    lllllllllllllllll2.y = lllllllllllllllllllllllllllllll0.x * llllllllllllllll2 + lllllllllllllllllllllllllllllll0.y * lllllllllllllll2;
    return lllllllllllllllll2;
}
float2 RotateUVRadians(
float2 lllllllllllllllllllllllllllllll0, float llllllllllllllllllll2
)
{
    float llllllllllllll2 = llllllllllllllllllll2;                
    float lllllllllllllll2 = cos(llllllllllllll2);
    float llllllllllllllll2 = sin(llllllllllllll2);
    float2 lllllllllllllllll2;
    lllllllllllllllll2.x = lllllllllllllllllllllllllllllll0.x * lllllllllllllll2 - lllllllllllllllllllllllllllllll0.y * llllllllllllllll2;
    lllllllllllllllll2.y = lllllllllllllllllllllllllllllll0.x * llllllllllllllll2 + lllllllllllllllllllllllllllllll0.y * lllllllllllllll2;
    return lllllllllllllllll2;
}
NoiseSampleData SampleNoiseData(
float2 lllllllllllllllllllllllllllllll0, StylingData stylingData, StylingRandomData stylingRandomData, RequiredNoiseData requiredNoiseData, sampler2D llllllllllllllllllllllllll2, sampler2D lllllllllllllllllllllllllll2
)
{
    NoiseSampleData noiseSampleData;
    if (stylingRandomData.enableRandomizer == 1)
    {
        if (stylingData.style == 1)
        {
            if (fmod(floor(lllllllllllllllllllllllllllllll0.y * stylingData.density), 2) == 0)
            {
                lllllllllllllllllllllllllllllll0.x += stylingData.offset / stylingData.density;
            }
        }
        float llllllllllllllllllllllllllll2 = 0;
        if (requiredNoiseData.perlinNoiseFloored == 1)
        {
            float2 lllllllllllllllllllllllllllll2 = lllllllllllllllllllllllllllllll0;
            lllllllllllllllllllllllllllll2.x = floor(lllllllllllllllllllllllllllllll0.x * stylingData.density) / stylingData.density;
            if (stylingData.style == 0)
            {
            }
            else if (stylingData.style == 1)
            {
                lllllllllllllllllllllllllllll2.y = floor(lllllllllllllllllllllllllllllll0.y * stylingData.density) / stylingData.density;
            }
            lllllllllllllllllllllllllllll2 *= stylingRandomData.perlinNoiseSize;
            llllllllllllllllllllllllllll2 = tex2Dlod(llllllllllllllllllllllllll2, float4(lllllllllllllllllllllllllllll2, 0.0, 0.0)).x; 
        }
        float llllllllllllllllllllllllllllll2 = 0;
        if (requiredNoiseData.perlinNoise == 1)
        {
            float2 lllllllllllllllllllllllllllllll2 = lllllllllllllllllllllllllllllll0 * stylingRandomData.perlinNoiseSize;
            llllllllllllllllllllllllllllll2 = tex2Dlod(llllllllllllllllllllllllll2, float4(lllllllllllllllllllllllllllllll2, 0.0, 0.0)).x; 
        }
        float l3 = 0;
        if (requiredNoiseData.whiteNoise == 1)
        {
            float2 ll3 = lllllllllllllllllllllllllllllll0;
            ll3.x = floor(lllllllllllllllllllllllllllllll0.x * stylingData.density) / stylingData.density;
            if (stylingData.style == 0)
            {
                ll3.y = 0.1;
            }
            else
            if (stylingData.style == 1)
            {
                ll3.y = floor(lllllllllllllllllllllllllllllll0.y * stylingData.density) / stylingData.density;
            }
            l3 = tex2Dlod(lllllllllllllllllllllllllll2, float4(ll3, 0.0, 0.0)).x; 
        }
        float lll3;
        if (requiredNoiseData.whiteNoiseFloored == 1)
        {
            float2 llll3 = lllllllllllllllllllllllllllllll0;
            llll3.x = floor(lllllllllllllllllllllllllllllll0.x * stylingData.density) / stylingData.density;
            if (stylingData.style == 1)
            {
                llll3.y = 0.1;
            }
            lll3 = tex2Dlod(lllllllllllllllllllllllllll2, float4(llll3, 0.0, 0.0)).x; 
        }
        noiseSampleData.perlinNoise = llllllllllllllllllllllllllllll2;
        noiseSampleData.perlinNoiseFloored = llllllllllllllllllllllllllll2;
        noiseSampleData.whiteNoise = l3;
        noiseSampleData.whiteNoiseFloored = lll3;
    }
    else
    {
        noiseSampleData.perlinNoise = 0;
        noiseSampleData.perlinNoiseFloored = 0;
        noiseSampleData.whiteNoise = 0;
        noiseSampleData.whiteNoiseFloored = 0;
    }
    return noiseSampleData;
}
float Hatching(
float llllll0, float2 lllllllllllllllllllllllllllllll0, StylingData hatchingData, StylingRandomData stylingRandomData, NoiseSampleData noiseSampleData, half llllllll3
)
{
    llllll0 = 1 - llllll0;   
    float2 lllllllll3 = lllllllllllllllllllllllllllllll0;      
    float llllllllll3 = hatchingData.size / 2;    
    float lllllllllll3 = lllllllll3.x;            
    lllllllllll3 *= hatchingData.density;
    if (stylingRandomData.enableRandomizer == 1)
    {
        lllllllllll3 += noiseSampleData.perlinNoise * stylingRandomData.noiseIntensity;
        float llllllllllll3 = 0;
        if (stylingRandomData.thicknessRandomMode == 0)
        {
            llllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.thicknessRandomMode == 1) 
        {
            llllllllllll3 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllll3 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        llllllllllll3 *= stylingRandomData.thicknesshRandomIntensity;
        float lllllllllllll3 = remap(0, 1, 0.0, llllllllll3, llllllllllll3);
        llllllllll3 -= lllllllllllll3;
        float llllllllllllll3 = 0;
        if (stylingRandomData.spacingRandomMode == 0)
        {
            llllllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.spacingRandomMode == 1) 
        {
            llllllllllllll3 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllllll3 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        float lllllllllllllll3 = remap(0, 1, -0.5 + llllllllll3, 0.5 - llllllllll3, llllllllllllll3);
        lllllllllll3 += lllllllllllllll3 * stylingRandomData.spacingRandomIntensity * saturate(1 - stylingRandomData.noiseIntensity); 
    }
    lllllllllll3 = abs(frac(lllllllllll3) - 0.5);
    float llllllllllllllll3 = 0;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllll3 = 0;
        if (stylingRandomData.lengthRandomMode == 0)
        {
            lllllllllllllllll3 = noiseSampleData.whiteNoise * saturate(1 - stylingRandomData.noiseIntensity); 
        }
        else if (stylingRandomData.lengthRandomMode == 1)
        {
            lllllllllllllllll3 = noiseSampleData.perlinNoiseFloored; 
        }
        else
        {
            lllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + (noiseSampleData.whiteNoise * saturate(1 - stylingRandomData.noiseIntensity))) / 2); 
        }
        float llllllllllllllllll3 = lllllllllllllllll3 * stylingRandomData.lengthRandomIntensity;
        llllllllllllllll3 = remap(0, 1 - llllllllllllllllll3, 0, 1, llllll0);    
    }
    else
    {
        llllllllllllllll3 = remap(0, 1, 0, 1, llllll0);;
    }    
    float lllllllllllllllllll3 = smoothstep(min(1 - hatchingData.sizeFalloff, 0.99), 1, llllllllllllllll3);
    lllllllllllllllllll3 = max(llllllllll3 - lllllllllllllllllll3, 0);
    float llllllllllllllllllll3 = 0;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllllllll3 = 0;
        if (stylingRandomData.hardnessRandomMode == 0) 
        {
            lllllllllllllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.hardnessRandomMode == 1) 
        {
            lllllllllllllllllllll3 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else
        {
            lllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        llllllllllllllllllll3 = remap(0, 1, 0, lllllllllllllllllll3, min(saturate(hatchingData.hardness - lllllllllllllllllllll3 * stylingRandomData.hardnessRandomIntensity), hatchingData.hardness));
    }
    else
    {
        llllllllllllllllllll3 = remap(0, 1, 0, lllllllllllllllllll3, hatchingData.hardness);
    }
    if (lllllllllllllllllll3 != 0 )
    {
        float llllllllllllllllllllll3 = 0;
        if (llllllll3)
        {
            llllllllllllllllllllll3 = fwidth(lllllllllll3); 
        }
        if (lllllllllllllllllll3 == llllllllll3 && hatchingData.size == 1)
        {
            llllllllllllllllllllll3 = 0;
        }                        
        if (llllllllllllllllllll3 - llllllllllllllllllllll3 < 0) 
        {
            llllllllllllllllllllll3 = 0;
        }
        lllllllllll3 = smoothstep(llllllllllllllllllll3 - llllllllllllllllllllll3, lllllllllllllllllll3 + llllllllllllllllllllll3, lllllllllll3);
    }
    else
    {
        lllllllllll3 = 1; 
    }
    lllllllllll3 = 1 - lllllllllll3;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllllllllll3;
        if (stylingRandomData.opacityRandomMode == 0) 
        {
            lllllllllllllllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.opacityRandomMode == 1) 
        {
            lllllllllllllllllllllll3 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else 
        {
            lllllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored * 5) + noiseSampleData.whiteNoise) / 2;
            lllllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        lllllllllll3 = saturate(lllllllllll3 - (lllllllllllllllllllllll3 * stylingRandomData.opacityRandomIntensity));
    }
    float llllllllllllllllllllllll3 = smoothstep(min(1-hatchingData.opacityFalloff, 0.99), 1, llllllllllllllll3);
    lllllllllll3 *= 1 - llllllllllllllllllllllll3;
    lllllllllll3 *= hatchingData.opacity;
    return lllllllllll3;
}
float Halftones(
float llllll0, float2 lllllllllllllllllllllllllllllll0, StylingData halftonesData, StylingRandomData stylingRandomData, NoiseSampleData noiseSampleData
)
{            
    float2 llllllllllllllllllllllllllll3 = lllllllllllllllllllllllllllllll0;               
    llllllllllllllllllllllllllll3 *= halftonesData.density;
    if (stylingRandomData.enableRandomizer == 1)
    {
        llllllllllllllllllllllllllll3 += noiseSampleData.perlinNoise * stylingRandomData.noiseIntensity;
    }
    if (fmod(floor(llllllllllllllllllllllllllll3.y), 2) == 0)
    {
        llllllllllllllllllllllllllll3.x += halftonesData.offset;
    }
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllll3 = 0;
        if (stylingRandomData.lengthRandomMode == 0)
        {
            lllllllllllllllll3 = noiseSampleData.whiteNoiseFloored * saturate(1 - stylingRandomData.noiseIntensity); 
        }
        else if (stylingRandomData.lengthRandomMode == 1)
        {
            lllllllllllllllll3 = noiseSampleData.perlinNoiseFloored; 
        }
        else
        {
            lllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + (noiseSampleData.whiteNoise * saturate(1 - stylingRandomData.noiseIntensity))) / 2); 
        }
        float llllllllllllllllll3 = lllllllllllllllll3 * stylingRandomData.lengthRandomIntensity;
        llllll0 -= llllllllllllllllll3;
    }
    float lllllllllllllllllllllllllllllll3 = halftonesData.size;
    if (halftonesData.sizeControl == 1)  
    {
        lllllllllllllllllllllllllllllll3 *= llllll0;
    }
    else
    {
        float l4 = smoothstep(min(1 - halftonesData.sizeFalloff, 1), 1, (1 - llllll0));
        lllllllllllllllllllllllllllllll3 = max(lllllllllllllllllllllllllllllll3 - l4, 0);
    }
    lllllllllllllllllllllllllllllll3 /= 2;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llllllllllll3 = 0;
        if (stylingRandomData.thicknessRandomMode == 0)
        {
            llllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.thicknessRandomMode == 1) 
        {
            llllllllllll3 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllll3 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        float lll4 = remap(0, 1, 0.0, lllllllllllllllllllllllllllllll3, llllllllllll3 * stylingRandomData.thicknesshRandomIntensity);
        lllllllllllllllllllllllllllllll3 -= lll4;
    }
    float llll4 = 1 - halftonesData.roundness;
    float lllll4 = smoothstep(halftonesData.roundnessFalloff, 1, 1 - llllll0);
    llll4 = max(llll4 - lllll4 * 4, 0);
    llll4 /= 2;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llllllllllllll3 = 0;
        if (stylingRandomData.spacingRandomMode == 0)
        {
            llllllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.spacingRandomMode == 1) 
        {
            llllllllllllll3 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllllll3 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        float lllllllllllllll3 = remap(0, 1, -0.5 + lllllllllllllllllllllllllllllll3, 0.5 - lllllllllllllllllllllllllllllll3, llllllllllllll3);
        llllllllllllllllllllllllllll3 += lllllllllllllll3 * stylingRandomData.spacingRandomIntensity * saturate(1 - stylingRandomData.noiseIntensity); 
    }
    float llllllll4 = halftonesData.hardness;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllllllll3 = 0;
        if (stylingRandomData.hardnessRandomMode == 0) 
        {
            lllllllllllllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.hardnessRandomMode == 1) 
        {
            lllllllllllllllllllll3 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else
        {
            lllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        llllllll4 = min(saturate(halftonesData.hardness - lllllllllllllllllllll3 * stylingRandomData.hardnessRandomIntensity), halftonesData.hardness);
    }
    float llllllllll4 = remap(0, 1, 0, lllllllllllllllllllllllllllllll3, llllllll4);
    float lllllllllllllllllllllllllll0 = length(max(abs(frac(llllllllllllllllllllllllllll3) - 0.5) - llll4 * llllllllll4 * 2, 0.0)) + llll4 * llllllllll4 * 2;
    float llllllllllll4 = smoothstep(llllllllll4, lllllllllllllllllllllllllllllll3, lllllllllllllllllllllllllll0);
    llllllllllll4 = 1 - llllllllllll4;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllllllllll3;
        if (stylingRandomData.opacityRandomMode == 0) 
        {
            lllllllllllllllllllllll3 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.opacityRandomMode == 1) 
        {
            lllllllllllllllllllllll3 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else 
        {
            lllllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored * 5) + noiseSampleData.whiteNoise) / 2;
            lllllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        llllllllllll4 = saturate(llllllllllll4 - (lllllllllllllllllllllll3 * stylingRandomData.opacityRandomIntensity));
    }
    float llllllllllllll4 = smoothstep(min(1-halftonesData.opacityFalloff, 0.99), 1, 1 - llllll0);
    if (halftonesData.type == 1 || halftonesData.opacityFalloff != 0)
    {
        llllllllllll4 *= 1 - llllllllllllll4;
    }
    llllllllllll4 *= halftonesData.opacity;
    llllllllllll4 = 1 - llllllllllll4;
    return llllllllllll4;
}
void DoBlending(
inout float4 lllllllllllllll4, float llllll0, float lllllllllllllllll4, float4 llllllllllllllllll4
)
{
    if (lllllllllllllllll4 == 0) 
    {
        lllllllllllllll4 = lerp(lllllllllllllll4, llllllllllllllllll4, llllll0);
    }
    else if (lllllllllllllllll4 == 1) 
    {        
        lllllllllllllll4 += (llllllllllllllllll4 * llllll0);
    }
    else if (lllllllllllllllll4 == 2) 
    {
        lllllllllllllll4 *= 1-llllll0 + (llllllllllllllllll4 * llllll0); 
    }
    else if (lllllllllllllllll4 == 3) 
    {
        lllllllllllllll4 -= (llllllllllllllllll4 * llllll0);
    }
    else if (lllllllllllllllll4 == 4) 
    {
        lllllllllllllll4 = lerp(lllllllllllllll4, llllllllllllllllll4, llllll0);
    }
}
void DoToonShading(
#if _URP
    InputData inputData, 
    SurfaceData surface,
#else
#if _USESPECULAR || _USESPECULARWORKFLOW || _SPECULARFROMMETALLIC
                 SurfaceOutputStandardSpecular o,
#elif _BDRFLAMBERT || _BDRF3 || _SIMPLELIT
                 SurfaceOutput o,
#else
                 SurfaceOutputStandard o,
#endif
    UnityGI gi,
#if !_PASSFORWARDADD
    UnityGIInput giInput,
#endif
#endif
    ShaderData d,
#if _URP
    #if UNITY_VERSION >= 202120
    float3 lllllllllllllllllll4,
    #endif
#endif
    inout float4 lllllllllllllll4, int lllllllllllllllllllll4, float llllllllllllllllllllll4, float2 lllllllllllllllllllllllllllllll0, float4 lllllllllllllllllllllll0, sampler2D lllllllllllllllllllllllll4,
    half llllllllllllllllllllllllll4, half lllllllllllllllllllllllllll4, 
    half llllllllllllllllllllllllllll4, half lllllllllllllllllllllllllllll4,
    sampler2D llllllllllllllllllllllllllllll4, float4 lllllllllllllllllllllllllllllll4, half l5, half ll5, float lll5,
    half llll5, float4 lllll5, float llllll5, float lllllll5, float4 llllllll5,
    float lllllllll5, float llllllllll5, float lllllllllll5, half llllllllllll5, float4 lllllllllllll5,
    half llllllllllllll5,
    half lllllllllllllll5, half llllllllllllllll5, float4 lllllllllllllllll5, float llllllllllllllllll5, float lllllllllllllllllll5, float llllllllllllllllllll5, half lllllllllllllllllllll5,
    half llllllllllllllllllllll5, half lllllllllllllllllllllll5, float4 llllllllllllllllllllllll5, float lllllllllllllllllllllllll5, float llllllllllllllllllllllllll5, float lllllllllllllllllllllllllll5, half llllllllllllllllllllllllllll5, half lllllllllllllllllllllllllllll5,
    half llllllllllllllllllllllllllllll5, 
    GeneralStylingData generalStylingData, half lllllllllllllllllllllllllllllll5, half llllllll3,
    half ll6,
    half lll6,
    float llll6, float lllll6, float llllll6, 
    PositionAndBlendingData positionAndBlendingDataShading, UVSpaceData uvSpaceDataShading, StylingData stylingDataShading, StylingRandomData stylingRandomDataShading,
    half lllllll6, 
    half llllllll6,
    half lllllllll6, float llllllllll6,
    PositionAndBlendingData positionAndBlendingDataCastShadows, UVSpaceData uvSpaceDataCastShadows, StylingData stylingDataCastShadows, StylingRandomData stylingRandomDataCastShadows,
    half lllllllllll6,
    half llllllllllll6, float lllllllllllll6, float llllllllllllll6,
    half lllllllllllllll6,
    PositionAndBlendingData positionAndBlendingDataSpecular, UVSpaceData uvSpaceDataSpecular, StylingData stylingDataSpecular, StylingRandomData stylingRandomDataSpecular,
    half llllllllllllllll6, 
    half lllllllllllllllll6, float llllllllllllllllll6, float lllllllllllllllllll6, half llllllllllllllllllll6,
    half lllllllllllllllllllll6,
    PositionAndBlendingData positionAndBlendingDataRim, UVSpaceData uvSpaceDataRim, StylingData stylingDataRim, StylingRandomData stylingRandomDataRim,
    sampler2D llllllllllllllllllllllllll2, sampler2D lllllllllllllllllllllllllll2, 
    float4 llllllllllllllllllllllll6,
    float3 lllllllllllllllllllllllll6
)
{           
#if _USE_OPTIMIZATION_DEFINES
    #if _ENABLE_TOON_SHADING
        llllllllllllllllllllllllllll4 == 1;
    #else
        llllllllllllllllllllllllllll4 == 0;
    #endif
#endif
    float llllllllllllllllllllllllll6 = 0;
    float4 lllllllllllllllllllllllllll6 = lllllllllllllll4;
    int llllllllllllllllllllllllllll6 = lllllllllllllllllllll4;
#if _URP
    Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
    if (mainLight.color.r > 0.0 || mainLight.color.g > 0.0 || mainLight.color.b > 0.0)
    {
    }
    else
    {
        mainLight = GetAdditionalLight(0, inputData.positionWS, 0);                      
    }
    float lllll2 = mainLight.shadowAttenuation;        
#else
    UnityLight light = gi.light;
    #if !_PASSFORWARDADD
    float lllll2 = giInput.atten;
    #else
    float lllll2 = 0;
    llllllllllllllllllllll5 = 0;
    llllllllllllllllllllllllllllll5 = 0;
    llllllllllllllll6 = 0;
    ll6 = 0;
    lllllll6 = 0;
    stylingDataShading.color = 0;
    stylingDataSpecular.color = half4(gi.light.color,1);
    #endif
#endif
    float l7 = lllll2;
    float ll7 = 0;  
    float3 lll7;
    if (llllllllllllll5 == 0)
    {
        lll7 = lllllllllllllllllllllllll6;
    }
    else
    {
    #if _URP 
        lll7 = inputData.normalWS;
    #else
        lll7 = o.Normal;
    #endif
    }
    float4 llll7 = 0;    
    float llllllllllllllllllll1 = 0;
    float3 llllllllllllll1;
    if (lllllllllllllllllllll5 == 0)
    {
        llllllllllllll1 = lllllllllllllllllllllllll6;
    }
    else
    {
    #if _URP 
        llllllllllllll1 = inputData.normalWS;
    #else
        llllllllllllll1 = o.Normal;
    #endif
    }
    float3 lllllllllllllllllllllllllll1;
    if (lllllllllllllllllllllllllllll5 == 0)
    {
        lllllllllllllllllllllllllll1 = lllllllllllllllllllllllll6;
    }
    else
    {
    #if _URP 
        lllllllllllllllllllllllllll1 = inputData.normalWS;
    #else
        lllllllllllllllllllllllllll1 = o.Normal;
    #endif
    }
    float3 llllllllllllllll1 = normalize(d.worldSpaceViewDir);
    float lllllllll7 = 0;    
    if (llllllllllllllllllllllllll4 == 0) 
    {
#if _SHADING_COLOR
#if _ENABLE_TOON_SHADING || !_USE_OPTIMIZATION_DEFINES
    #if !_USE_OPTIMIZATION_DEFINES
        if (llllllllllllllllllllllllllll4 == 1)
    #endif
        {
        #if _URP
            float lllllllllllllllllll1 = dot(mainLight.direction, lll7);
        #else
            float lllllllllllllllllll1 = dot(light.dir, lll7);
        #endif
    #if _USE_OPTIMIZATION_DEFINES
        #if _SHADING_FUNCTION
            lllllllllllllllllllllllllllll4 = _SHADING_FUNCTION
        #endif
        #if _ENABLE_SHADOWS
            llll5 = 1;
        #else
            llll5 = 0;
        #endif
    #endif
            if (lllllllllllllllllllllllllllll4 == 0)
            {
                if (llll5 == 1)
                {
                    llllllllllllllllllllll4 = (1.0 / llllllllllllllllllllllllllll6) * llllllllllllllllllllll4; 
                    half llllllllllll7 = ceil(lllllllllllllllllll1 * llllllllllllllllllllllllllll6) / llllllllllllllllllllllllllll6;
                    half lllllllllllll7 = max(0, ceil(lllllllllllllllllll1 * llllllllllllllllllllllllllll6) - 1) / llllllllllllllllllllllllllll6;
                    ll7 = max(llllllllllll7 * smoothstep(lllllllllllll7, lllllllllllll7 + llllllllllllllllllllll4, lllllllllllllllllll1), lllllllllllll7);
                    lllllllllllllll4 = lerp(lllll5, lllllllllllllll4, ll7);
                }
            }
                else
            {
                float llllllllllllll7 = lllllllllllllllllll1;
                if (l5 == 1 && llll5 == 0 && lllllllllllllllllll1 < 0)
                {
                    llllllllllllll7 = 0;
                }
                llllllllllllll7 = (llllllllllllll7 + 1) / 2;
                float4 lllllllllllllll7 = float4(0, 0, 0, 0);
                float llllllllllllllll7 = lllllllllllllllllllllllllllllll4.z;
                float lllllllllllllllll7 = llllllllllllll7 * (llllllllllllllll7 - 1);
                float2 llllllllllllllllll7 = (lllllllllllllllll7 + 0.5) * lllllllllllllllllllllllllllllll4.xy;
                lllllllllllllll7 = tex2D(llllllllllllllllllllllllllllll4, llllllllllllllllll7);
                DoBlending(lllllllllllllll4, lll5, ll5, lllllllllllllll7);
                if (lllllllllllllllllll1 > 0)
                {
                    ll7 = 1;
                }
                else
                {
                    ll7 = 0;
                }
            }
        float lllllllllllllllllll7 = llllllllllll5; 
    #if (_ENABLE_CAST_SHADOWS) || !_USE_OPTIMIZATION_DEFINES
        #if !_USE_OPTIMIZATION_DEFINES
            if (lllllllll5 == 1)
            {
        #endif
                if (lllllllllllllllllll1 > 0)
                {
                    lllllllllllllll4 *= lllll2;
                    float lllllllll7 = 1 - lllll2;
                    if (lllllllllllllllllllllllllllll4 == 0)
                    {
                        if(llll5 == 1 )
                        {
                                    if (lllllllllllllllllll7 == 0)
                            {
                                lllllllllllllll4 += lllllllll7 * lllll5;
                            }
                            else
                            {
                                lllllllllllllll4 += lllllllll7 * lllll5;
                                if (lllllllll7 < 0.5 && lllllllll7 > 0.0)
                                {
                                    lllllllllllllll4 = lerp(lllllllllllllll4, lllll5, lllllllll7 / 0.5);
                                }
                                else if (lllllllll7 >= 0.5 && lllllllll7 < 0.9999999)
                                {
                                    lllllllllllllll4 = 0;
                                    float lllllllllllllllllllll7 = smoothstep(0.5, 0.9999999, lllllllll7);
                                    lllllllllllllll4 = lerp(lllll5, llllllll5, lllllllllllllllllllll7);
                                }
                                else if (lllllllll7 <= 1 && lllllllll7 > 0.0)
                                {
                                    lllllllllllllll4 = llllllll5;
                                }
                            }        
                        }
                        else 
                        {
                            lllllllllllllll4 += lllllllllllll5 * lllllllll7;
                        }
                    }
                    else if (lllllllllllllllllllllllllllll4 == 1) 
                    {
                        lllllllllllllll4 += lllllllllllll5 * (lllllllll7);
                    }
                }
        #if !_USE_OPTIMIZATION_DEFINES
            }
            else 
        #endif
    #endif
            if (lllllllll5 == 0 && (llllllllllllllllllllllllllllll5 == 0 || lllllll6 == 0))
            {
                lllll2 = 1;
            }
            if (llll5 == 1 && lllllllllllllllllllllllllllll4 == 0)
            {
                if(lllllllllllllllllll1 <= 0.0) 
                {
                    lllllllllllllll4 = llllllll5;
                    lllllll5 = 1 - lllllll5;
                    float llllllllllllllllllllll7 = lllllll5 * llllll5;
                    float lllllllllllllllllllllll7 = smoothstep(-llllllllllllllllllllll7 + 0.01, -llllll5, lllllllllllllllllll1);
                    lllllllllllllll4 = lerp(lllll5, llllllll5, lllllllllllllllllllllll7);
                    if (lllllllll5 && lllllllllllllllllll7 == 1)
                    {
                        lllllllllllllll4 = lerp(llllllll5, lllllllllllllll4, lllll2);
                    }
                }
            }
#if _ENABLE_SPECULAR || !_USE_OPTIMIZATION_DEFINES
            if (lllllllllllllll5 == 1)
            {
        #if _URP
                llllllllllllllllllll1 = CalculateSpecularMask(llllllllllllll1, mainLight.direction, llllllllllllllll1, llllllllllllllllll5, lllllllllllllllllll5, lllllllllllllllllll1);
        #else
                llllllllllllllllllll1 = CalculateSpecularMask(llllllllllllll1, light.dir, llllllllllllllll1, llllllllllllllllll5, lllllllllllllllllll5, lllllllllllllllllll1);
        #endif
                llllllllllllllllllll1 *= llllllllllllllllllll5 * lllll2;
#if _USE_OPTIMIZATION_DEFINES
                #ifdef _SPECULAR_BLENDING
                    llllllllllllllll5 = _SPECULAR_BLENDING;
                #endif
            #endif
                DoBlending(lllllllllllllll4, llllllllllllllllllll1, llllllllllllllll5, lllllllllllllllll5);
            }
        #endif
        }
#if _URP
        lllllllllllllll4 += half4(surface.emission, 0);
#else
        lllllllllllllll4 += half4(o.Emission, 0);
#endif
    #endif
#endif
    }
    else 
    {
        ToonShadingData toonShadingData;
        toonShadingData.enableToonShading = llllllllllllllllllllllllllll4;
#if _URP
        toonShadingData.normalWS = inputData.normalWS;
#endif
        toonShadingData.normalWSNoMap = lllllllllllllllllllllllll6;
        toonShadingData.cellTransitionSmoothness = llllllllllllllllllllll4;
        toonShadingData.numberOfCells = llllllllllllllllllllllllllll6;
        toonShadingData.specularEdgeSmoothness = lllllllllllllllllll5;
        toonShadingData.shadingAffectByNormalMap = llllllllllllll5;
        toonShadingData.specularAffectedByNormalMap = lllllllllllllllllllll5;
#if _USE_OPTIMIZATION_DEFINES
#if _ENABLE_TOON_SHADING 
                toonShadingData.enableToonShading = 1;
#else
                toonShadingData.enableToonShading = 0;
#endif
#endif
#if _SHADING_BLINNPHONG       
        if (lllllllllllllllllllllllllll4 == 0) 
        {
#if _URP
        #if UNITY_VERSION >= 202120
            lllllllllllllll4 = UniversalFragmentBlinnPhong(inputData, surface.albedo, half4(surface.specular, surface.smoothness), surface.smoothness, surface.emission, surface.alpha,lllllllllllllllllll4, toonShadingData);
        #else
            lllllllllllllll4 = UniversalFragmentBlinnPhong(inputData, surface.albedo, half4(surface.specular, surface.smoothness), surface.smoothness, surface.emission, surface.alpha, toonShadingData);
        #endif
#else
#endif
        }
#endif        
#if _SHADING_PBR
        if (lllllllllllllllllllllllllll4 == 1) 
        {      
#if _URP
            lllllllllllllll4 = UniversalFragmentPBR(inputData, surface, toonShadingData);
#else
#if !_PASSFORWARDADD
    #if _USESPECULAR || _USESPECULARWORKFLOW || _SPECULARFROMMETALLIC
    #else
        LightingStandard_GI_Toon(o, giInput, gi, toonShadingData);
        #if defined(_OVERRIDE_BAKEDGI)
            gi.indirect.diffuse = l.DiffuseGI;
            gi.indirect.specular = l.SpecularGI;
        #endif
        lllllllllllllll4 = LightingStandard_Toon (o, d.worldSpaceViewDir, gi, toonShadingData);
    #endif     
#else
    #if _USESPECULAR
#elif _BDRF3 || _SIMPLELIT
#else
                  lllllllllllllll4 = LightingStandard_Toon (o, d.worldSpaceViewDir, gi, toonShadingData);
#endif
#endif
#endif
        }
#endif
    }
    float llllll2 = 0;
    if (llllllllllllllllllllllllllll4 == 1)
    {
    #if _URP
        float lllllllllllllllllll1 = dot(mainLight.direction, lllllllllllllllllllllllllll1);
    #else
        float lllllllllllllllllll1 = dot(light.dir, lllllllllllllllllllllllllll1);
    #endif
        #if _ENABLE_RIM|| !_USE_OPTIMIZATION_DEFINES
        #if !_USE_OPTIMIZATION_DEFINES
            if (llllllllllllllllllllll5 == 1)
        #endif
            {
        #if _URP
            llllll2 = CalculateRimMask(lllllllllllllllllllllllllll1, mainLight.direction, llllllllllllllll1, lllllllllllllllllllllllll5, llllllllllllllllllllllllll5, lllllllllllllllllll1, llllllllllllllllllllllllllll5, lllllllll5, llll5, lllll2);
        #else
            llllll2 = CalculateRimMask(lllllllllllllllllllllllllll1, light.dir, llllllllllllllll1, lllllllllllllllllllllllll5, llllllllllllllllllllllllll5, lllllllllllllllllll1, llllllllllllllllllllllllllll5, lllllllll5, llll5, lllll2);
        #endif
            llllll2 *= lllllllllllllllllllllllllll5;
        #if _USE_OPTIMIZATION_DEFINES
        #ifdef _RIM_BLENDING
                        lllllllllllllllllllllll5 = _RIM_BLENDING;
        #endif
        #endif
                    DoBlending(lllllllllllllll4, llllll2, lllllllllllllllllllllll5, llllllllllllllllllllllll5);
                }
        #endif
    }
#if _ENABLE_STYLING || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
    if (llllllllllllllllllllllllllllll5 == 1)
    #endif
    {
        float3 lllllllllllllllllllllllllll7;
        if (lllllllllllllllllllllllllllllll5 == 0)
        {
            lllllllllllllllllllllllllll7 = lllllllllllllllllllllllll6;
        }
        else
        {
        #if _URP 
            lllllllllllllllllllllllllll7 = inputData.normalWS;
        #else
            lllllllllllllllllllllllllll7 = o.Normal;
        #endif
        }
    #if _URP
        float lllllllllllllllllll1 = dot(mainLight.direction, lllllllllllllllllllllllllll7);
    #else
        float lllllllllllllllllll1 = dot(light.dir, lllllllllllllllllllllllllll7);
    #endif
        if (lllllllllll6 == 1)
        {
            if (lllllllllllllll5 == 0 || llllllllllll6 == 0) 
            {
                float llllllllllllllllllllllllllllll7 = lllllllllllllllllll1;
            #if _URP
                llllllllllllllllllll1 = CalculateSpecularMask(lllllllllllllllllllllllllll7, mainLight.direction, llllllllllllllll1, lllllllllllll6, llllllllllllll6, llllllllllllllllllllllllllllll7);
            #else
                llllllllllllllllllll1 = CalculateSpecularMask(lllllllllllllllllllllllllll7, light.dir, llllllllllllllll1, lllllllllllll6, llllllllllllll6, llllllllllllllllllllllllllllll7);
            #endif
                llllllllllllllllllll1 *=  l7;
                llllllllllllllllllll1 = saturate(llllllllllllllllllll1);
            }
            else
            {
            }
        }
        lllllllllllllllllll1 = 1-lllllllllllllllllll1 - llllllllllllllllllll1 * 10;
        lllllllllllllllllll1 = 1 - lllllllllllllllllll1;
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _SHADING_STYLING_DRAWSPACE
        uvSpaceDataShading.drawSpace = _SHADING_STYLING_DRAWSPACE;
            #endif
            #ifdef _SHADING_STYLING_COORDINATESYSTEM
        uvSpaceDataShading.coordinateSystem = _SHADING_STYLING_COORDINATESYSTEM;
            #endif
        #endif
    #if _URP
        float2 lllllllllllllllllllllllllllllll7 = ConvertToDrawSpace(inputData, lllllllllllllllllllllllllllllll0, uvSpaceDataShading, lllllllllllllllllllllll0);
    #else
        float2 lllllllllllllllllllllllllllllll7 = ConvertToDrawSpace(d.worldSpacePosition, lllllllllllllllllllllllllllllll0, uvSpaceDataShading, lllllllllllllllllllllll0);
    #endif
        float ll8 = stylingDataShading.density;
        float llllllllll3 = stylingDataShading.size;
        half4 llll8 = tex2D(llllllllllllllllllllllllll2, lllllllllllllllllllllllllllllll0.xy); 
        float lllll8 = 1;
#if _ENABLE_SHADING_STYLING || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
        if (ll6 != 0)
    #endif        
        {
            float llllll8 = 0;            
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _SHADING_STYLING_BLENDING
                    positionAndBlendingDataShading.blending = _SHADING_STYLING_BLENDING;
            #endif                   
            #ifdef _SHADING_STYLE
                stylingDataShading.style = _SHADING_STYLE;
            #endif
            #if _SHADING_STYLING_RANDOMIZER
                stylingRandomDataShading.enableRandomizer = 1;
            #else
                stylingRandomDataShading.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataShading;
    #if _USE_OPTIMIZATION_DEFINES
        #ifdef _SHADING_STYLING_RANDOMIZER_PERLIN
            requiredNoiseDataShading.perlinNoise = 1;
        #else
            requiredNoiseDataShading.perlinNoise = 0;
        #endif
        #ifdef _SHADING_STYLING_RANDOMIZER_PERLIN_FLOORED
            requiredNoiseDataShading.perlinNoiseFloored = 1;
        #else
            requiredNoiseDataShading.perlinNoiseFloored = 0;
        #endif         
        #ifdef _SHADING_STYLING_RANDOMIZER_WHITE
            requiredNoiseDataShading.whiteNoise = 1;
        #else
            requiredNoiseDataShading.whiteNoise = 0;
        #endif
        #ifdef _SHADING_STYLING_RANDOMIZER_WHITE_FLOORED
            requiredNoiseDataShading.whiteNoiseFloored = 1;
        #else
            requiredNoiseDataShading.whiteNoiseFloored = 0;
        #endif            
    #else            
            requiredNoiseDataShading.perlinNoise = 1;
            requiredNoiseDataShading.perlinNoiseFloored = 1;
            requiredNoiseDataShading.whiteNoise = 1;
            requiredNoiseDataShading.whiteNoiseFloored = 1;
    #endif
            float lllllll8 = lllllllllllllllllll1;
            if (positionAndBlendingDataShading.isInverted == 1)
            {
                lllllll8 = 1 - lllllllllllllllllll1;
            }
            if (stylingDataShading.style == 0) 
            {                             
                float ll8 = stylingDataShading.density;
                float llllllllll3 = stylingDataShading.size;
                llllllllll3 = stylingDataShading.size / 2;
                if (llll6 == 0)
                {
                    llllllllllllllllllllllllllll6 = lllll6;
                }
                else
                {
                    llllllllllllllllllllllllllll6 = lllllllllllllllllllll4;
                }
            #if _USE_OPTIMIZATION_DEFINES            
                #ifdef _SHADING_STYLING_NUMBER_OF_CELLS_HATCHING
                        llllllllllllllllllllllllllll6 = _SHADING_STYLING_NUMBER_OF_CELLS_HATCHING;
                #endif                            
            #endif
                float llllllllll8 = (1. / llllllllllllllllllllllllllll6) * llllll6;
                int lllllllllll8 = ceil((max(lllllll8 - llllllllll8, 0)) * llllllllllllllllllllllllllll6);
                lllllllllll8 = llllllllllllllllllllllllllll6 - lllllllllll8;
                float llllllllllll8 = stylingDataShading.rotation;
                float lllllllllllll8 = radians(llllllllllll8);
                float llllllllllllll8 = stylingDataShading.rotationBetweenCells;
                float lllllllllllllll8 = radians(llllllllllllll8);
                float2 llllllllllllllll8; 
                NoiseSampleData noiseSampleData; 
                lllll8 = 1;
                float lllllll1 = 0;
    #if _USE_OPTIMIZATION_DEFINES            
        #ifdef _SHADING_STYLING_NUMBER_OF_CELLS_HATCHING
                [unroll(_SHADING_STYLING_NUMBER_OF_CELLS_HATCHING)]
        #endif
    #else
                [unroll(15)]
    #endif
                for (int i = 1; i <= lllllllllll8; i++)
                { 
                    llllllllll3 = stylingDataShading.size / 2;
                        float llllllllllllllllll8 = i - 1;
                        float llllllllllllllllllll2 = lllllllllllll8 + lllllllllllllll8 * llllllllllllllllll8;
                        lllllllllllllllllllllllllllllll7 += lllllll1; 
                        llllllllllllllll8 = RotateUVRadians(lllllllllllllllllllllllllllllll7, llllllllllllllllllll2);
                        noiseSampleData = SampleNoiseData(llllllllllllllll8, stylingDataShading, stylingRandomDataShading, requiredNoiseDataShading, llllllllllllllllllllllllll2, lllllllllllllllllllllllllll2);
                    lllllll1 += (float) stylingDataShading.density;
                    float llllllllllllllllllll8 = llllllllllllllll8.x;                          
                    llllllllllllllllllll8 *= stylingDataShading.density;
                    if (stylingRandomDataShading.enableRandomizer == 1)
                    {
                        llllllllllllllllllll8 += noiseSampleData.perlinNoise * stylingRandomDataShading.noiseIntensity;
                        float llllllllllll3 = 0;
                        if (stylingRandomDataShading.thicknessRandomMode == 0)
                        {
                            llllllllllll3 = noiseSampleData.whiteNoise;
                        }
                        else if (stylingRandomDataShading.thicknessRandomMode == 1) 
                        {
                            llllllllllll3 = noiseSampleData.perlinNoiseFloored;
                        }
                        else 
                        {
                            llllllllllll3 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
                        }
                        float lllllllllllll3 = remap(0, 1, 0.0, llllllllll3, llllllllllll3 * stylingRandomDataShading.thicknesshRandomIntensity);
                        llllllllll3 -= lllllllllllll3;
                        float llllllllllllll3 = 0;
                        if (stylingRandomDataShading.spacingRandomMode == 0)
                        {
                            llllllllllllll3 = noiseSampleData.whiteNoise;
                        }
                        else if (stylingRandomDataShading.spacingRandomMode == 1) 
                        {
                            llllllllllllll3 = noiseSampleData.perlinNoiseFloored;
                        }
                        else 
                        {
                            llllllllllllll3 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
                        }
                        float lllllllllllllll3 = remap(0, 1, -0.5 + llllllllll3, 0.5 - llllllllll3, llllllllllllll3);
                        llllllllllllllllllll8 += lllllllllllllll3 * stylingRandomDataShading.spacingRandomIntensity * saturate(1 - stylingRandomDataShading.noiseIntensity); 
                    }
                    llllllllllllllllllll8 = abs(frac(llllllllllllllllllll8) - 0.5);
                    float lllllllllllllllllllllllll8 = (float) (llllllllllllllllllllllllllll6 - i) / llllllllllllllllllllllllllll6;
                    float llllllllllllllllllllllllll8 = remap(0, 1, 0, llllllllll8, llllll6);
                    float llllllllllllllll3;
                    float llllllllllllllllll3;
                    float lllllllllllllllllllllllllllll8 = 0;
                    if (stylingRandomDataShading.enableRandomizer == 1)
                    {
                        float lllllllllllllllll3 = 0;
                        if (stylingRandomDataShading.lengthRandomMode == 0)
                        {
                            lllllllllllllllll3 = noiseSampleData.whiteNoise * saturate(1 - stylingRandomDataShading.noiseIntensity);
                        }
                        else if (stylingRandomDataShading.lengthRandomMode == 1)
                        {
                            lllllllllllllllll3 = noiseSampleData.perlinNoiseFloored; 
                        }
                        else
                        {
                            lllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + (noiseSampleData.whiteNoise * saturate(1 - stylingRandomDataShading.noiseIntensity))) / 2); 
                        }
                        llllllllllllllllll3 = lllllllllllllllll3 * stylingRandomDataShading.lengthRandomIntensity;
                        lllllllllllllllllllllllllllll8 = remap(0, 1, 0, lllllllllllllllllllllllll8 + llllllllllllllllllllllllll8, llllllllllllllllll3);           
                    }
                    llllllllllllllll3 = remap(0, lllllllllllllllllllllllll8 + llllllllllllllllllllllllll8 - lllllllllllllllllllllllllllll8, 0, 1, lllllll8);
                    if (i == llllllllllllllllllllllllllll6 && sign(lllllll8) == 1)
                    {
                        float lllllllllllllllllllllllllllll8 = 0;
                        if (stylingRandomDataShading.enableRandomizer == 1)
                        {
                            lllllllllllllllllllllllllllll8 = remap(0, 1, 0, 1 - llllllllll8, llllllllllllllllll3);
                        }
                        llllllllllllllll3 = remap(0, llllllllll8, 1 - llllllllll8 + lllllllllllllllllllllllllllll8, 1 + lllllllllllllllllllllllllllll8, lllllll8);
                    }
                    if (i == llllllllllllllllllllllllllll6 && sign(lllllll8) == -1)
                    {
                        float l9 = (float) 1. / llllllllllllllllllllllllllll6;
                        llllllllllllllllllllllllll8 = remap(0, 1, 0, l9, llllll6);
                        float lllllllllllllllllllllllllllll8 = 0;
                        if (stylingRandomDataShading.enableRandomizer == 1)
                        {
                            lllllllllllllllllllllllllllll8 = remap(0, 1, 0, 1 - llllllllllllllllllllllllll8, llllllllllllllllll3);
                        }
                        llllllllllllllll3 = remap(0, -1, 1 - llllllllllllllllllllllllll8 + lllllllllllllllllllllllllllll8, 0, lllllll8);
                    }
                    float lllllllllllllllllll3 = smoothstep(1-stylingDataShading.sizeFalloff, 1, llllllllllllllll3);
                    if (l7 <= 0 && lllllll8 > 0)
                    {
                    }
                    lllllllllllllllllll3 = max(llllllllll3 - lllllllllllllllllll3, 0);            
                    float llllllllllllllllllll3;
                    if (stylingRandomDataShading.enableRandomizer == 1)
                    {
                        float lllllllllllllllllllll3 = 0;
                        if (stylingRandomDataShading.hardnessRandomMode == 0) 
                        {
                            lllllllllllllllllllll3 = noiseSampleData.whiteNoise;
                        }
                        else if (stylingRandomDataShading.hardnessRandomMode == 1) 
                        {
                            lllllllllllllllllllll3 = noiseSampleData.perlinNoiseFloored * 5;
                        }
                        else
                        {
                            lllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
                        }
                        llllllllllllllllllll3 = remap(0, 1, 0, lllllllllllllllllll3, min(saturate(stylingDataShading.hardness - lllllllllllllllllllll3 * stylingRandomDataShading.hardnessRandomIntensity), stylingDataShading.hardness));
                    }
                    else
                    {
                        llllllllllllllllllll3 = remap(0, 1, 0, lllllllllllllllllll3, stylingDataShading.hardness);
                    }
                    if (lllllllllllllllllll3 != 0 )
                    {
                        float llllllllllllllllllllll3 = 0; 
                        if (llllllll3)
                        {
                            llllllllllllllllllllll3 = fwidth(llllllllllllllllllll8); 
                        }
                        if (lllllllllllllllllll3 == llllllllll3 && stylingDataShading.size == 1)
                        {
                            llllllllllllllllllllll3 = 0;
                        }
                        if (llllllllllllllllllll3 - llllllllllllllllllllll3 < 0)
                        {
                            llllllllllllllllllllll3 = 0;
                        }
                        llllllllllllllllllll8 = smoothstep(llllllllllllllllllll3 - llllllllllllllllllllll3, lllllllllllllllllll3 + llllllllllllllllllllll3, llllllllllllllllllll8);
                    }
                    else
                    {
                        llllllllllllllllllll8 = 1; 
                    }
                    llllllllllllllllllll8 = 1 - llllllllllllllllllll8;
                    if (stylingRandomDataShading.enableRandomizer == 1)
                    {
                        float lllllllllllllllllllllll3;
                        if (stylingRandomDataShading.opacityRandomMode == 0) 
                        {
                            lllllllllllllllllllllll3 = noiseSampleData.whiteNoise;
                        }
                        else if (stylingRandomDataShading.opacityRandomMode == 1) 
                        {
                            lllllllllllllllllllllll3 = noiseSampleData.perlinNoiseFloored * 5;
                        }
                        else 
                        {
                            lllllllllllllllllllllll3 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
                        }
                        llllllllllllllllllll8 = saturate(llllllllllllllllllll8 - (lllllllllllllllllllllll3 * stylingRandomDataShading.opacityRandomIntensity));
                    }
                    float llllllllllllllllllllllll3 = smoothstep(saturate(min(1 - stylingDataShading.opacityFalloff, 1)), 1, llllllllllllllll3);
                    llllllllllllllllllll8 *= 1 - llllllllllllllllllllllll3;
                    llllllllllllllllllll8 = 1 - llllllllllllllllllll8;
                    lllll8 = min(llllllllllllllllllll8, lllll8);
                }
                lllll8 = 1 - lllll8;
                lllll8 *= stylingDataShading.opacity;
                lllll8 = 1 - lllll8;
                llllll8 = lllll8;             
            }
            else if (stylingDataShading.style == 1) 
            {               
                float2 llllllllllllllllllllllllllll3 = lllllllllllllllllllllllllllllll7;
                float2 lllllllllllllllll2 = RotateUV(llllllllllllllllllllllllllll3, stylingDataShading.rotation);
                NoiseSampleData noiseSampleData = SampleNoiseData(lllllllllllllllll2, stylingDataShading, stylingRandomDataShading, requiredNoiseDataShading, llllllllllllllllllllllllll2, lllllllllllllllllllllllllll2);
                if (false)
                {
                } 
                float lllllllllll9 = 1 - lllllll8;
                float llllllllllll4 = Halftones(lllllllllll9, lllllllllllllllll2, stylingDataShading, stylingRandomDataShading, noiseSampleData);
                llllll8 = llllllllllll4;
            }
            if (false)
            {
            }
            #if _USE_OPTIMIZATION_DEFINES
                #if _ENABLE_STYLING_DISTANCEFADE
                     generalStylingData.enableDistanceFade = 1;
                #else
                    generalStylingData.enableDistanceFade = 0;
                #endif
            #endif
            if (generalStylingData.enableDistanceFade == 1)
            {
                float lllllllllllll9 = lllllll8;
                if (stylingDataShading.style == 0)
                {
                    int llllllllllllllllllllllllllll6;
                    if (llll6 == 0)
                    {
                        llllllllllllllllllllllllllll6 = lllll6;
                    }
                    else
                    {
                        llllllllllllllllllllllllllll6 = lllllllllllllllllllll4;
                    }
                    float llllllllll8 = (1. / llllllllllllllllllllllllllll6) * llllll6;
                    float llllllllllllllllllllllllll8 = remap(0, 1, 0, llllllllll8, llllll6);
                    lllllllllllll9 -= -1 + ((llllllllllllllllllllllllllll6 - 1.) / llllllllllllllllllllllllllll6) + llllllllllllllllllllllllll8;
                }
                float lllllllllllllllll9 = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
                float llllllllllllllllll9 = max(lllllllllllll9, 1 - stylingDataShading.opacityFalloff);
                llllllllllllllllll9 = remap(1 - stylingDataShading.opacityFalloff, 1, 0, 1, llllllllllllllllll9);
                float lllllllllllllllllll9 = max(lllllllllllll9, 1 - stylingDataShading.sizeFalloff);
                lllllllllllllllllll9 = remap(1 - stylingDataShading.sizeFalloff, 1, 0, 1, lllllllllllllllllll9);
                float llllllllllllllllllll9 = lerp(0.0, 1, saturate(1 - stylingDataShading.size)); 
                if (generalStylingData.adjustDistanceFadeValue == 1)
                {
                    llllllllllllllllllll9 = generalStylingData.distanceFadeValue;
                }
                lllllllllllllllllll9 = max(llllllllllllllllllll9, lllllllllllllllllll9 * 2);
                llllllllllllllllll9 = max(llllllllllllllllllll9, llllllllllllllllll9);
                float lllllllllllllllllllll9 = max(lllllllllllllllllll9, llllllllllllllllll9);
                lllllllllllllllllllll9 = saturate(lllllllllllllllllllll9);
                llllll8 = lerp(llllll8, lllllllllllllllllllll9, saturate(((lllllllllllllllll9 - generalStylingData.distanceFadeStartDistance) / generalStylingData.distanceFadeFalloff)));
            }
            if (positionAndBlendingDataShading.isInverted == 1)
            {
                llllll8 = 1 - llllll8;
            }
            DoBlending(lllllllllllllll4, 1 - llllll8, positionAndBlendingDataShading.blending, stylingDataShading.color);
            if (false)
            {                
            }
            if (false)
            {
            }
        }
#endif
#if _ENABLE_CASTSHADOWS_STYLING || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
        if (lllllll6)   
    #endif
        {
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _CASTSHADOWS_STYLING_BLENDING
                positionAndBlendingDataCastShadows.blending = _CASTSHADOWS_STYLING_BLENDING;
            #endif
            #ifdef _CASTSHADOWS_STYLING_DRAWSPACE
                uvSpaceDataCastShadows.drawSpace = _CASTSHADOWS_STYLING_DRAWSPACE;
            #endif
            #ifdef _CASTSHADOWS_STYLING_COORDINATESYSTEM
                uvSpaceDataCastShadows.coordinateSystem = _CASTSHADOWS_STYLING_COORDINATESYSTEM;
            #endif            
            #ifdef _CASTSHADOWS_STYLE
                stylingDataCastShadows.style = _CASTSHADOWS_STYLE;
            #endif
            #if _CASTSHADOWS_STYLING_RANDOMIZER
                stylingRandomDataCastShadows.enableRandomizer = 1;
            #else
                stylingRandomDataCastShadows.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataCastShadows;
    #if _USE_OPTIMIZATION_DEFINES
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_PERLIN
            requiredNoiseDataCastShadows.perlinNoise = 1;
        #else
            requiredNoiseDataCastShadows.perlinNoise = 0;
        #endif
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_PERLIN_FLOORED
            requiredNoiseDataCastShadows.perlinNoiseFloored = 1;
        #else
            requiredNoiseDataCastShadows.perlinNoiseFloored = 0;
        #endif         
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_WHITE
            requiredNoiseDataCastShadows.whiteNoise = 1;
        #else
            requiredNoiseDataCastShadows.whiteNoise = 0;
        #endif
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_WHITE_FLOORED
            requiredNoiseDataCastShadows.whiteNoiseFloored = 1;
        #else
            requiredNoiseDataCastShadows.whiteNoiseFloored = 0;
        #endif            
        #else            
            requiredNoiseDataCastShadows.perlinNoise = 1;
            requiredNoiseDataCastShadows.perlinNoiseFloored = 1;
            requiredNoiseDataCastShadows.whiteNoise = 1;
            requiredNoiseDataCastShadows.whiteNoiseFloored = 1;
        #endif
            if (llll5 == 0 || lllllllll5 == 0)
            {
                lllll2 = l7;
            }
    #if _URP
            float2 llllllllllllllllllllll9 = ConvertToDrawSpace(inputData, lllllllllllllllllllllllllllllll0, uvSpaceDataCastShadows, lllllllllllllllllllllll0);           
    #else
            float2 llllllllllllllllllllll9 = ConvertToDrawSpace(d.worldSpacePosition, lllllllllllllllllllllllllllllll0, uvSpaceDataCastShadows, lllllllllllllllllllllll0);
    #endif
            float llllll8 = 0;
            if (stylingDataCastShadows.style == 0) 
            {
                float lllllllllllllllllllllllll9 = stylingDataCastShadows.rotation;
                float llllllllllllllllllllllllll9 = radians(lllllllllllllllllllllllll9);
                float lllllllllllllllllllllllllll9 = stylingDataCastShadows.rotationBetweenCells;
                float llllllllllllllllllllllllllll9 = radians(lllllllllllllllllllllllllll9);
                float lllllllllllllllllllllllllllll9 = llllllllll6;
                lllllllllllllllllllllllllllll9 = min(lllllllllllllllllllllllllllll9, 0.99);
                float llllllllllllllllllllllllllllll9 = 1;
                float llllllllllllllllllllllllllll6 = lllllllll6;
            #if _USE_OPTIMIZATION_DEFINES            
                #ifdef _CASTSHADOWS_STYLING_NUMBER_OF_CELLS_HATCHING
                        llllllllllllllllllllllllllll6 = _CASTSHADOWS_STYLING_NUMBER_OF_CELLS_HATCHING;
                #endif                            
            #endif
                for (int j = 1; j <= llllllllllllllllllllllllllll6; j++)
                {
                    lllll2 = min(j / llllllllllllllllllllllllllll6, l7);
                    if (llllllllllllllllllllllllllll6 != 1)
                    {
                        float l10 = 0;
                        if (llllllllllllllllllllllllllll6 <= 1)
                        {
                            l10 = 0.0;
                        }
                        else
                        {
                            float ll10 = (float) j - 1;
                            float lll10 = (float) (llllllllllllllllllllllllllll6 - 1);
                            float llll10 = ll10 / lll10;
                            l10 = lerp(1.0, llll10, lllllllllllllllllllllllllllll9);
                        }
                        float lllll10 = min(l10, l7); 
                        lllll10 = remap(0, l10, 0, 1, l7);
                        lllll2 = lllll10;
                        lllll2 = max(lllll2, l7);
                    }
                    else
                    {
                        lllll2 = l7;
                    }
                    float llllllllllllllllll8 = j - 1;
                    float llllllllllllllllllll2 = llllllllllllllllllllllllll9 + llllllllllllllllllllllllllll9 * llllllllllllllllll8;
                    float2 llllllllllllllll8 = RotateUVRadians(llllllllllllllllllllll9, llllllllllllllllllll2);
                    llllllllllllllll8.x += (j - 1) / (float) llllllllllllllllllllllllllll6 * stylingDataCastShadows.density; 
                    NoiseSampleData noiseSampleData = SampleNoiseData(llllllllllllllll8, stylingDataCastShadows, stylingRandomDataCastShadows, requiredNoiseDataCastShadows, llllllllllllllllllllllllll2, lllllllllllllllllllllllllll2);
                    float lllllllll10 = Hatching(1 - lllll2, llllllllllllllll8, stylingDataCastShadows, stylingRandomDataCastShadows, noiseSampleData, llllllll3);
                    lllllllll10 = 1 - lllllllll10;
                    {
                        llllllllllllllllllllllllllllll9 = min(lllllllll10, llllllllllllllllllllllllllllll9);
                    }
                }
                llllll8 = llllllllllllllllllllllllllllll9;
            }
            else if (stylingDataCastShadows.style == 1) 
            {                        
                float2 lllllllllllllllll2 = RotateUV(llllllllllllllllllllll9, stylingDataCastShadows.rotation);
                NoiseSampleData noiseSampleData = SampleNoiseData(lllllllllllllllll2, stylingDataCastShadows, stylingRandomDataCastShadows, requiredNoiseDataCastShadows, llllllllllllllllllllllllll2, lllllllllllllllllllllllllll2);
                float llllllllllll4 = Halftones(1 - lllll2, lllllllllllllllll2, stylingDataCastShadows, stylingRandomDataCastShadows, noiseSampleData);
                llllll8 = llllllllllll4;            
            }
            DoBlending(lllllllllllllll4, 1 - llllll8, positionAndBlendingDataCastShadows.blending, stylingDataCastShadows.color);                    
        }
#endif        
#if _ENABLE_SPECULAR_STYLING || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
        if (lllllllllll6)   
    #endif
        {
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _SPECULAR_STYLING_BLENDING
                positionAndBlendingDataSpecular.blending = _SPECULAR_STYLING_BLENDING;
            #endif
            #ifdef _SPECULAR_STYLING_DRAWSPACE
                uvSpaceDataSpecular.drawSpace = _SPECULAR_STYLING_DRAWSPACE;
            #endif
            #ifdef _SPECULAR_STYLING_COORDINATESYSTEM
                uvSpaceDataSpecular.coordinateSystem = _SPECULAR_STYLING_COORDINATESYSTEM;
            #endif            
            #ifdef _SPECULAR_STYLE
                stylingDataSpecular.style = _SPECULAR_STYLE;
            #endif
            #if _SPECULAR_STYLING_RANDOMIZER
                stylingRandomDataSpecular.enableRandomizer = 1;
            #else
                stylingRandomDataSpecular.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataSpecular;
#if _USE_OPTIMIZATION_DEFINES            
#ifdef _SPECULAR_STYLING_RANDOMIZER_PERLIN
                    requiredNoiseDataSpecular.perlinNoise = 1;
#else
                    requiredNoiseDataSpecular.perlinNoise = 0;
#endif
#ifdef _SPECULAR_STYLING_RANDOMIZER_PERLIN_FLOORED
                    requiredNoiseDataSpecular.perlinNoiseFloored = 1;
#else
                    requiredNoiseDataSpecular.perlinNoiseFloored = 0;
#endif         
#ifdef _SPECULAR_STYLING_RANDOMIZER_WHITE
                    requiredNoiseDataSpecular.whiteNoise = 1;
#else
                    requiredNoiseDataSpecular.whiteNoise = 0;
#endif
#ifdef _SPECULAR_STYLING_RANDOMIZER_WHITE_FLOORED
                    requiredNoiseDataSpecular.whiteNoiseFloored = 1;
#else
                    requiredNoiseDataSpecular.whiteNoiseFloored = 0;
#endif      
#else            
            requiredNoiseDataSpecular.perlinNoise = 1;
            requiredNoiseDataSpecular.perlinNoiseFloored = 1;
            requiredNoiseDataSpecular.whiteNoise = 1;
            requiredNoiseDataSpecular.whiteNoiseFloored = 1;
#endif
        #if _URP
            float2 llllllllllll10 = ConvertToDrawSpace(inputData, lllllllllllllllllllllllllllllll0, uvSpaceDataSpecular, lllllllllllllllllllllll0);
        #else
            float2 llllllllllll10 = ConvertToDrawSpace(d.worldSpacePosition, lllllllllllllllllllllllllllllll0, uvSpaceDataSpecular, lllllllllllllllllllllll0);
        #endif
                float2 lllllllllllllllll2 = RotateUV(llllllllllll10, stylingDataSpecular.rotation);
                llllllllllll10 = lllllllllllllllll2;
            NoiseSampleData noiseSampleData = SampleNoiseData(llllllllllll10, stylingDataSpecular, stylingRandomDataSpecular, requiredNoiseDataSpecular, llllllllllllllllllllllllll2, lllllllllllllllllllllllllll2);
    #if _USE_OPTIMIZATION_DEFINES 
        #ifdef _SPECULAR_STYLE
            stylingDataSpecular.style = _SPECULAR_STYLE;
        #endif
    #endif
            float llllll8 = 0;     
            if (stylingDataSpecular.style == 0) 
            {                 
                llllll8 = Hatching(llllllllllllllllllll1, llllllllllll10, stylingDataSpecular, stylingRandomDataSpecular, noiseSampleData, llllllll3);
                llllll8 = 1 - llllll8;
            }
            else if (stylingDataSpecular.style == 1) 
            {
                float llllllllllll4 = Halftones(llllllllllllllllllll1, llllllllllll10, stylingDataSpecular, stylingRandomDataSpecular, noiseSampleData);
                llllll8 = llllllllllll4;              
            }
            #if _USE_OPTIMIZATION_DEFINES
                #ifdef _SPECULAR_STYLING_BLENDING
                     positionAndBlendingDataSpecular.blending = _SPECULAR_STYLING_BLENDING;
                #endif
            #endif
            DoBlending(lllllllllllllll4, 1 - llllll8, positionAndBlendingDataSpecular.blending, stylingDataSpecular.color);
        }
#endif
#if _ENABLE_RIM_STYLING || !_USE_OPTIMIZATION_DEFINES   
        #if !_USE_OPTIMIZATION_DEFINES
        if (llllllllllllllll6)
        #endif
        {
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _RIM_STYLING_BLENDING
                    positionAndBlendingDataRim.blending = _RIM_STYLING_BLENDING;
            #endif
            #ifdef _RIM_STYLING_DRAWSPACE
                uvSpaceDataRim.drawSpace = _RIM_STYLING_DRAWSPACE;
            #endif
            #ifdef _RIM_STYLING_COORDINATESYSTEM
                uvSpaceDataRim.coordinateSystem = _RIM_STYLING_COORDINATESYSTEM;
            #endif        
            #ifdef _RIM_STYLE
                stylingDataRim.style = _RIM_STYLE;
            #endif
            #if _RIM_STYLING_RANDOMIZER
                stylingRandomDataRim.enableRandomizer = 1;
            #else
                stylingRandomDataRim.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataRim;
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _RIM_STYLING_RANDOMIZER_PERLIN
                requiredNoiseDataRim.perlinNoise = 1;
            #else
                requiredNoiseDataRim.perlinNoise = 0;
            #endif
            #ifdef _RIM_STYLING_RANDOMIZER_PERLIN_FLOORED
                requiredNoiseDataRim.perlinNoiseFloored = 1;
            #else
                requiredNoiseDataRim.perlinNoiseFloored = 0;
            #endif         
            #ifdef _RIM_STYLING_RANDOMIZER_WHITE
                requiredNoiseDataRim.whiteNoise = 1;
            #else
                requiredNoiseDataRim.whiteNoise = 0;
            #endif
            #ifdef _RIM_STYLING_RANDOMIZER_WHITE_FLOORED
                requiredNoiseDataRim.whiteNoiseFloored = 1;
            #else
                requiredNoiseDataRim.whiteNoiseFloored = 0;
            #endif      
        #else            
            requiredNoiseDataRim.perlinNoise = 1;
            requiredNoiseDataRim.perlinNoiseFloored = 1;
            requiredNoiseDataRim.whiteNoise = 1;
            requiredNoiseDataRim.whiteNoiseFloored = 1;
        #endif
    #if _URP
            float2 lllllllllllllllll10 = ConvertToDrawSpace(inputData, lllllllllllllllllllllllllllllll0, uvSpaceDataRim, lllllllllllllllllllllll0);
    #else
            float2 lllllllllllllllll10 = ConvertToDrawSpace(d.worldSpacePosition, lllllllllllllllllllllllllllllll0, uvSpaceDataRim, lllllllllllllllllllllll0);
    #endif
            float2 lllllllllllllllll2 = RotateUV(lllllllllllllllll10, stylingDataRim.rotation);
            NoiseSampleData noiseSampleData = SampleNoiseData(lllllllllllllllll2, stylingDataRim, stylingRandomDataRim, requiredNoiseDataRim, llllllllllllllllllllllllll2, lllllllllllllllllllllllllll2);
            if (llllllllllllllllllllll5 == 0 || lllllllllllllllll6 == 0) 
            {
            #if _URP
                llllll2 = CalculateRimMask(lllllllllllllllllllllllllll7, mainLight.direction, llllllllllllllll1, llllllllllllllllll6, lllllllllllllllllll6, lllllllllllllllllll1, llllllllllllllllllll6, lllllllll5, llll5, lllll2);
            #else
                llllll2 = CalculateRimMask(lllllllllllllllllllllllllll7, light.dir, llllllllllllllll1, llllllllllllllllll6, lllllllllllllllllll6, lllllllllllllllllll1, llllllllllllllllllll6, lllllllll5, llll5, lllll2);
            #endif
            }
            llllll2 = saturate(llllll2 - llllllllllllllllllll1 * 10);
            float llllll8 = 0;
            if (stylingDataRim.style == 0) 
            {
                llllll8 = Hatching(llllll2, lllllllllllllllll2, stylingDataRim, stylingRandomDataRim, noiseSampleData, llllllll3);
                llllll8 = 1 - llllll8;
            }
            else if (stylingDataRim.style == 1) 
            {
                float llllllllllll4 = Halftones(llllll2, lllllllllllllllll2, stylingDataRim, stylingRandomDataRim, noiseSampleData);
                llllll8 = llllllllllll4;
            }
            DoBlending(lllllllllllllll4, 1-llllll8, positionAndBlendingDataRim.blending, stylingDataRim.color);
        }
    #endif
    }
#endif
    #if _URP
        AlphaDiscard(surface.alpha, 0.5);
    #else
    #endif


}




void AddTheToonShader(inout float4 albedo,

#if _URP
    InputData inputData, 
    SurfaceData surface,
#else
    #if _USESPECULAR || _USESPECULARWORKFLOW || _SPECULARFROMMETALLIC
                 SurfaceOutputStandardSpecular o,
    #elif _BDRFLAMBERT || _BDRF3 || _SIMPLELIT

                 SurfaceOutput o,
    #else
                 SurfaceOutputStandard o,
    #endif

    UnityGI gi,
#if !_PASSFORWARDADD
    UnityGIInput giInput,
#endif
#endif

 ShaderData d
#if _URP
    #if UNITY_VERSION >= 202120
, float3 normalTS
    #endif
#endif
)
{
    
    
    float2 uv = d.texcoord0.xy;
    
    

    
    float3 pureNormal = d.worldSpaceNormal;

    float4 screenUV = d.extraV2F0;
    

    
    UVSpaceData uvSpaceDataShading;
    uvSpaceDataShading.drawSpace = _DrawSpace;
    uvSpaceDataShading.coordinateSystem = _CoordinateSystem;
    uvSpaceDataShading.polarCenterMode = _PolarCenterMode;
    uvSpaceDataShading.polarCenter = _PolarCenter;
    uvSpaceDataShading.sSCameraDistanceScaled = _SSCameraDistanceScaled;
    uvSpaceDataShading.anchorSSToObjectsOrigin = _AnchorSSToObjectsOrigin;
    
    UVSpaceData uvSpaceDataCastShadows;
    uvSpaceDataCastShadows.drawSpace = _CastShadowsDrawSpace;
    uvSpaceDataCastShadows.coordinateSystem = _CastShadowsCoordinateSystem;
    uvSpaceDataCastShadows.polarCenterMode = _CastShadowsPolarCenterMode;
    uvSpaceDataCastShadows.polarCenter = _CastShadowsPolarCenter;
    uvSpaceDataCastShadows.sSCameraDistanceScaled = _CastShadowsSSCameraDistanceScaled;
    uvSpaceDataCastShadows.anchorSSToObjectsOrigin = _CastShadowsAnchorSSToObjectsOrigin;
    
    UVSpaceData uvSpaceDataSpecular;
    uvSpaceDataSpecular.drawSpace = _SpecularDrawSpace;
    uvSpaceDataSpecular.coordinateSystem = _SpecularCoordinateSystem;
    uvSpaceDataSpecular.polarCenterMode = _SpecularPolarCenterMode;
    uvSpaceDataSpecular.polarCenter = _SpecularPolarCenter;
    uvSpaceDataSpecular.sSCameraDistanceScaled = _SpecularSSCameraDistanceScaled;
    uvSpaceDataSpecular.anchorSSToObjectsOrigin = _SpecularAnchorSSToObjectsOrigin;

    UVSpaceData uvSpaceDataRim;
    uvSpaceDataRim.drawSpace = _RimDrawSpace;
    uvSpaceDataRim.coordinateSystem = _RimCoordinateSystem;
    uvSpaceDataRim.polarCenterMode = _RimPolarCenterMode;
    uvSpaceDataRim.polarCenter = _RimPolarCenter;
    uvSpaceDataRim.sSCameraDistanceScaled = _RimSSCameraDistanceScaled;
    uvSpaceDataRim.anchorSSToObjectsOrigin = _RimAnchorSSToObjectsOrigin;



    GeneralStylingData generalStylingData;
    generalStylingData.enableDistanceFade = _EnableStylingDistanceFade;
    generalStylingData.distanceFadeStartDistance = _StylingDFStartingDistance;
    generalStylingData.distanceFadeFalloff = _StylingDFFalloff;
    generalStylingData.adjustDistanceFadeValue = _StylingAdjustDistanceFadeValue;
    generalStylingData.distanceFadeValue = _StylingDistanceFadeValue;

    StylingData stylingDataShading;
    stylingDataShading.style = _ShadingStyle;
    stylingDataShading.type = 0;
    stylingDataShading.color = _StylingColor;
    stylingDataShading.rotation = _StylingShadingInitialDirection;
    stylingDataShading.rotationBetweenCells = _StylingShadingRotationBetweenCells;
    stylingDataShading.density = _StylingShadingDensity;
    stylingDataShading.offset = _StylingShadingHalftonesOffset;
    stylingDataShading.size = _StylingShadingThickness;
    stylingDataShading.sizeControl = _StylingShadingThicknessControl;
    stylingDataShading.sizeFalloff = _StylingShadingThicknessFalloff;
    stylingDataShading.roundness = _StylingShadingHalftonesRoundness;
    stylingDataShading.roundnessFalloff = _StylingShadingHalftonesRoundnessFalloff;
    stylingDataShading.hardness = _StylingShadingHardness;
    stylingDataShading.opacity = _StylingShadingOpacity;
    stylingDataShading.opacityFalloff = _StylingShadingOpacityFalloff;

    
    
    
    StylingData stylingDataCastShadows;    
    
    stylingDataCastShadows.style = _CastShadowsStyle;
    stylingDataCastShadows.type = 1;
    stylingDataCastShadows.color = _StylingCastShadowsColor;
    stylingDataCastShadows.rotation = _StylingCastShadowsInitialDirection;
    stylingDataCastShadows.rotationBetweenCells = _StylingCastShadowsRotationBetweenCells;
    stylingDataCastShadows.density = _StylingCastShadowsDensity;
    stylingDataCastShadows.offset = _StylingCastShadowsHalftonesOffset;
    stylingDataCastShadows.size = _StylingCastShadowsThickness;
    stylingDataCastShadows.sizeControl = _StylingCastShadowsThicknessControl;
    stylingDataCastShadows.sizeFalloff = _StylingCastShadowsThicknessFalloff;
    stylingDataCastShadows.roundness = _StylingCastShadowsHalftonesRoundness;
    stylingDataCastShadows.roundnessFalloff = _StylingCastShadowsHalftonesRoundnessFalloff;
    stylingDataCastShadows.hardness = _StylingCastShadowsHardness;
    stylingDataCastShadows.opacity = _StylingCastShadowsOpacity;
    stylingDataCastShadows.opacityFalloff = _StylingCastShadowsOpacityFalloff;
    
    StylingData stylingDataSpecular;
    stylingDataSpecular.style = _SpecularStyle;
    stylingDataSpecular.type = 1;
    stylingDataSpecular.color = _StylingSpecularColor;
    stylingDataSpecular.rotation = _StylingSpecularRotation;
    stylingDataSpecular.density = _StylingSpecularDensity;
    stylingDataSpecular.offset = _StylingSpecularHalftonesOffset;
    stylingDataSpecular.size = _StylingSpecularThickness;
    stylingDataSpecular.sizeControl = _StylingSpecularThicknessControl;
    stylingDataSpecular.sizeFalloff = _StylingSpecularThicknessFalloff;
    stylingDataSpecular.roundness = _StylingSpecularHalftonesRoundness;
    stylingDataSpecular.roundnessFalloff = _StylingSpecularHalftonesRoundnessFalloff;
    stylingDataSpecular.hardness = _StylingSpecularHardness;
    stylingDataSpecular.opacity = _StylingSpecularOpacity;
    stylingDataSpecular.opacityFalloff = _StylingSpecularOpacityFalloff;

    StylingData stylingDataRim;
    stylingDataRim.style = _RimStyle;
    stylingDataRim.type = 1;
    stylingDataRim.color = _StylingRimColor;
    stylingDataRim.rotation = _StylingRimRotation;
    stylingDataRim.density = _StylingRimDensity;
    stylingDataRim.offset = _StylingRimHalftonesOffset;
    stylingDataRim.size = _StylingRimThickness;
    stylingDataRim.sizeControl = _StylingRimThicknessControl;
    stylingDataRim.sizeFalloff = _StylingRimThicknessFalloff;
    stylingDataRim.roundness = _StylingRimHalftonesRoundness;
    stylingDataRim.roundnessFalloff = _StylingRimHalftonesRoundnessFalloff;
    stylingDataRim.hardness = _StylingRimHardness;
    stylingDataRim.opacity = _StylingRimOpacity;
    stylingDataRim.opacityFalloff = _StylingRimOpacityFalloff;

    
 
    
    PositionAndBlendingData positionAndBlendingDataShading;
            
    positionAndBlendingDataShading.blending = _StylingShadingBlending;
    positionAndBlendingDataShading.isInverted = _StylingShadingIsInverted;

    PositionAndBlendingData positionAndBlendingDataCastShadows;
    positionAndBlendingDataCastShadows.blending = _StylingCastShadowsBlending;
    positionAndBlendingDataCastShadows.isInverted = _StylingCastShadowsIsInverted;
    
    PositionAndBlendingData positionAndBlendingDataSpecular;
            
    positionAndBlendingDataSpecular.blending = _StylingSpecularBlending;
    positionAndBlendingDataSpecular.isInverted = _StylingSpecularIsInverted;

    PositionAndBlendingData positionAndBlendingDataRim;
            
    positionAndBlendingDataRim.blending = _StylingRimBlending;
    positionAndBlendingDataRim.isInverted = _StylingRimIsInverted;


    StylingRandomData stylingRandomDataShading;
    stylingRandomDataShading.enableRandomizer = _EnableShadingRandomizer;
    stylingRandomDataShading.perlinNoiseSize = _ShadingNoise1Size;
    stylingRandomDataShading.perlinNoiseSeed = _ShadingNoise1Seed;
    stylingRandomDataShading.whiteNoiseSeed = _ShadingNoise2Seed;
    stylingRandomDataShading.noiseIntensity = _NoiseIntensity;
    stylingRandomDataShading.spacingRandomMode = _SpacingRandomMode;
    stylingRandomDataShading.spacingRandomIntensity = _SpacingRandomIntensity;
    stylingRandomDataShading.opacityRandomMode = _OpacityRandomMode;
    stylingRandomDataShading.opacityRandomIntensity = _OpacityRandomIntensity;
    stylingRandomDataShading.lengthRandomMode = _LengthRandomMode;
    stylingRandomDataShading.lengthRandomIntensity = _LengthRandomIntensity;
    stylingRandomDataShading.hardnessRandomMode = _HardnessRandomMode;
    stylingRandomDataShading.hardnessRandomIntensity = _HardnessRandomIntensity;
    stylingRandomDataShading.thicknessRandomMode = _ThicknessRandomMode;
    stylingRandomDataShading.thicknesshRandomIntensity = _ThicknesshRandomIntensity;
    
    StylingRandomData stylingRandomDataCastShadows;
    stylingRandomDataCastShadows.enableRandomizer = _EnableCastShadowsRandomizer;
    stylingRandomDataCastShadows.perlinNoiseSize = _CastShadowsNoise1Size;
    stylingRandomDataCastShadows.perlinNoiseSeed = _CastShadowsNoise1Seed;
    stylingRandomDataCastShadows.whiteNoiseSeed = _CastShadowsNoise2Seed;
    stylingRandomDataCastShadows.noiseIntensity = _CastShadowsNoiseIntensity;
    stylingRandomDataCastShadows.spacingRandomMode = _CastShadowsSpacingRandomMode;
    stylingRandomDataCastShadows.spacingRandomIntensity = _CastShadowsSpacingRandomIntensity;
    stylingRandomDataCastShadows.opacityRandomMode = _CastShadowsOpacityRandomMode;
    stylingRandomDataCastShadows.opacityRandomIntensity = _CastShadowsOpacityRandomIntensity;
    stylingRandomDataCastShadows.lengthRandomMode = _CastShadowsLengthRandomMode;
    stylingRandomDataCastShadows.lengthRandomIntensity = _CastShadowsLengthRandomIntensity;
    stylingRandomDataCastShadows.hardnessRandomMode = _CastShadowsHardnessRandomMode;
    stylingRandomDataCastShadows.hardnessRandomIntensity = _CastShadowsHardnessRandomIntensity;
    stylingRandomDataCastShadows.thicknessRandomMode = _CastShadowsThicknessRandomMode;
    stylingRandomDataCastShadows.thicknesshRandomIntensity = _CastShadowsThicknesshRandomIntensity;

    StylingRandomData stylingRandomDataSpecular;
    stylingRandomDataSpecular.enableRandomizer = _EnableSpecularRandomizer;
    stylingRandomDataSpecular.perlinNoiseSize = _SpecularNoise1Size;
    stylingRandomDataSpecular.perlinNoiseSeed = _SpecularNoise1Seed;
    stylingRandomDataSpecular.whiteNoiseSeed = _SpecularNoise2Seed;
    stylingRandomDataSpecular.noiseIntensity = _SpecularNoiseIntensity;
    stylingRandomDataSpecular.spacingRandomMode = _SpecularSpacingRandomMode;
    stylingRandomDataSpecular.spacingRandomIntensity = _SpecularSpacingRandomIntensity;
    stylingRandomDataSpecular.opacityRandomMode = _SpecularOpacityRandomMode;
    stylingRandomDataSpecular.opacityRandomIntensity = _SpecularOpacityRandomIntensity;
    stylingRandomDataSpecular.lengthRandomMode = _SpecularLengthRandomMode;
    stylingRandomDataSpecular.lengthRandomIntensity = _SpecularLengthRandomIntensity;
    stylingRandomDataSpecular.hardnessRandomMode = _SpecularHardnessRandomMode;
    stylingRandomDataSpecular.hardnessRandomIntensity = _SpecularHardnessRandomIntensity;
    stylingRandomDataSpecular.thicknessRandomMode = _SpecularThicknessRandomMode;
    stylingRandomDataSpecular.thicknesshRandomIntensity = _SpecularThicknesshRandomIntensity;

    StylingRandomData stylingRandomDataRim;
    stylingRandomDataRim.enableRandomizer = _EnableRimRandomizer;
    stylingRandomDataRim.perlinNoiseSize = _RimNoise1Size;
    stylingRandomDataRim.perlinNoiseSeed = _RimNoise1Seed;
    stylingRandomDataRim.whiteNoiseSeed = _RimNoise2Seed;
    stylingRandomDataRim.noiseIntensity = _RimNoiseIntensity;
    stylingRandomDataRim.spacingRandomMode = _RimSpacingRandomMode;
    stylingRandomDataRim.spacingRandomIntensity = _RimSpacingRandomIntensity;
    stylingRandomDataRim.opacityRandomMode = _RimOpacityRandomMode;
    stylingRandomDataRim.opacityRandomIntensity = _RimOpacityRandomIntensity;
    stylingRandomDataRim.lengthRandomMode = _RimLengthRandomMode;
    stylingRandomDataRim.lengthRandomIntensity = _RimLengthRandomIntensity;
    stylingRandomDataRim.hardnessRandomMode = _RimHardnessRandomMode;
    stylingRandomDataRim.hardnessRandomIntensity = _RimHardnessRandomIntensity;
    stylingRandomDataRim.thicknessRandomMode = _RimThicknessRandomMode;
    stylingRandomDataRim.thicknesshRandomIntensity = _RimThicknesshRandomIntensity;


    
    DoToonShading(
#if _URP
    inputData,
    surface,
#else
    o,
    gi,
    #if !_PASSFORWARDADD
    giInput,
    #endif
#endif
    d,
#if _URP
    #if UNITY_VERSION >= 202120
    normalTS,
    #endif
#endif
    albedo, _NumberOfCells, _CellTransitionSmoothness, uv, screenUV, _HatchingMap,
            
            _ShadingMode, _LightFunction,

            _EnableToonShading, _ShadingFunction,

            _GradientTex, _GradientTex_TexelSize, _GradientMode, _GradientBlending, _GradientBlendFactor,

            _EnableShadows, _CoreShadowColor, _TerminatorWidth, _TerminatorSmoothness, _FormShadowColor,
            _EnableCastShadows, _CastShadowsStrength, _CastShadowsSmoothness, _CastShadowColorMode, _CastShadowColor,
            _ShadingAffectedByNormalMap,
            
            _EnableSpecular, _SpecularBlending, _SpecularColor, _SpecularSize, _SpecularSmoothness, _SpecularOpacity, _SpecularAffectedByNormalMap,
            
            _EnableRim, _RimBlending, _RimColor, _RimSize, _RimSmoothness, _RimOpacity, _RimAffectedArea, _RimAffectedByNormalMap,
            
    
            _EnableStyling, 
    
            generalStylingData, _HatchingAffectedByNormalMap, _EnableAntiAliasing,
    
            _EnableShadingStyling, 
            _StylingShadingSyncWithOtherStyling,
            _SyncWithLightPartitioning, _NumberOfCellsHatching, _StylingOvermodelingFactor,
            positionAndBlendingDataShading, uvSpaceDataShading, stylingDataShading, stylingRandomDataShading,
    
            _EnableCastShadowsStyling,
            _StylingCastShadowsSyncWithOtherStyling,
            _CastShadowsNumberOfCellsHatching, _StylingCastShadowsSmoothness, 
            positionAndBlendingDataCastShadows, uvSpaceDataCastShadows, stylingDataCastShadows, stylingRandomDataCastShadows,
    
            _EnableSpecularStyling,
            _SyncWithSpecular, _StylingSpecularSize, _StylingSpecularSmoothness,
            _StylingSpecularSyncWithOtherStyling,
            positionAndBlendingDataSpecular, uvSpaceDataSpecular, stylingDataSpecular, stylingRandomDataSpecular,
    
            _EnableRimStyling,
            _SyncWithRim, _StylingRimSize, _StylingRimSmoothness, _StylingRimAffectedArea, 
            _StylingRimSyncWithOtherStyling,
            positionAndBlendingDataRim, uvSpaceDataRim, stylingDataRim, stylingRandomDataRim,


            _NoiseMap1, _NoiseMap2, _NoiseTex2_TexelSize,   
            
            pureNormal);
}





#endif
