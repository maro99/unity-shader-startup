Shader "Custom/166page_uv"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _FlowSpeed("Flow Speed", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;
        float _FlowSpeed;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Metallic;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // fixed4 c = tex2D (_MainTex, IN.uv_MainTex + _Time.y); // 좌측하단 이동.  
            // fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x + _Time.y, IN.uv_MainTex.y )); // x 축으로 이동. 
            fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x , IN.uv_MainTex.y + _Time.y * _FlowSpeed)); // y 축으로 이동. 

            // o.Emission = float3(IN.uv_MainTex.x, IN.uv_MainTex.y, 0);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
