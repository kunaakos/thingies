$fn = 144;

include <../../lib/BOSL/constants.scad>
use <../../lib/BOSL/shapes.scad>

BASE_LENGTH = 42;
BASE_WIDTH = 26.5;
BASE_THICKNESS = 3;
BASE_CORNER_RADIUS = 8;

CLIP_THICKNESS = 7;
CLIP_HEIGHT = 15;
CLIP_CORNER_RADIUS = 2;

SLOT_WIDTH = 4;
SLOT_LENGTH = BASE_LENGTH - 4;
SLOT_CORNER_RADIUS = 0.5;
SLOT_OFFSET_Y = 1;
SLOT_GAP = BASE_LENGTH - 24;

module clip_base() {
    difference() {
        union() {
            cuboid(
                [
                    BASE_LENGTH,
                    BASE_WIDTH - CLIP_THICKNESS,
                    BASE_THICKNESS
                ],
                fillet=BASE_CORNER_RADIUS,
                edges=EDGE_FR_RT+EDGE_FR_LF,
                align=V_ABOVE+V_FRONT
            );
            cuboid(
                [
                    BASE_LENGTH,
                    CLIP_THICKNESS,
                    CLIP_HEIGHT
                ],
                fillet=CLIP_CORNER_RADIUS,
                edges=EDGE_BK_RT+EDGE_BK_LF,
                align=V_ABOVE+V_REAR
            );


        }
        translate(
            [
                0,
                SLOT_OFFSET_Y,
                -1
            ]
        )
        cuboid(
            [
                SLOT_LENGTH,
                SLOT_WIDTH,
                CLIP_HEIGHT +2,
            ],
            align=V_ABOVE+V_REAR,
            fillet=SLOT_CORNER_RADIUS,
            edges=EDGES_Z_ALL
        );
        translate(
            [
                0,
                SLOT_OFFSET_Y+SLOT_WIDTH -1,
                -1
            ]
        )
        cuboid(
            [
                SLOT_GAP,
                CLIP_THICKNESS,
                CLIP_HEIGHT +2,
            ],
            align=V_ABOVE+V_REAR
        );
    }

}

SCREW_SLOT_WIDTH = 12;
SCREW_SLOT_LENGTH = 14;
SCREW_HEAD_SUNK = 1;
SCREW_SLOT_BRIM = 4;

module screw_slot() {
    translate([0,0,-0.9])
    cuboid(
        [
            SCREW_SLOT_WIDTH,
            SCREW_SLOT_LENGTH,
            SCREW_HEAD_SUNK + 1
        ],
        align=V_ABOVE,
        fillet = (SCREW_SLOT_WIDTH / 2) -0.01,
        edges=EDGES_Z_ALL
    );
    translate([0, 0, SCREW_HEAD_SUNK])
    cuboid(
        [
            SCREW_SLOT_WIDTH - SCREW_SLOT_BRIM * 2,
            SCREW_SLOT_LENGTH - SCREW_SLOT_BRIM * 2,
            5
        ],
        align=V_ABOVE,
        fillet = ((SCREW_SLOT_WIDTH - SCREW_SLOT_BRIM * 2) / 2) -0.01,
        edges=EDGES_Z_ALL
    );
}

SCREW_HOLE_SIDE_OFFSET = 5;
SCREW_HOLE_FRONT_OFFSET = 3;
SCREW_HOLE_Y_OFFSET = -1 * (BASE_WIDTH - SCREW_HOLE_FRONT_OFFSET - SCREW_SLOT_LENGTH / 2 - CLIP_THICKNESS);

color("white")
difference() {
    clip_base();
    translate([
        BASE_LENGTH / 2 - SCREW_HOLE_SIDE_OFFSET - SCREW_SLOT_WIDTH / 2,
        SCREW_HOLE_Y_OFFSET
    ])
    screw_slot();
    translate([
        -1 * (BASE_LENGTH / 2 - SCREW_HOLE_SIDE_OFFSET - SCREW_SLOT_WIDTH / 2),
        SCREW_HOLE_Y_OFFSET
    ])
    screw_slot();
}
