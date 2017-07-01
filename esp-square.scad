//21.55x28.01
w=22.7;
h=28.9;
z=8;
rim=0.08;
text="ftl";
fontsize=10;

difference() {
 cube([w*(1+rim),h*(1+rim),z]);
 translate([w*rim/2,h*rim/2,3.3]){
  cube([w,h,z]);
 }    

// seat
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
 neoport=7;
 translate([(w*(1+rim)/2)-(neoport/2),-0.1,0.3]){
  cube([neoport,(h*rim)+1,z]);
 }    

 // usb port
 usb_width=8;
 translate([(w*(1+rim)/2)-(usb_width/2),h,z*0.2]){
  cube([usb_width,(h*rim)+1,z]);
 }    
}

// text
//translate([w/3,2,0]) {
//    linear_extrude(height = 1) {
//      text(text, size = fontsize, font = "Verdana");
//    }
//}
