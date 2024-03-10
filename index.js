// licensed with CC BY-NC-SA 4.0 https://creativecommons.org/licenses/by-nc-sa/4.0/
await loadScript("https://nodegl.glitch.me/function-list.js");
await loadScript("https://cdn.statically.io/gl/metagrowing/extra-shaders-for-hydra/main/lib/lib-cond.js");
await import("https://emptyfla.sh/bl4st/bundle-global.js");
const {
	sculptToHydraRenderer
} = await import("https://livecode.emptyfla.sh/hydra/all.js");
setResolution(3840, 2160);
fps = 24;
speed = 1 / 10;
flameEngine.setConfig(
	flame()
	.colorful(3 / 10)
	.exposure(2)
	.addTransform(
		transform()
		.spherical()
		.x([1, 0])
		.polar()
		.y([0, 1])
		.fisheye()
		.o([1 / 10, 1 / 10])
	)
	.addTransform(
		transform()
		.linear()
		.polar()
		.hyperbolic()
		.x(({
			time
		}) => [0, Math.sin(time)])
		.y(({
			time
		}) => [Math.cos(time), 0])
		.o([0, 0])
	)
);
flameEngine.start();
s0.init({
	src: flameEngine.canvas
});
src(s0)
	.hue("sin(time*st.y)*cos(time*st.x)")
	.diff(src(o1)
		.thresh()
		.colorama("sin(time)+cos(time)")
		.shift(glslAxis("x-y"), glslAxis("y-x")))
	.brightness(1 / 4)
	.blend(o0, 1 / 4)
	.out();
sculptToHydraRenderer(() => {
		grid(2, 1 / 5, 1 / 25);
		mixGeo(abs(sin(time)));
		box(1 / 5, 1 / 5, 1 / 25);
	})
	.out(o1);
