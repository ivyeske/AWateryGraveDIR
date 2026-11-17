shader_type canvas_item;

uniform vec4 vignette_colour: source_color;
uniform float max_alpha: hint_range(0.0, 1.0, 0.001) = 1.0;

uniform float eccentricity: hint_range(2.0, 20.0, 0.01) = 2;
uniform float inner_radius: hint_range(0.0, 1.0, 0.001) = 0.5;
uniform float outer_radius: hint_range(1.0, 2.0, 0.001) = 1.0;
uniform float gradient_sharpness: hint_range(0.0, 1.0, 0.001) = 0.0;

float draw_deformed_circle(vec2 uv){
	float xcomponent = pow(abs((2.0 * uv.x - 1.0)), eccentricity);
	float ycomponent = pow(abs((2.0 * uv.y - 1.0)), eccentricity);
	
	return (pow(xcomponent + ycomponent, 2.0/eccentricity));
}

void fragment() {
	vec4 text = vignette_colour;
	float bounds = smoothstep(inner_radius, outer_radius, draw_deformed_circle(UV));
	bounds = pow(bounds, 1.0 - gradient_sharpness);
	text.a = bounds * max_alpha;
	COLOR = text;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
