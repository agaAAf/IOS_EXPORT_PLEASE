/*
   Radial Blur Effect by Yui Kinomoto
   Modified to increase blur toward edges with adjustable falloff
   MIT License
*/
shader_type canvas_item;

uniform vec2 blur_center = vec2(0.5, 0.5);
uniform float blur_power : hint_range(0.0, 1.0) = 0.01;
uniform int sampling_count : hint_range(1, 64) = 6;
uniform float falloff : hint_range(0.1, 5.0) = 1.0; // New: controls edge fade
uniform sampler2D texturescreen : hint_screen_texture;

void fragment()
{
    // Vector from center to current pixel
    vec2 direction = SCREEN_UV - blur_center;

    // Distance from center normalized so corners ≈ 1
    float dist = distance(SCREEN_UV, blur_center) / 0.707;
    dist = clamp(dist, 0.0, 1.0);

    // Apply falloff curve
    float edgeStrength = pow(dist, falloff);

    // Accumulate samples with scaled blur near edges
    vec3 c = vec3(0.0);
    float f = 1.0 / float(sampling_count);
    for (int i = 0; i < sampling_count; i++) {
        c += texture(texturescreen,
                     SCREEN_UV - blur_power * edgeStrength * direction * float(i)).rgb * f;
    }

    COLOR.rgb = c;
}
