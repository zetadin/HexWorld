shader_type spatial;

uniform sampler2D noise;
uniform float wave_height;
uniform float shadow_factor;
uniform float wave_angle;
uniform float wave_len;
uniform float wave_speed;

void vertex() {
	// Called for every vertex the material is visible on.
	float t = TIME * wave_speed;
	
	float angle_in_rad = wave_angle/(2.0*PI);
	vec2 wave_vec = vec2(cos(angle_in_rad), sin(angle_in_rad));
	vec2 pos = vec2(VERTEX.x, VERTEX.z) + t*wave_vec;
	float height = wave_height * sin((wave_vec.x*pos.x - wave_vec.y*pos.y)/wave_len);
    VERTEX.y += height;

	float neg_cos=-cos((wave_vec.x*pos.x - wave_vec.y*pos.y)/wave_len) * shadow_factor;
	NORMAL.x = wave_height * neg_cos * wave_vec.x/wave_len;
	NORMAL.z = wave_height * neg_cos * wave_vec.y/wave_len;
	NORMAL.y = 1.0;
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
	RIM = 0.2;
	ALBEDO = vec3(0.2, 0.45, 0.95); // color
	ROUGHNESS = 0.1*(1.0-fresnel);
	METALLIC = 0.0;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
