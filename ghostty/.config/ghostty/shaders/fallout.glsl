// RobCo Industries - Tactical Terminal Shader v2.0
// Designed for Ghosty
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    
    // ۱. انحنای مانیتور (CRT Curvature) - قوی‌تر برای حس قدیمی بودن
    vec2 centered_uv = uv * 2.0 - 1.0;
    centered_uv *= 1.0 + pow(length(centered_uv) * 0.15, 2.0); // شدت انحنا
    uv = centered_uv * 0.5 + 0.5;

    // ۲. بریدن لبه‌های بیرون از انحنا (Black borders)
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }

    // ۳. خواندن رنگ اصلی و اعمال رنگ سبز تیره (Amber-Green)
    vec4 color = texture(iChannel0, uv);
    // رنگ سبز فسفری تیره شده
    vec3 greenTint = vec3(0.1, 0.8, 0.1) * color.rgb; 

    // ۴. اسکن‌لاین نرم و سابتل (Subtle Scanlines)
    // استفاده از فرکانس بالاتر و شدت کمتر برای اذیت نکردن چشم
    float scanline = 0.03 * sin(uv.y * iResolution.y * 0.8);
    greenTint -= scanline;

    // ۵. فلیکر بسیار ضعیف (Micro-flicker)
    float flicker = 0.98 + 0.02 * sin(iTime * 60.0);
    
    // ۶. درخشش و تاریکی لبه‌ها (Deep Vignette) - برای تاریک‌تر شدن محیط
    float vignette = 16.0 * uv.x * uv.y * (1.0 - uv.x) * (1.0 - uv.y);
    vignette = pow(vignette, 0.4); // لبه‌های نرم و تاریک

    // ۷. ترکیب نهایی با کنتراست بالا
    vec3 finalColor = greenTint * flicker * vignette;
    
    // اضافه کردن کمی درخشش (Glow) به متن‌های روشن
    finalColor += greenTint * 0.15; 

    fragColor = vec4(finalColor, color.a);
}
