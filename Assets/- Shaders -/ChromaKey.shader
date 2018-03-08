Shader "Custom/ChromaKey" {

	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
	_AlphaValue("Alpha Value", Range(0.0,1.0)) = 1.0
	}

		SubShader{
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 200

		CGPROGRAM
#pragma surface surf Lambert alpha

		sampler2D _MainTex;
	float _AlphaValue;

	struct Input {
		float2 uv_MainTex;
	};

	void surf(Input IN, inout SurfaceOutput o) {
		half4 c = tex2D(_MainTex, IN.uv_MainTex);
		o.Emission = c.rgb;

		// Green screen level - leaves minor green glow
		//if (c.g >= 0.30f && c.r <= 0.65f && c.b <= 0.65f && _AlphaValue == 0.0)
		if (c.g >= 0.25f && c.r <= 0.55f && c.b <= 0.55f && _AlphaValue == 0.0)
		{
			o.Alpha = 0.0;
		}
		else
		{
			o.Alpha = c.a;
		}

	}
	ENDCG
	}
		FallBack "Diffuse"
}