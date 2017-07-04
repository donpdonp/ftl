//21.55x28.01
w=22.7;
h=28.9;
z=6;
rim=0.08;
text="ftl";
fontsize=10;

difference() {
 cube([w*(1+rim),h*(1+rim),z]);

// filler    
 translate([w*rim/2,h*rim/2,3.3]){
  cube([w,h,z]);
 }    

// pin seat
 pinseatw=4;
 pinseath=14;
 translate([w*rim-0.1, h*rim*3.5, 0]){
  cube([pinseatw,pinseath,z]);
 }    

// ESP seat
 seatw=13;
 seath=16;
 translate([(w*(1+rim)/2)-(seatw/2),(h*(1+rim)/2)-(seath/2),0.3]){
  cube([seatw,seath,z]);
 }    
 
 //side door
 //translate([-0.01,h/1.8,0.3]){
 // cube([(w*rim),(h*rim*2)+1,z]);
 //}    
 
 // neoport
 neoport=8;
 translate([(w*(1+rim)/2)-(neoport/2),-0.1,0.3]){
  cube([neoport,(h*rim)+2,z]);
 }    

 // usb port
 usb_width=8;
 translate([(w*(1+rim)/1.9)-(usb_width/2),h,z*0.2]){
  cube([usb_width,(h*rim)+1,z]);
 }    
 
 // screwholes
 screw_r=2;
 screw_h=4;
 translate([w*(rim)+(screw_r/2),h*rim+(screw_r/2),0]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }
 translate([w*(1-rim)+(screw_r/2),h*rim+(screw_r/2),0]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }
 translate([w*(rim)+(screw_r/2),h*(1-rim)+(screw_r/2),0]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }
 translate([w*(1-rim)+(screw_r/2),h*(1-rim)+(screw_r/2),0]) {
     cylinder(h=screw_h, r=screw_r, $fn=10);
 }
}

// text
//translate([w/3,2,0]) {
//    linear_extrude(height = 1) {
//      text(text, size = fontsize, font = "Verdana");
//    }
//}
