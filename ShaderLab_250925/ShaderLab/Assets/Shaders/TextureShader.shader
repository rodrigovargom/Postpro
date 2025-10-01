Shader "Custom/TextureShader"
{
    Properties
    {
      
        _mainTexture ("Main Texture", 2D) = "white" {}
        _normalTexture ("Normal Texture",2D)="bump"{}
        _normalIntensity ("Normal Intensity",Range(0,10))=1
        _smoothness ("Smoothness Intensity", Range(0,1))=0.5
        _metallic ("Metallic Intensity", Range(0,1))=0.5
        _emissiveColor ("Emissive Color", Color) = (0,0,0,1)
        _emissiveTexture ("Emissive Texture", 2D) = "black"{}
        _emissiveIntensity("Emissive Intensity",Range(0,1))=0.5
        _emissionColor ("Emission Color", Color) = (0,0,0,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

         struct Input {
            float2 uv_mainTexture;
            float2 uv_emisssionTexture;
            float2 uv_normalTexture;
            };

        sampler2D _mainTexture;
        sampler2D _emissiveTexture;
        half _emissiveIntensity,_normalIntensity;
        float4 _emissionColor;
        half _smoothness;
        half _metallic;
        float4 _emissiveColor ;      

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
               o.Albedo= tex2D(_mainTexture,IN.uv_mainTexture); 
               o.Smoothness= _smoothness;
               o.Metallic= _metallic;
               o.Emission= tex2D(_emissiveTexture,IN.uv_mainTexture).rgb*(_emissiveIntensity*_emissionColor.rgb);
               float3 normalTex= UnpackNormal(tex2D(_mainTexture,IN.uv_normalTexture));
               float3 flatNormal=float3(0,0,1);
               o.Normal=normalize(lerp(flatNormal,normalTex,_normalIntensity));

        }
        ENDCG
    }
    FallBack "Diffuse"
}
