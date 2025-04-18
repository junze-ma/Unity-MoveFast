#ifndef THETOONSHADER_LIGHTING_FUNCTION
#define THETOONSHADER_LIGHTING_FUNCTION


struct ToonShadingData
{
    half enableToonShading;
    float3 normalWS;
    float3 normalWSNoMap;
    float cellTransitionSmoothness;
    half numberOfCells;
    float specularEdgeSmoothness;
    half shadingAffectByNormalMap;
    half specularAffectedByNormalMap;
};
float Posterize(float value, ToonShadingData toonShadingData)
{
    if (toonShadingData.enableToonShading == 1)
    {
        float ll0 = (1.0 / toonShadingData.numberOfCells) * toonShadingData.cellTransitionSmoothness; 
        float lll0;
        half llll0 = ceil(value * toonShadingData.numberOfCells) / toonShadingData.numberOfCells;
        half lllll0 = max(0, ceil(value * toonShadingData.numberOfCells) - 1) / toonShadingData.numberOfCells;
        lll0 = max(llll0 * smoothstep(lllll0, lllll0 + ll0, value), lllll0);
        return lerp(lll0, value, toonShadingData.cellTransitionSmoothness);
    }
    else
    {
        return value;
    }
}
float3 Posterize(float3 value, ToonShadingData toonShadingData)
{
    if (toonShadingData.enableToonShading == 1)
    {
        float ll0 = (1.0 / toonShadingData.numberOfCells) * toonShadingData.cellTransitionSmoothness; 
        float3 lll0;
        half3 llll0 = ceil(value * toonShadingData.numberOfCells) / toonShadingData.numberOfCells;
        half3 lllll0 = max(0, ceil(value * toonShadingData.numberOfCells) - 1.0) / toonShadingData.numberOfCells;
        lll0 = max(llll0 * smoothstep(lllll0, lllll0 + ll0, value), lllll0);
        return lerp(lll0, value, toonShadingData.cellTransitionSmoothness);
    }
    else
    {
        return value;
    }
}
float CalculateCellShadingPartitioning(half3 direction, ToonShadingData toonShadingData)
{
    if (toonShadingData.enableToonShading == 1)
    {
        half3 llllllllllll0;
        if (toonShadingData.shadingAffectByNormalMap == 0)
        {
            llllllllllll0 = toonShadingData.normalWSNoMap;
        }
        else
        {
            llllllllllll0 = toonShadingData.normalWS;
        }
        float lllllllllllll0 = saturate(dot(llllllllllll0, direction));
        return Posterize(lllllllllllll0, toonShadingData);
    }
    else
    {
        return saturate(dot(toonShadingData.normalWS, direction));
    }
}
half3 PosterizeShifted(half3 value, ToonShadingData toonShadingData)
{
    if (toonShadingData.enableToonShading == 1)
    {
        half3 lllllllllllllll0 = value;
        float ll0 = (1.0 / toonShadingData.numberOfCells) * toonShadingData.cellTransitionSmoothness; 
        float lllllllllllllllll0 = (1 / (toonShadingData.numberOfCells + 1)) + ll0 * ((0.25 / toonShadingData.numberOfCells) - (1 / (toonShadingData.numberOfCells + 1)));
        float llllllllllllllllll0 = 1 + (1 / toonShadingData.numberOfCells);
        value = (value - lllllllllllllllll0) * llllllllllllllllll0;
        half3 llll0 = ceil(value * toonShadingData.numberOfCells) / toonShadingData.numberOfCells;
        half3 lllll0 = max(0, ceil(value * toonShadingData.numberOfCells) - 1) / toonShadingData.numberOfCells;
        value = max(llll0 * smoothstep(lllll0, lllll0 + ll0, value), lllll0);
        value = lerp(value, lllllllllllllll0, toonShadingData.cellTransitionSmoothness);
    }
    return value;
}


#endif
