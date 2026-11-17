shader_type canvas_item;
render_mode blend_disabled;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float blend_amount : hint_range(0.0, 1.0) = 1.0;

vec3 overlay_blend(vec3 base, vec3 blend) {
    vec3 low  = 2.0 * base * blend;
    vec3 high = 1.0 - 2.0 * (1.0 - base) * (1.0 - blend);
    return mix(low, high, step(0.5, base));
}

void fragment() {
    vec4 bg  = textureLod(screen_texture, SCREEN_UV, 0.0);
    vec4 src = COLOR;

    float as = src.a;
    float ab = bg.a;

    vec3 blended = overlay_blend(bg.rgb, src.rgb);
    blended = mix(bg.rgb, blended, blend_amount);

    vec3 Co = as * (1.0 - ab) * src.rgb + as * ab * blended + (1.0 - as) * ab * bg.rgb;
    float ao = as + ab * (1.0 - as);

    COLOR.rgb = ao > 0.0 ? Co / ao : vec3(0.0);
    COLOR.a = ao;
}