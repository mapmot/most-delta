include <belt_pulley.scad>;
include <cog.scad>;
//cog(GT2,36,10);
translate([0,0,0]) color("red") belt_line(belt_profile=GT2_2mm_belt_profile, belt_length=100, belt_width=6);

GT2 = [
	2, // p, pitch (mm) -- 0
	1.38, // hs, total belt height (mm) -- 1
	0.764, // ht, tooth height (mm) -- 2
	1.494, // s, tooth root width (mm) -- 3
	40, // g, tooth flank angle (deg) -- 4
	0.476, // ra, tip radius connecting tooth flank to tooth tip (mm) -- 5
	0.469,// rr, root radius connecting tooth flank to belt root line (mm) -- 6
	1.339, // w_scale, factor applied to scale tooth width -- 7
	1 // h_scale, factor applied to scale tooth height -- 8
];


	rotate([0, 0, 0])  dog_linear(GT2, 50, 2, 6, 1);

