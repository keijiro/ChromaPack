Shader "ChromaPack/UI Cutout"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15
	}

	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
		}
		
		Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp] 
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
		}

		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
			};
			
			fixed4 _Color;

			v2f vert(appdata_t IN)
			{
				v2f OUT;
				OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				OUT.texcoord = IN.texcoord;
#ifdef UNITY_HALF_TEXEL_OFFSET
				OUT.vertex.xy += (_ScreenParams.zw-1.0)*float2(-1,1);
#endif
				OUT.color = IN.color * _Color;
				return OUT;
			}

			sampler2D _MainTex;

      half3 YCbCrtoRGB(half y, half cb, half cr)
      {
        return half3(
          y                 + 1.402    * cr,
          y - 0.344136 * cb - 0.714136 * cr,
          y + 1.772    * cb
          );
      }

			fixed4 frag(v2f IN) : SV_Target
			{
        float2 uv = IN.texcoord;

        half y  = tex2D(_MainTex, uv * float2(2.0 / 3, 1.0)).a;
        half cb = tex2D(_MainTex, uv * float2(1.0 / 3, 0.5) + float2(2.0 / 3, 0.5)).a - 0.5;
        half cr = tex2D(_MainTex, uv * float2(1.0 / 3, 0.5) + float2(2.0 / 3, 0.0)).a - 0.5;

        clip(y - 1.0 / 256);
        y = (y - 1.0 / 256) * 256.0 / 255;

        return half4(YCbCrtoRGB(y, cb, cr), 1);

				//half4 color = tex2D(_MainTex, IN.texcoord) * IN.color;
				//clip (color.a - 0.01);
				//return color;
			}
		ENDCG
		}
	}
}
