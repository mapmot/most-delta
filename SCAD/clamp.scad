r_base = 214;
h_base = 11;

r_glass = r_base;
h_glass = 4;

w_heater = 300;
h_heater = 2;

od_normal = 15;
od_compressed = 19;

r_clamp = 15;
d_clamp = r_clamp * 2;

module stage1() {
	difference() {
		union() {
			cylinder(r = r_clamp, h = h_glass + 3 * h_heater + h_base);	
			cylinder(r = r_clamp * 2, h = h_heater + h_base);
			translate ([0, 0, -h_base - 1]) cylinder(r = r_clamp * 2, h_base);
		};
	
	rotate([0,0,-45]) translate([-r_clamp, -4 / 3 * r_clamp-1, -h_base - 1])  cube([d_clamp, r_clamp, h_base]);

//!!!!!!!!!!!!!!!!!!!!!!!!!!!
	rotate([0,0,-45]) translate([-r_clamp,  -1/3 * r_clamp-2, 0])  cube([d_clamp, r_clamp, h_base]);
//!!!!!!!!!!!!!!!!!!!!!!!!!!!

	rotate([0,0,-45]) translate([-r_clamp,  -7/3 * r_clamp , -h_heater+1])  cube([d_clamp, r_clamp, h_base+h_heater-1]);

	for(i=[-1:2:1]) translate([i*r_clamp,-i*r_clamp,-1]) cylinder(d=d_clamp/3 + 1,h=h_base+h_heater+2);

	};
};

module stage2() {
	difference() {
		union() {
			stage1();
			rotate([0,0,-45]) translate([-r_clamp + 1, -4 / 3 * r_clamp, -h_base-1]) cube([d_clamp-2, r_clamp-2, h_base * 2 + h_heater]);
			
//!!!!!!!!!!!!!!!!!!!!
			rotate([0,0,-45]) translate([-r_clamp + 1,  -1/3*r_clamp-1, -h_heater])  cube([d_clamp-2, r_clamp, h_base+h_heater-1]);
//!!!!!!!!!!!!!!!!!!!!
			
			rotate([0,0,-45]) translate([-r_clamp + 1,  -7 / 3 * r_clamp-1, -h_heater-1])  cube([d_clamp-2, r_clamp, h_base+h_heater]);
			
			for(i=[-1:2:1]) translate([i * r_clamp, -i * r_clamp, -h_base + h_heater]) cylinder(d = d_clamp / 3, h = 2 * h_base);


		}
		base();
		rotate([0,0,-45]) translate([-od_compressed/2, -d_clamp-1, -h_base/2-h_heater]) cube([od_compressed, d_clamp+1, od_normal]);
		//bolt
		translate([0, 0, h_glass + 3 * h_heater + h_base]) rotate([0, 180, 0]) M3_Bolt(200);

	}
}

module clamp() {
	intersection() {
	stage2();
	translate([0,0,-100]) cylinder(r=d_clamp,h=200);
	}
}

module base() {
	//base
	translate([w_heater/2, w_heater/2, -1])color("brown") cylinder(r = r_base, h = h_base + 1);
	//heater
	color("red") translate([0, 0, h_base]) cube([w_heater, w_heater, h_heater]);
	//glass
	color("gray") translate([w_heater/2, w_heater/2, h_base + h_heater]) cylinder(r = r_glass, h = h_glass);
}

module M3_Bolt(len = 10) {
	color("black") cylinder(d = 5, h = 2.9);	
	color("black") cylinder(d = 3, h = len);	
}

clamp();

//rotate([0, 180, 0]) M3_Bolt();