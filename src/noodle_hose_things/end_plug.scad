$fn = 360;

module end_plug(
    w1 = 4.5,
    w2 = 5.5,
    handle_radius = 4,
    handle_length =  5,
    stem_length = 7,
    plug_length = 4, 
) { 
    translate([0,0, handle_length]) 
    union () {
        // handle
        translate([0, 0, -handle_length])
        cylinder(
            h = handle_length,
            r = handle_radius
        );
        // stem
        cylinder(
            h = stem_length,
            r = w1 / 2
        );
        // plug
        translate([0, 0, stem_length]) 
        cylinder(
            h = plug_length,
            r1 = w2 / 2,
            r2 = w2 / 5
        );

        //plug support
        translate([0, 0, stem_length - plug_length / 9]) 
        cylinder(
            h = plug_length / 9,
            r1 = w1 / 2,
            r2 = w2 / 2
        );

        // plug
        translate([0, 0, stem_length / 2.5]) 
        cylinder(
            h = plug_length,
            r1 = w2 / 2,
            r2 = w2 / 5
        );

        //plug support
        translate([0, 0, stem_length / 2.5 - plug_length / 9]) 
        cylinder(
            h = plug_length / 9,
            r1 = w1 / 2,
            r2 = w2 / 2
        );
    };
}

end_plug();
