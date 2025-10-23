shader_type spatial;

uniform sampler2D albedo_texture : source_color, filter_nearest;
uniform vec4 input_color1 : source_color;
uniform vec4 output_color1 : source_color;

uniform vec4 input_color2 : source_color;
uniform vec4 output_color2 : source_color;

uniform vec4 input_color3 : source_color;
uniform vec4 output_color3 : source_color;

uniform vec4 input_color4 : source_color;
uniform vec4 output_color4 : source_color;

uniform vec4 input_color5 : source_color;
uniform vec4 output_color5 : source_color;

uniform vec4 input_color6 : source_color;
uniform vec4 output_color6 : source_color;

uniform vec4 input_color7 : source_color;
uniform vec4 output_color7 : source_color;

uniform vec4 input_color8 : source_color;
uniform vec4 output_color8 : source_color;

uniform vec4 input_color9 : source_color;
uniform vec4 output_color9 : source_color;

bool colorMatch(vec4 c1, vec4 c2, float maxDiff) {
    return (
        abs(c1.r - c2.r) < maxDiff
        && abs(c1.g - c2.g) < maxDiff
        && abs(c1.b - c2.b) < maxDiff
    );
}

void fragment() {

	vec4[] input_colors = {
		input_color1,
		input_color2,
		input_color3,
		input_color4,
		input_color5,
		input_color6,
		input_color7,
		input_color8,
		input_color9
	};

	vec4[] output_colors = {
		output_color1,
		output_color2,
		output_color3,
		output_color4,
		output_color5,
		output_color6,
		output_color7,
		output_color8,
		output_color9
	};

	vec4 current_color = texture(albedo_texture, UV);

	for(int cr = 0; cr < input_colors.length(); cr++){
		if (colorMatch(current_color, input_colors[cr], 0.1)){
			ALBEDO = output_colors[cr].rgb;
			break; }
		else (ALBEDO = vec3(0,0,1));
		}
	}
