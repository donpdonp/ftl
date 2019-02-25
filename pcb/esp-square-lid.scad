//21.55x28.01
w=22.7;
h=28.9;
z=0.5;
rim=0.08;
text="ftl";
fontsize=10;

difference() {
 union() {
  cube([w*(1+rim),h*(1+rim),z]);
  translate([w*rim/2,h*rim/2,-0.6]){
   cube([w,h,z*2]);
  }    
 }
 
 // screwholes
 screw_r=2;
 screw_h=4;
 translate([w*(rim)+(screw_r/2),h*rim+(screw_r/2),-1]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }
 translate([w*(1-rim)+(screw_r/2),h*rim+(screw_r/2),-1]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }
 translate([w*(rim)+(screw_r/2),h*(1-rim)+(screw_r/2),-1]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }
 translate([w*(1-rim)+(screw_r/2),h*(1-rim)+(screw_r/2),-1]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }

 
}

// text
translate([w*0.25,2,0]) {
    linear_extrude(height = 1) {
      text(text, size = fontsize, font = "Verdana");
    }
}
