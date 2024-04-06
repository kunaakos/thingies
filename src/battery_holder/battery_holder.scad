MAGIC = 1;

module contact_slot(
    wall_thickness,
    contact_slot_height,
    contact_slot_width,
    contact_slot_depth,
    contact_slot_gap
) {
    difference() {
        cube([
            contact_slot_width,
            contact_slot_depth,
            contact_slot_height
        ]);
        translate([
            0,
            0,
            - MAGIC
        ]) 
        cube([
            contact_slot_width - wall_thickness / 2 ,
            contact_slot_depth - wall_thickness,
            contact_slot_height + MAGIC * 2
        ]);
        translate([
            (contact_slot_width - contact_slot_gap) / 2,
            contact_slot_depth - wall_thickness - MAGIC,
            -MAGIC
        ]) 
        cube([
            contact_slot_gap,
            wall_thickness + MAGIC * 2,
            contact_slot_height + MAGIC * 2
        ]);
    }

}

module battery_holder(
    batteries_width = 20.5,
    batteries_length = 45,
    wall_thickness = 1,
    contact_slot_depth = 2.2,
    contact_slot_gap = 6.5,
    box_height =  8,
) {

    external_width = batteries_width + wall_thickness * 2;
    external_length = batteries_length + wall_thickness * 2 + contact_slot_depth * 2;
    difference() {
        cube([
            external_width,
            external_length,
            box_height
        ]);
        translate([
            wall_thickness,
            wall_thickness,
            - MAGIC
        ]) 
        cube([
            batteries_width,
            batteries_length + contact_slot_depth * 2,
            box_height  + MAGIC * 2
        ]);
    }

    for(iy = [0 : 1])
    mirror([
        0,
        iy,
        0
    ])
    translate([
        0,
        - iy * external_length
    ]) 
    union() {
        for(ix = [0 : 1])
        translate([
            wall_thickness + ix * batteries_width,
            wall_thickness
        ]) 
        mirror([-ix,0,0]) 
        contact_slot(
            wall_thickness = wall_thickness,
            contact_slot_height = box_height,
            contact_slot_width = batteries_width / 2,
            contact_slot_depth = contact_slot_depth,
            contact_slot_gap = contact_slot_gap
        );
    }
}

battery_holder();
