shader_type sky;

render_mode use_half_res_pass;

uniform vec3 topSkyDay : source_color;
uniform vec3 horizionSkyDay : source_color;

void sky() {
	float colorGradient = clamp(EYEDIR.y, 0.0, 1.0);
	vec3 skyColorDay = mix(horizionSkyDay, topSkyDay, colorGradient);
	COLOR = skyColorDay;
}
