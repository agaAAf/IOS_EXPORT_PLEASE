shader_type spatial;
render_mode diffuse_toon,specular_toon,cull_disabled;
uniform sampler2D iChannel0 : source_color;
uniform int samples =100;
uniform float x;
uniform float y;
uniform float z;
//
//
uniform float alpha_cut ;
uniform float gain = 1.0; // gain : (gain), min = 0., max = 50.
//
uniform float blur_x =50.0; // X blur : (X blur), min = 0, max = 1000.
uniform float blur_y = 50.0; // Y blur : (Y blur), min = 0, max = 1000.
uniform float Rot_Angle : hint_range(0.0, 100.0, 0.1);
uniform float Metal : hint_range(0.0, 1.0, 0.1);
//
//
//

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
	float cosa = cos(rotation);
	float sina = sin(rotation);
	uv -= pivot;
	return vec2(
		cosa * uv.x - sina * uv.y,
		cosa * uv.y + sina * uv.x
	) + pivot;
}


vec2 rotate(vec2 uv, vec2 p, float angle)
{
	mat2 rotation = mat2(vec2(cos(angle), -sin(angle)),vec2(sin(angle), cos(angle)));
	uv -= p;
	uv = uv * rotation;
	uv += p;
	return uv;
}

void fragment(){
	float Angle = Rot_Angle/-100.0;
	vec2 uv = UV;
	vec2 origin;
	float precompute = Angle * (1.0 / float(samples - 1));
	origin = vec2(0.5,0.5);
    vec4 color = vec4(0.0);
    float ws = 0.0;
	vec2 center = vec2(0.5,0.5);
	for(int i = 0; i <= samples; i++)
    {
		float p =  (float(i)* precompute);
		float w = 1.0 ;
        color += texture(iChannel0, rotate(uv,origin, p)) * w;
        ws += w;
    }

	ALBEDO = vec4(color.rgb / ws * gain, 1.0).rgb;
	//ALPHA = vec4(color.rgb / ws * gain, 1.0).r;
	ALPHA = step(alpha_cut,1.0 - distance(center,UV));
	METALLIC = Metal;
}
mat3 rotateX(float theta)
{

	float cosa = cos(theta);
	float sina = sin(theta);


    //Y rotation
	mat3 rotate_x  = mat3(
	   vec3(1.0, 0.0, 0.0),
	   vec3(0.0, cosa, -sina),
	   vec3(0.0, sina, cosa)
	);

	return rotate_x;
}





mat3 rotateY(float theta)
{

	float cosa = cos(theta);
	float sina = sin(theta);


    //Y rotation
	mat3 rotate_y  = mat3(
	   vec3(cosa, 0.0, sina),
	   vec3(0.0, 1.0, 0.0),
	   vec3(-sina, 0.0, cosa)
	);

	return rotate_y;
}



mat3 rotateZ(float theta)
{

	float cosa = cos(theta);
	float sina = sin(theta);


    //Y rotation
	mat3 rotate_z  = mat3(
	   vec3(cosa,-sina, 0.0),
	   vec3(sina, cosa, 0.0),
	   vec3(0.0, 0.0, 1.0)
	);

	return rotate_z;
}


void vertex()
{


	mat3 rotation_matrix =  rotateX(x) * rotateY(y) * rotateZ(z);
	vec3 rotated_vertex =  rotation_matrix * VERTEX;
	vec3 rotated_normals =  rotation_matrix * NORMAL;

	VERTEX =  rotated_vertex;
	NORMAL =  rotated_normals;


}