include <../../lib/BOSL/constants.scad>
use <../../lib/BOSL/shapes.scad>

$fn = 360;

module cabinet_lock_handle(
    cylinder_diam = 11.8,
    cuboid_diam = 11.5,
    cylinder_height = 16.8,
    front_plate_diam = 15.65,
    front_plate_thickness = 12,
    stub_diam = 8,
    stub_corner_radius = 1.5,
    stub_height = 2,
    threaded_insert_diam = 4,
    threaded_insert_depth = 20,
    rot_stop_height = 2.5,
    rot_stop_thickness = 1,
    rot_stop_width = 4,
    handle_length = 30,
    handle_thickness = 6
) {
    difference() {
        // positives
        union() {
            translate([
                0,
                - handle_length / 2 + front_plate_diam / 2,
                0
            ]) 
            cuboid(
                size=[
                    front_plate_diam,
                    handle_length,
                    handle_thickness
                ],
                fillet = front_plate_diam / 2,
                edges = EDGES_Z_ALL,
                align = V_BELOW
            );
            // front plate
            cylinder(
                h = front_plate_thickness,
                r = front_plate_diam / 2
            );

            // cylindroid with rotation stop
            intersection() {
                translate([
                    0,
                    0,
                    front_plate_thickness
                ]) 
                cylinder(
                    h = cylinder_height,
                    r = cylinder_diam / 2
                );
                translate([
                    0,
                    0,
                    front_plate_thickness + cylinder_height / 2
                ]) 
                cube ([
                    cuboid_diam,
                    cuboid_diam,
                    cylinder_height        
                ], true);
            }
            rotate([0,0,-90])
            translate([
                0,
                - cuboid_diam / 2 + rot_stop_thickness / 2,
                front_plate_thickness + rot_stop_height / 2
            ]) 
            cube([
                rot_stop_width,
                rot_stop_thickness * 2,
                rot_stop_height
            ], true);

            //lock plate interface
            translate([
                0,
                0,
                cylinder_height + front_plate_thickness
            ])
            cuboid(
                size = [stub_diam, stub_diam, stub_height],
                align = V_TOP,
                fillet = stub_corner_radius,
                edges = EDGES_Z_ALL
            );
        }

        // threaded insert
        translate([
            0,
            0,
            front_plate_thickness + cylinder_height + stub_diam - threaded_insert_depth
        ]) 
        cylinder(
            h = threaded_insert_depth,
            r = threaded_insert_diam / 2
        );
    }

}

cabinet_lock_handle();
