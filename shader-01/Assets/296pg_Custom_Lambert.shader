Shader "Custom/296pg_Custom_Lambert"
{   // 유니티 4까지 사용되었던 Bumped Diffuse와 완전히 같은 쉐이더이며,    유니티 5에서도 Legacy Shader/ Bumpped Diffuse 와도 완전 같은 쉐이더이다. 
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}                  
        _BumpMap ("NormalMap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test

        sampler2D _MainTex;
        sampler2D _BumpMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Alpha = c.a;
        }

        float4 LightingTest (SurfaceOutput s, float lightDir, float atten){
            // float ndotl = dot(s.Normal, lightDir)*0.5 +0.5; // 311pg 하프렘버트.
            //return pow(ndotl, 3);// 하프렘버트 너무 밝아서 세제곱 해서 쓰기도함.

            float ndotl = saturate(dot(s.Normal, lightDir));
            float4 final;             
            final.rgb = ndotl * s.Albedo * _LightColor0.rgb * atten;   //_LightColor0  으로 조명의 색상과 강도를 가져옴.
            final.a = s.Alpha;                     // Albedo, light 곱해진거니. 디퓨즈된거임. // atten 감쇠. -> 또한  없으면 자기그림자 자기 x, 다른그림자도 자기에 안드리우짐. 
            return final;
            
        }
        
        ENDCG
    }
    FallBack "Diffuse"
}
