include <../../lib/BOSL/constants.scad>
use <../../lib/BOSL/shapes.scad>

MAGIC = 1;
$fn = 360;

module rod(
    diameter,
    height
) {
    color("beige")
    cylinder(d = diameter, h = height);
}

module nut_and_bolt(length) {
    rotate([90,0,0])
    union() {
        // stem
        cylinder(h = length, d = 5.5);

        // nut
        translate([0,0,length - 14])
        cylinder(h = 14, d = 9.5, $fn =6);

        // head
        cylinder(h = 3.5, d1 = 9.2, d2 = 5.5);
    }
}


module u_clamp(
    height,
    clamp_width,
    clamp_length,
    external_width,
    external_length,
    corner_radius,
    filleted_edges = EDGES_Z_ALL
) {

    rear_thickness = external_length - clamp_length;
    difference() {
        cuboid(
            size = [
                external_width,
                external_length,
                height
            ],
            fillet = corner_radius,
            edges = filleted_edges
        );

        translate([
            0,
            rear_thickness - clamp_length /2,
            0
        ])
        cuboid(
            size = [
                clamp_width,
                clamp_length,
                height
            ]
        );
    }
}

module mount(
    rod_diameter,
    clamp_width,
    clamp_length,
    mount_height,
    mount_thickness_x,
    mount_thickness_y,
    corner_radius
) {

    external_width = clamp_width + mount_thickness_x * 2;
    external_length = mount_thickness_y * 2;

    color("purple")
    render()
    difference() {

        translate([
            0,
            -mount_thickness_y* 1.5,
            0
        ])
        union() {
            translate([
                0,
                - clamp_length - 2 * mount_thickness_y,
                0
            ])
            u_clamp(
                height = mount_height,
                clamp_width,
                clamp_length = external_length / 2,
                external_width,
                external_length,
                corner_radius
            );

            mirror([0,1,0])
            u_clamp(
                height = mount_height,
                clamp_width,
                clamp_length = external_length / 2,
                external_width,
                external_length,
                corner_radius
            );

            translate([
                0,
                rod_diameter + mount_thickness_y/ 2,
                0
            ])
            cuboid(
                size = [
                    external_width, mount_thickness_y, mount_height
                ],
                fillet = corner_radius,
                edges = EDGES_Z_ALL
            );
        }
        translate([
            0,
            0,
            -mount_height / 2
        ])
        rod(rod_diameter, mount_height);


        for(x = [-1:2:1])
        translate([
            x * (clamp_width + mount_thickness_x) / 2,
            rod_diameter - mount_thickness_y /2,
            0
        ])
        nut_and_bolt(
            length = clamp_length + 4 * mount_thickness_y + rod_diameter
        );
    }

    for(x = [-1:2:1])
    translate([
        x * (clamp_width + mount_thickness_x) / 2,
        rod_diameter - mount_thickness_y /2,
        0
    ])
    color("silver")
    nut_and_bolt(
        length = clamp_length + 4 * mount_thickness_y + rod_diameter
    );

}

module ikea_light_adapter(
    rod_diameter,
    outer_diameter = 29,
    total_height = 50
) {
    NOTCH_DIAMETER = 4.5;
    NOTCH_OFFSET = 10;
    NOTCH_DEPTH = 3;

    BOLT_HOLE_DIAMETER = 6;

    FIT = 1;

    TOP_THICKNESS = 4;

    color("purple")
    render()
    difference() {
        cylinder(h = total_height, d = outer_diameter);
        cylinder(h = total_height - TOP_THICKNESS, d = rod_diameter + FIT);
        translate([
            NOTCH_OFFSET,
            0,
            total_height - NOTCH_DEPTH
        ])
        cylinder(h = NOTCH_DEPTH, d = NOTCH_DIAMETER);

        translate([
            0,
            0,
            total_height - TOP_THICKNESS
        ])
        cylinder(h = TOP_THICKNESS, d = BOLT_HOLE_DIAMETER);
    }

}


module workbench_lamp(
    rod_diameter,
    clamp_width,
    clamp_length,
    mount_height,
    mount_thickness_x,
    mount_thickness_y,
    corner_radius
) {
    translate([0,0, -mount_height])
    rod(rod_diameter, 100);

    mount(
        rod_diameter,
        clamp_width,
        clamp_length,
        mount_height,
        mount_thickness_x,
        mount_thickness_y,
        corner_radius
    );

    translate([
        0,
        0,
        100 - mount_height - 46
    ])
    ikea_light_adapter(rod_diameter = rod_diameter);
}

workbench_lamp(
    rod_diameter = 21,
    clamp_width = 34,
    clamp_length = 54.5,
    mount_height = 20,
    mount_thickness_x = 20,
    mount_thickness_y = 10,
    corner_radius = 5
);