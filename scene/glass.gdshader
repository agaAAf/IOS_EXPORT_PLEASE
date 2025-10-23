shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx, blend_mix;

group_uniforms albedo;
uniform vec4 albedo : source_color = vec4(1.0, 1.0, 1.0, 0.0);
uniform sampler2D albedo_texture : source_color, hint_default_white;

uniform vec3 glass_color_ref:source_color = vec3(0.2, 0.4, 0.8); // Approx color of glass
uniform float threshold = 0.2; // How strict the mask is

uniform float alpha_cut;

group_uniforms roughness;
uniform float roughness : hint_range(0.0, 1.0) = 0.15;
uniform sampler2D roughness_texture : hint_roughness_r;

group_uniforms normal;
uniform float normal_strength : hint_range(-16.0, 16.0) = 1.0;
uniform sampler2D normal_map : hint_normal;

uniform float glass_alpha : hint_range(0.0, 1.0) = 0.5; // How transparent the glass is

group_uniforms misc;
uniform vec4 edge_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

float SchlickFresnel(float u) {
	float m = 1.0 - u;
	float m2 = m * m;
	return m2 * m2 * m;
}

void fragment() {
	// calculate fresnel values
	float VdotN = dot(VIEW, NORMAL);
	float fresnel = clamp(SchlickFresnel(VdotN), 0.0, 1.0);
	
	// sample and mix textures
	vec4 _albedo = texture(albedo_texture, UV) * albedo;
	float _roughness = texture(roughness_texture, UV).r * roughness;
	
	// apply glass look
	float a = mix(0.001, 1.0, _albedo.a);
	ALPHA = mix(fresnel * edge_color.a, 1.0, a);
	ALBEDO = mix(edge_color.rgb * edge_color.a, _albedo.rgb, a);
	vec2 center = vec2(0.5,0.5);
	float color_diff = distance(_albedo.rgb, glass_color_ref);
	float mask = step(threshold, color_diff);
	ALPHA = mix(glass_alpha, 1.0, mask);
	ROUGHNESS = _roughness;
	NORMAL_MAP = texture(normal_map, UV).xyz;
	NORMAL_MAP_DEPTH = normal_strength;
	
	// function to compensate specular for alpha blend
	// 0.5 * ALPHA^-0.5
	SPECULAR = 0.5 * inversesqrt(ALPHA);
}