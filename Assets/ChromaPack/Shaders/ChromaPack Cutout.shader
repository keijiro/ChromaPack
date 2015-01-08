Shader "ChromaPack/Cutout"
{
    Properties
    {
        _MainTex("Base", 2D) = "white" {}
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    sampler2D _MainTex;

    half3 YCbCrtoRGB(half y, half cb, half cr)
    {
        return half3(
            y                 + 1.402    * cr,
            y - 0.344136 * cb - 0.714136 * cr,
            y + 1.772    * cb
        );
    }

    half4 frag(v2f_img i) : SV_Target 
    {
        float2 uv = i.uv;

        half y  = tex2D(_MainTex, uv * float2(2.0 / 3, 1.0)).a;
        half cb = tex2D(_MainTex, uv * float2(1.0 / 3, 0.5) + float2(2.0 / 3, 0.5)).a - 0.5;
        half cr = tex2D(_MainTex, uv * float2(1.0 / 3, 0.5) + float2(2.0 / 3, 0.0)).a - 0.5;

        clip(y - 1.0 / 256);
        y = (y - 1.0 / 256) * 256.0 / 255;

        return half4(YCbCrtoRGB(y, cb, cr), 1);
    }

    ENDCG

    SubShader
    {
        Tags { "Queue"="AlphaTest" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            ENDCG
        }
    } 
}
