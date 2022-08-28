Shader "Custom/216page_MetalicSmoothness"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0
        _Smoothness ("Smoothness", Range(0,1)) =0.5
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _Occlusion("Occlusion", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _Occlusion;
        float _Metallic;
        float _Smoothness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            // fixed4 n = tex2D (_BumpMap, IN.uv_BumpMap); // 일반 텍스쳐처럼 이렇게 처리하면 안됨.

            // float3               //float4
            o.Normal = UnpackNormal(tex2D (_BumpMap, IN.uv_BumpMap));

            // float
            o.Occlusion = tex2D(_Occlusion, IN.uv_MainTex);
            // o.Occlusion = c.a; // 오쿨루젼을 알파 채널 저장한 psd 파일로 텍스쳐 한개만 가져와서 쓴다면.

            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
            // o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
