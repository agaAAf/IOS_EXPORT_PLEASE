shader_type spatial;
render_mode cull_disabled, blend_mix, depth_draw_opaque;

// --- SCREEN & TEXTURE INPUTS ---
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D frosted_texture : source_color, repeat_enable;
uniform sampler2D detail_texture : source_color, repeat_enable;

// --- CONTROLS ---
uniform int lod_level : hint_range(0, 10) = 4;
uniform float brightness : hint_range(0.0, 100.0) = 1.0;
uniform float distortion_intensity : hint_range(0.0, 0.5) = 0.02;
uniform bool flip_normals = false;

// --- DETAIL & VISUAL ---
uniform float detail_strength : hint_range(0.0,40.0) = 2.0;
uniform float detail_blend : hint_range(0.0, 1.0) = 0.6;
uniform float transparency : hint_range(0.0, 1.0) = 0.85;

// --- BASE COLOR / TINT ---
uniform vec3 base_albedo : source_color = vec3(0.8, 0.9, 1.0);
uniform float base_albedo_strength : hint_range(0.0, 1.0) = 0.4;

// --- “THICKNESS” EFFECT ---
uniform float thickness_strength : hint_range(0.0, 1.0) = 0.5; // 0 = thin glass, 1 = thick ice

// --- BICUBIC FILTER HELPERS ---
float w0(float a){return (1.0/6.0)*(a*(a*(-a+3.0)-3.0)+1.0);}
float w1(float a){return (1.0/6.0)*(a*a*(3.0*a-6.0)+4.0);}
float w2(float a){return (1.0/6.0)*(a*(a*(-3.0*a+3.0)+3.0)+1.0);}
float w3(float a){return (1.0/6.0)*(a*a*a);}
float g0(float a){return w0(a)+w1(a);}
float g1(float a){return w2(a)+w3(a);}
float h0(float a){return -1.0+w1(a)/(w0(a)+w1(a));}
float h1(float a){return  1.0+w3(a)/(w2(a)+w3(a));}

vec4 texture2D_bicubic(sampler2D tex, vec2 uv, int p_lod, ivec2 tex_size){
	vec2 tex_size_lod = vec2(tex_size >> p_lod);
	vec2 pixel_size = 1.0 / tex_size_lod;
	uv = uv * tex_size_lod + vec2(0.5);
	vec2 iuv = floor(uv);
	vec2 fuv = fract(uv);
	float g0x = g0(fuv.x), g1x = g1(fuv.x);
	float h0x = h0(fuv.x), h1x = h1(fuv.x);
	float h0y = h0(fuv.y), h1y = h1(fuv.y);
	vec2 p0 = (vec2(iuv.x+h0x,iuv.y+h0y)-vec2(0.5))*pixel_size;
	vec2 p1 = (vec2(iuv.x+h1x,iuv.y+h0y)-vec2(0.5))*pixel_size;
	vec2 p2 = (vec2(iuv.x+h0x,iuv.y+h1y)-vec2(0.5))*pixel_size;
	vec2 p3 = (vec2(iuv.x+h1x,iuv.y+h1y)-vec2(0.5))*pixel_size;
	return (g0(fuv.y)*(g0x*textureLod(tex,p0,float(p_lod))+g1x*textureLod(tex,p1,float(p_lod)))) +
		   (g1(fuv.y)*(g0x*textureLod(tex,p2,float(p_lod))+g1x*textureLod(tex,p3,float(p_lod))));
}

void vertex(){
	if (flip_normals) {
		NORMAL = -NORMAL;
	}
}

void fragment(){
	vec2 screen_uv = SCREEN_UV;

	// Stable distortion (no normalize to avoid NaNs)
	vec2 distortion = (texture(frosted_texture, UV).rg - 0.5) * distortion_intensity;
	vec2 distorted_uv = screen_uv + distortion;

	// Base screen blur sample
	vec4 blurred_color = texture2D_bicubic(screen_texture, distorted_uv, lod_level, textureSize(screen_texture, 0));

	// Simulated thickness: sample screen again slightly deeper
	vec2 offset_uv = distorted_uv + distortion * 0.5;
	vec4 inner_blur = texture2D_bicubic(screen_texture, offset_uv, lod_level, textureSize(screen_texture, 0));

	// Blend both for “double mesh” density
	blurred_color.rgb = mix(blurred_color.rgb, inner_blur.rgb, thickness_strength);

	// Base brightness and tint
	vec3 base_color = blurred_color.rgb * brightness;
	base_color = mix(base_color, base_albedo, base_albedo_strength);

	// Detail texture (with alpha awareness)
	vec4 detail_col = texture(detail_texture, UV);
	vec3 combined_color = mix(base_color, base_color * detail_col.rgb * detail_strength, detail_col.a * detail_blend);

	// Output
	ALBEDO = combined_color;
	ALPHA = transparency * mix(1.0, detail_col.a, detail_blend);
}
