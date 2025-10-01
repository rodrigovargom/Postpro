Shader "Custom/DotProduct"
{
 
    SubShader
    {

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert
        struct Input{
            float2 viewDir;
            };

        void surf (Input IN, inout SurfaceOutput o)
        {
           half dotp= dot(IN.viewDir,o.Normal);
           o.Albedo=float3 (dotp,dotp,dotp);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
