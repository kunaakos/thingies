include <../../lib/BOSL/shapes.scad>

MAGIC = 1;
$fn = 360;

module hose_clamp (
    hose_diam = 10,
    thickness = 1.2,
    width = 7,
    length = 28,
    fillet_radius = 3,
    screw_hole_diam = 2
) {
    hose_rad = hose_diam / 2;
    screw_hole_rad = screw_hole_diam / 2;
    clamp_rad = hose_rad + thickness;
    
    difference() {
        union() {
            // clamp body
            cylinder(
                h = width,
                r = clamp_rad,
                center = true
            );

            // base
            translate([0, - hose_rad - thickness / 2, 0])
            cuboid(
                size = [
                    length,
                    thickness,
                    width
                ],
                fillet = fillet_radius,
                edges = EDGES_Y_ALL
                );
            
            // filler
            translate([0,  - clamp_rad / 2, 0])
            cube([
                clamp_rad * 2,
                clamp_rad,
                width
            ], true);

            // outer fillet R
            translate([
                clamp_rad,
                - hose_rad,
                0
            ]) 
            rotate([0, 90, 0])
            interior_fillet( l = width, r = fillet_radius);

            // outer fillet L
            translate([
                - clamp_rad,
                - hose_rad,
                0
            ]) 
            rotate([0, -90, 0])
            interior_fillet( l = width, r = fillet_radius);
        };

        // inner fillet R
        translate([
            clamp_rad - thickness,
            - clamp_rad,
            0
        ]) 
        rotate([0, 90, 0])
        interior_fillet(l = width + MAGIC * 2, r = fillet_radius);

        // inner fillet L
        translate([
            - clamp_rad + thickness,
            - clamp_rad,
            0
        ]) 
        rotate([0, -90, 0])
        interior_fillet(l = width + MAGIC * 2, r = fillet_radius);

        // bottom cutout
        cylinder(
            h = width + MAGIC * 2,
            r = hose_rad,
            center = true
        );
        translate([0, - (clamp_rad + MAGIC) / 2 , 0])
        cube([
            hose_diam,
            clamp_rad + MAGIC,
            width + MAGIC * 2
        ], true);

        screw_hole_offset_x = length / 2 - fillet_radius;
        screw_hole_offset_y = - hose_rad - MAGIC;

        // screw_hole R
        translate([
            screw_hole_offset_x,
            screw_hole_offset_y,
            0
        ]) 
        teardrop(
            r = screw_hole_rad,
            h = thickness + MAGIC * 2,
            ang = 55
        );

        // screw_hole L
        translate([
            - screw_hole_offset_x,
            screw_hole_offset_y,
            0
        ]) 
        teardrop(
            r = screw_hole_rad,
            h = thickness + MAGIC * 2,
            ang = 55
        );
}

}

hose_clamp();
