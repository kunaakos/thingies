fit = 1;
psuThickness = 30;
clipWidth = 15;
clipHeight = 35;
wallThickness = 4;

innerMeasurementX = psuThickness + fit;
outerMeasurementX = psuThickness + fit + 2 * wallThickness;
outerMeasurementZ = clipHeight + wallThickness;

difference() {
    cube([clipWidth,outerMeasurementX, outerMeasurementZ]);
    translate([-1, wallThickness, wallThickness]) cube([clipWidth + 2, innerMeasurementX, clipHeight + 1]);
}
