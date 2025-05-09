// PBR Shader adapted from Standard (Metallic) that works in built-in and URP pipelines
// Supports 1 directional light without specular
Shader "Unlit/BasicPBR"
{
    Properties
    {
        _Color ("Color", Color) =  (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        [NoScaleOffset] _MetallicGlossMap("Metallic", 2D) = "black" {}
        _GlossMapScale("Smoothness", Range(0,1)) = 1
        [NoScaleOffset] _BumpMap("Normal Map", 2D) = "bump" {}
        [NoScaleOffset] _OcclusionMap("Occlusion", 2D) = "white" {}
        [HDR] _EmissionColor("Emission Color", Color) = (0,0,0,0)
        [NoScaleOffset] _EmissionMap("Emission", 2D) = "white" {}

        [Toggle(WETMAP)] _UseWetMap("Wet Map", Float) = 0
        [NoScaleOffset] _WetMap("Wet Map", 2D) = "black" {}
        [Enum(UV0,0,UV1,1)] _WetMapUV("Wet Map UV Set", Float) = 1
        // droplets for non-porous horizontal surfaces
        [HideInInspector] _WetBumpMap("Wet Bump Map", 2D) = "bump" {}

        [Toggle(ALPHA_CLIP)] _AlphaClip("Alpha Clip", Float) = 0
        _Cutoff("Cutoff", Float) = 0.5

        [Toggle(VERTEX_COLOR_LIGHTMAP)] _VertexColorLightmap("Vertex Color Lightmap", Float) = 0
        _VertexColorLightmapScale("Vertex Color Lightmap Scale", Float) = 1

        [Enum(UnityEngine.Rendering.CullMode)] _CullMode("Cull Mode", Int) = 2
        [Toggle] _ZWrite("Z Write", Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Source Blend", Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Destination mode", Float) = 0
    }

    CGINCLUDE
    #include "UnityCG.cginc"
    #pragma shader_feature _ ALPHA_CLIP
    #pragma shader_feature _ WETMAP

    struct appdata
    {
        float4 vertex : POSITION;
        float4 tangent : TANGENT;
        float3 normal : NORMAL;
        float4 texcoord : TEXCOORD0;
        float4 texcoord1 : TEXCOORD1;
        fixed4 color : COLOR;
        UNITY_VERTEX_INPUT_INSTANCE_ID
    };

    struct v2f
    {
        float2 uv0 : TEXCOORD0;
        float2 uv1 : TEXCOORD1;
        float3 normalWS : TEXCOORD2;
        float3 tangentWS: TEXCOORD3;
        float3 bitangentWS: TEXCOORD4;
        float3 positionWS  : TEXCOORD5;
        fixed4 color : COLOR;
        UNITY_FOG_COORDS(6)
        float4 vertex : SV_POSITION;
        UNITY_VERTEX_OUTPUT_STEREO
    };

    // standard properties
    fixed4 _Color;
    sampler2D _MainTex;
    float4 _MainTex_ST;
    sampler2D _MetallicGlossMap;
    float _GlossMapScale;
    sampler2D _BumpMap;
    sampler2D _OcclusionMap;
    fixed4 _EmissionColor;
    sampler2D _EmissionMap;

    sampler2D _WetMap;
    half _WetMapUV;
    sampler2D _WetBumpMap;
    float _VertexColorLightmapScale;
    float _Cutoff;

    // globals
    float3 _BasicPBRLightDir;
    fixed3 _BasicPBRLightColor;

    v2f vert(appdata v)
    {
        v2f o;

        UNITY_SETUP_INSTANCE_ID(v);
        UNITY_INITIALIZE_OUTPUT(v2f, o);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

        o.vertex = UnityObjectToClipPos(v.vertex);
        o.uv0 = TRANSFORM_TEX(v.texcoord, _MainTex);
        o.uv1 = v.texcoord1;
        o.positionWS = mul(unity_ObjectToWorld, v.vertex);
        o.normalWS = normalize(UnityObjectToWorldNormal(v.normal));
        o.tangentWS = normalize(mul(unity_ObjectToWorld, v.tangent).xyz);
        o.bitangentWS = normalize(cross(o.normalWS, o.tangentWS.xyz));
        o.color = v.color;

        UNITY_TRANSFER_FOG(o, o.vertex);

        return o;
    }

    // UnityStandardUtils.cginc#L46
    half3 DiffuseAndSpecularFromMetallic(half3 albedo, half metallic, out half3 specColor, out half oneMinusReflectivity)
    {
        specColor = lerp(unity_ColorSpaceDielectricSpec.rgb, albedo, metallic);
        half oneMinusDielectricSpec = unity_ColorSpaceDielectricSpec.a;
        oneMinusReflectivity = oneMinusDielectricSpec - metallic * oneMinusDielectricSpec;
        return albedo * oneMinusReflectivity;
    }

    // UnityImageBasedLighting.cginc#L522
    half3 Unity_GlossyEnvironment(half3 reflectDir, half perceptualRoughness)
    {
        perceptualRoughness = perceptualRoughness * (1.7 - 0.7 * perceptualRoughness);
        half mip = perceptualRoughness * 6;
        half4 rgbm = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectDir, mip);
        return DecodeHDR(rgbm, unity_SpecCube1_HDR);
    }

    inline half3 Pow4(half3 x)
    {
        return x * x * x * x;
    }

    // UnityStandardBRDF.cginc#L92
    inline half3 FresnelLerp(half3 F0, half3 F90, half cosA)
    {
        half t = Pow4(1 - cosA);
        return lerp(F0, F90, t);
    }

    // UnityStandardBRDF.cginc#L299
    half SurfaceReduction(float perceptualRoughness)
    {
        float roughness = perceptualRoughness * perceptualRoughness;
#ifdef UNITY_COLORSPACE_GAMMA
        return 1.0 - 0.28 * roughness * perceptualRoughness;
#else
        return 1.0 / (roughness * roughness + 1.0);
#endif
    }

    // UnityStandardBRDF.cginc#L338
    float3 Specular(float roughness, float3 normal, float3 viewDir)
    {
        half3 halfDir = normalize(-_BasicPBRLightDir + viewDir);
        float nh = saturate(dot(normal, halfDir));
        float lh = saturate(dot(_BasicPBRLightDir, halfDir));

        float a = roughness * roughness;
        float a2 = a * a;
        float d = nh * nh * (a2 - 1.f) + 1.00001f;
#ifdef UNITY_COLORSPACE_GAMMA
        float specularTerm = a / (max(0.32f, lh) * (1.5f + a) * d);
#else
        float specularTerm = a2 / (max(0.1f, lh * lh) * (a + 0.5f) * (d * d) * 4);
#endif
#if defined (SHADER_API_MOBILE)
        specularTerm = specularTerm - 1e-4f;
#endif
        return specularTerm * 0.3f;
    }

    // https://seblagarde.wordpress.com/2013/04/14/water-drop-3b-physically-based-wet-surfaces/
    void AddWater(float2 uv, float metalness, inout half3 diffuse, inout float smoothness, inout fixed4 bumpMap, float2 wsPos, float3 normalWS)
    {
#if WETMAP
        fixed wetMap = tex2D(_WetMap, uv).r;
        float porosity = saturate((1 - smoothness) - 0.2);//saturate(((1-Gloss) - 0.5)) / 0.4 );
        float factor = lerp(1, 0.2, (1 - metalness) * porosity);
        float collectWater = smoothness * max(0, normalWS.y);
        diffuse *= lerp(1.0, factor, wetMap);
        smoothness = lerp(smoothness, 0.95, saturate(wetMap * wetMap));// lerp(1, factor, 0.5 * wetMap));
        bumpMap = lerp(bumpMap, tex2D(_WetBumpMap, wsPos * 20), wetMap * collectWater);
#endif
    }

    fixed4 frag(v2f i) : SV_Target
    {
        // BRDF texture inputs
        fixed4 mainTex = tex2D(_MainTex, i.uv0);
        float4 bumpMap = tex2D(_BumpMap, i.uv0);
        fixed2 metallicGlossMap = tex2D(_MetallicGlossMap, i.uv0).ra;

        // BEDF values
        fixed4 albedo = mainTex * _Color;
#if ALPHA_CLIP
        clip(albedo.a - _Cutoff);
#endif
        float metalness = metallicGlossMap.r;
        float smoothness = metallicGlossMap.g * _GlossMapScale;

        float oneMinusReflectivity;
        float3 specColor;
        float3 diffColor = DiffuseAndSpecularFromMetallic(albedo.rgb, metalness, /*out*/ specColor, /*out*/ oneMinusReflectivity);

        AddWater((_WetMapUV == 0) ? i.uv0 : i.uv1, metalness, /*inout*/ diffColor, /*inout*/ smoothness, /*inout*/ bumpMap, i.positionWS.xz, i.normalWS);

        float3x3 tangentMatrix = transpose(float3x3(i.tangentWS, i.bitangentWS, i.normalWS));
        float3 normal = normalize(mul(tangentMatrix, UnpackNormal(bumpMap)));

        float3 ambient =
#if VERTEX_COLOR_LIGHTMAP
            i.color.rgb * _VertexColorLightmapScale;
#else
            ShadeSH9(float4(normal, 1));
#endif

        half nl = saturate(dot(normal, -_BasicPBRLightDir));
        half3 diffuse = diffColor * (ambient + _BasicPBRLightColor * nl);

        float perceptualRoughness = 1 - smoothness;

        float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.positionWS);
        half nv = abs(dot(normal, viewDir));

        float3 reflectDir = -reflect(viewDir, normal);
        float3 specularGI = Unity_GlossyEnvironment(reflectDir, perceptualRoughness);
        half grazingTerm = saturate(smoothness + (1 - oneMinusReflectivity));

        half3 specular = SurfaceReduction(perceptualRoughness) * specularGI * FresnelLerp(specColor, grazingTerm, nv); +
            + Specular(perceptualRoughness, normal, viewDir) * specColor * nl * _BasicPBRLightColor;

        // non BRDF texture inputs
        float occlusion = tex2D(_OcclusionMap, i.uv0).r;
        fixed3 emission = tex2D(_EmissionMap, i.uv0).rgb * _EmissionColor.rgb;

        half3 color = emission + (diffuse + specular) * occlusion;

        UNITY_APPLY_FOG(i.fogCoord, color);

        return fixed4(color, albedo.a);
    }
    ENDCG

    SubShader
    {
        Tags{ "RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" }
        Pass
        {
            Tags{ "LightMode" = "UniversalForward" }
            Blend [_SrcBlend] [_DstBlend]
            ZWrite [_ZWrite]
            Cull[_CullMode]
            CGPROGRAM
            #pragma shader_feature VERTEX_COLOR_LIGHTMAP
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            ENDCG
        }
    }

    SubShader
    {
        Tags{ "RenderType" = "Opaque" }
        Pass
        {
            Tags{ "LightMode" = "ForwardBase" }
            Blend [_SrcBlend][_DstBlend]
            ZWrite [_ZWrite]
            Cull [_CullMode]
            CGPROGRAM
            #pragma shader_feature VERTEX_COLOR_LIGHTMAP
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            ENDCG
        }
    }
}
