shader_type spatial;
render_mode cull_disabled;

uniform float wave_size : hint_range(0.0, 10.0) = 1.0;
uniform float face_distortion : hint_range(0.0, 1.0) = 0.5;
uniform vec2 time_scale = vec2(0.3, 0.0);
uniform vec2 uv_offset_scale = vec2(-0.2, -0.1);

uniform sampler2D uv_offset_texture : hint_default_black;
uniform sampler2D albedo_texture : hint_default_white;
uniform bool use_texture_alpha = false;

// New uniform to control the center-focused displacement
uniform float center_focus : hint_range(0.1, 10.0) = 2.0;


void vertex() {
    // Sample Noise
    vec2 base_uv_offset = UV * uv_offset_scale;
    base_uv_offset += TIME * time_scale;
    float noise = texture(uv_offset_texture, base_uv_offset).r;
    
    // Calculate offset
    float texture_based_offset = noise * 2.0 - 1.0; // Convert from 0.0  1.0 to -1.0  1.0
    texture_based_offset *= wave_size; // Apply amplitude
    
    // Calculate center-focused dampening (bell curve-like effect)
    // Using UV.x centered around 0.5 (range 0-1) to create a parabola
    float centered_uv = (UV.x - 0.5) * 2.0; // Convert to -1 to 1 range
    float center_focus_factor = 1.0 - pow(abs(centered_uv), center_focus);
    
    // Apply dampening - strongest at edges, weakest at center
    texture_based_offset *= center_focus_factor;
    
    VERTEX.y += texture_based_offset;
    
    VERTEX.z += texture_based_offset * face_distortion;
    VERTEX.x += texture_based_offset * -face_distortion;
}


void fragment() {
    // Sample albedo texture
    vec4 tex_color = texture(albedo_texture, UV);
    
    if (use_texture_alpha) {
        ALPHA = tex_color.a;
    } else {
        ALPHA = 1.0;
    }
    
    ALBEDO = tex_color.rgb;
}