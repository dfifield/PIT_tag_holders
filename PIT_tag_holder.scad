// Dave Fifield, Apr, 2022
// dave.fifield@ec.gc.ca

// Module to produce PIT tag holder
//
// OR = leg hole outside radius
// IR = leg hole inside radius
// height = height of band
// PIR = PIT hole inner radius
// POR = PIT hole outer radius
// PCO = center of PIT hole on x-axis
// do_slit = should slit be inserted in band. Slits often don't print
//   well so it's probably better to just cut them with a scalpel.
// slit_width = width of the slit
module do_band(OR, IR, height, PIR, POR, PCO, do_slit, slit_width) {
  band_thickness = OR - IR;
  union(){
    // first do leg band
    difference() {
      // outer cylinder
      color("Red") 
        cylinder(h=height, r=OR, center = false, $fn=72);
          
      // inner empty space
      color("Blue") 
        cylinder(h=height, r=IR, center = false, $fn=72);    
      
      // Do we want a slit in the band?
      if (do_slit) {
        translate([IR - (0.25 * band_thickness), -0.5 * slit_width, 0.2])
          cube([1.5 * band_thickness, slit_width, 1.2 * height]);
      }
    }
    
    // now do pit tag holder
    translate([PCO,0,0]) {
      difference() {
        // outer cylinder
        color("Green")
          cylinder(h=height, r=POR, center=false, $fn = 72);

        // innder cylinder

        color("Blue")
        // try closing top end of pit tag cylinder
          translate([0,0,0.5])
            cylinder(h=height, r=PIR, center=false, $fn = 72);
      }
    }
  }
}

// Example  dimensions for Leach's Storm-Petrel using 10mm x 2.12mm 
// glass PIT tag.

// All units are in mm
band_height = 11; // Length of band along the leg
IR = 1.5;  // Bird leg hole radius
thickness = 0.75; // Bird leg hole wall thickness
OR = IR + thickness; // Bird leg hole outer radius

PIR = 1.3;            // PIT tag holder inside radius
P_thick = 0.6;        // Thickness of pit tag hole walls
POR = PIR + P_thick;  // pit tag holder outer radius
PCO = -1 * (OR + PIR); // offset from 0 on x-axis to center of pit tag holder
do_slit = false;
slit_width = 0;

do_band(OR = OR, IR = IR, height = band_height, PIR = PIR, POR = POR, PCO = PCO, slit_width = slit_width, do_slit = do_slit);